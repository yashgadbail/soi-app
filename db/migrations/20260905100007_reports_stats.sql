-- migrate:up
-- =====================================================================
-- 007 content reports and public statistics
--
-- Why:   Google Play's UGC policy requires a way to report listings, and
--        the landing page shows live platform numbers.
-- What:  content_reports + report_content(); soi_stats().
-- Calls: soi_stats is public (anon). report_content authenticated.
-- Keys:  NOT_SIGNED_IN, BAD_TARGET, BAD_REASON, TOO_MANY_REPORTS
-- =====================================================================

create table public.content_reports (
  id           uuid primary key default gen_random_uuid(),
  target_type  text not null check (target_type in ('drive','organisation','pledge')),
  target_id    uuid not null,
  reporter_id  uuid references auth.users on delete set null,
  reason       text not null check (length(reason) between 3 and 500),
  status       text not null default 'open' check (status in ('open','reviewing','resolved')),
  created_at   timestamptz not null default now()
);
create index content_reports_open_idx on public.content_reports (created_at desc) where status = 'open';
alter table public.content_reports enable row level security;
revoke all on public.content_reports from public, anon, authenticated;

-- report_content(type, id, reason) -> {id}
create or replace function public.report_content(p_target_type text, p_target_id uuid, p_reason text)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_uid uuid := public.require_user(); v_id uuid;
begin
  if p_target_type not in ('drive','organisation','pledge') or p_target_id is null then
    raise exception 'BAD_TARGET';
  end if;
  if length(btrim(coalesce(p_reason, ''))) < 3 or length(btrim(p_reason)) > 500 then
    raise exception 'BAD_REASON';
  end if;
  if (select count(*) from public.content_reports
      where reporter_id = v_uid and created_at > now() - interval '1 day') >= 20 then
    raise exception 'TOO_MANY_REPORTS';
  end if;
  insert into public.content_reports (target_type, target_id, reporter_id, reason)
  values (p_target_type, p_target_id, v_uid, btrim(p_reason))
  returning id into v_id;
  return json_build_object('id', v_id);
end $$;

-- soi_stats() -> {organisations, drives, certified_hours, volunteers, pledges}   (public)
-- Consumed by the landing page (web/index.html) and the Welcome screen.
-- The store-review organisation (fixed id, see 008) is never counted.
create or replace function public.soi_stats()
returns json language sql stable security definer set search_path = public, extensions, pg_temp as $$
  select json_build_object(
    'organisations',   (select count(*) from public.organisations
                         where id <> '44444444-4444-4444-4444-444444444444'),
    'drives',          (select count(*) from public.drives
                         where status in ('published','completed')
                           and org_id <> '44444444-4444-4444-4444-444444444444'),
    'certified_hours', coalesce((select sum(hours) from public.attendance where status = 'certified'), 0),
    'volunteers',      (select count(*) from public.profiles),
    'pledges',         (select count(*) from public.pledge_signatures));
$$;

select public.grant_rpc('public.report_content(text,uuid,text)');
select public.grant_rpc('public.soi_stats()', true);

-- migrate:down
drop function if exists public.soi_stats();
drop function if exists public.report_content(text,uuid,text);
drop table if exists public.content_reports;
