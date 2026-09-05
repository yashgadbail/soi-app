-- migrate:up
-- =====================================================================
-- 006 pledges and the Impact Passport
--
-- Why:   organisations publish pledges (a commitment people sign, often
--        for a campaign). Signing takes seconds and is NOT volunteering:
--        pledges and certified hours are kept visibly separate everywhere.
-- What:  pledges, pledge_signatures, the certificate FK, and RPCs:
--        create_pledge, update_pledge, set_pledge_status, delete_pledge,
--        sign_pledge, pledge_detail, pledge_signers, org_pledges,
--        my_passport.
-- Calls: pledge_detail is public (anon). Everything else authenticated.
-- Keys:  NOT_SIGNED_IN, NOT_AUTHORISED, TITLE_TOO_SHORT, TITLE_TOO_LONG,
--        BODY_TOO_SHORT, BODY_TOO_LONG, CAMPAIGN_TOO_LONG, PLEDGE_NOT_FOUND,
--        PLEDGE_CLOSED, PLEDGE_ALREADY_SIGNED, PLEDGE_HAS_SIGNATURES,
--        BAD_STATUS
--
-- Design notes
--   * Once anyone has signed, the pledge body is locked: everyone who
--     signed agreed to those exact words. A signed pledge cannot be
--     deleted, only closed.
--   * Signing mints a certificate of kind 'pledge' (no hours).
-- =====================================================================

create table public.pledges (
  id          uuid primary key default gen_random_uuid(),
  org_id      uuid not null references public.organisations on delete cascade,
  title       text not null,
  campaign    text,
  body        text not null,
  share_code  text not null unique check (share_code ~ '^[0-9A-F]{6}$'),
  status      text not null default 'active' check (status in ('active','closed')),
  created_by  uuid references auth.users on delete set null,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index pledges_org_idx on public.pledges (org_id, created_at desc);
alter table public.pledges enable row level security;
create policy pledges_select on public.pledges
  for select using (status = 'active' or public.is_org_member(org_id));
create trigger pledges_touch before update on public.pledges
  for each row execute function public.set_updated_at();

create table public.pledge_signatures (
  id            uuid primary key default gen_random_uuid(),
  pledge_id     uuid not null references public.pledges on delete cascade,
  user_id       uuid not null references public.profiles on delete cascade,
  signature_no  int  not null,
  signed_at     timestamptz not null default now(),
  unique (pledge_id, user_id),
  unique (pledge_id, signature_no)
);
create index pledge_signatures_user_idx on public.pledge_signatures (user_id, signed_at desc);
alter table public.pledge_signatures enable row level security;
create policy pledge_signatures_select_own on public.pledge_signatures
  for select using (user_id = auth.uid());

alter table public.certificates
  add constraint certificates_pledge_signature_fk
  foreign key (pledge_signature_id) references public.pledge_signatures on delete set null;

-- ------------------------------------------------------------ helpers
create or replace function public.mint_share_code()
returns text language plpgsql as $$
declare v text;
begin
  loop
    v := upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 6));
    exit when not exists (select 1 from public.pledges where share_code = v);
  end loop;
  return v;
end $$;

create or replace function public.check_pledge_fields(p_title text, p_body text, p_campaign text)
returns void language plpgsql immutable as $$
begin
  if length(btrim(coalesce(p_title, ''))) < 5    then raise exception 'TITLE_TOO_SHORT'; end if;
  if length(btrim(p_title)) > 120                then raise exception 'TITLE_TOO_LONG'; end if;
  if length(btrim(coalesce(p_body, ''))) < 20    then raise exception 'BODY_TOO_SHORT'; end if;
  if length(btrim(p_body)) > 2000                then raise exception 'BODY_TOO_LONG'; end if;
  if length(coalesce(p_campaign, '')) > 60       then raise exception 'CAMPAIGN_TOO_LONG'; end if;
end $$;

-- ------------------------------------------------------------ RPCs

-- create_pledge(org, title, body, campaign) -> {id, share_code}   (coordinator)
create or replace function public.create_pledge(p_org uuid, p_title text, p_body text, p_campaign text default null)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_uid uuid := public.require_role(p_org, 'coordinator'); v_id uuid; v_code text;
begin
  perform public.check_pledge_fields(p_title, p_body, p_campaign);
  v_code := public.mint_share_code();
  insert into public.pledges (org_id, title, campaign, body, share_code, created_by)
  values (p_org, btrim(p_title), nullif(btrim(p_campaign), ''), btrim(p_body), v_code, v_uid)
  returning id into v_id;
  perform public.log_action('pledge.create', 'pledge', v_id);
  return json_build_object('id', v_id, 'share_code', v_code);
end $$;

-- update_pledge(id, title, body, campaign) -> {id, signatures}   (coordinator)
create or replace function public.update_pledge(p_id uuid, p_title text, p_body text, p_campaign text default null)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare p public.pledges; v_sigs int;
begin
  select * into p from public.pledges where id = p_id;
  if p.id is null then raise exception 'PLEDGE_NOT_FOUND'; end if;
  perform public.require_role(p.org_id, 'coordinator');
  perform public.check_pledge_fields(p_title, p_body, p_campaign);
  select count(*) into v_sigs from public.pledge_signatures where pledge_id = p_id;
  if v_sigs > 0 and btrim(p_body) <> p.body then raise exception 'PLEDGE_ALREADY_SIGNED'; end if;
  update public.pledges
     set title = btrim(p_title), campaign = nullif(btrim(p_campaign), ''), body = btrim(p_body)
   where id = p_id;
  perform public.log_action('pledge.update', 'pledge', p_id);
  return json_build_object('id', p_id, 'signatures', v_sigs);
end $$;

-- set_pledge_status(id, status) -> {id, status}   (coordinator)
create or replace function public.set_pledge_status(p_id uuid, p_status text)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_org uuid;
begin
  if p_status not in ('active','closed') then raise exception 'BAD_STATUS'; end if;
  select org_id into v_org from public.pledges where id = p_id;
  if v_org is null then raise exception 'PLEDGE_NOT_FOUND'; end if;
  perform public.require_role(v_org, 'coordinator');
  update public.pledges set status = p_status where id = p_id;
  perform public.log_action('pledge.status', 'pledge', p_id, json_build_object('status', p_status)::jsonb);
  return json_build_object('id', p_id, 'status', p_status);
end $$;

-- delete_pledge(id) -> void   (coordinator; refused once signed)
create or replace function public.delete_pledge(p_id uuid)
returns void language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_org uuid;
begin
  select org_id into v_org from public.pledges where id = p_id;
  if v_org is null then raise exception 'PLEDGE_NOT_FOUND'; end if;
  perform public.require_role(v_org, 'coordinator');
  if exists (select 1 from public.pledge_signatures where pledge_id = p_id) then
    raise exception 'PLEDGE_HAS_SIGNATURES';
  end if;
  delete from public.pledges where id = p_id;
  perform public.log_action('pledge.delete', 'pledge', p_id);
end $$;

-- sign_pledge(share_code) -> {pledge_id, pledge_title, signature_no, signed_at,
--                             certificate_code, already}
create or replace function public.sign_pledge(p_share_code text)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid  uuid := public.require_user();
  p      public.pledges;
  sig    public.pledge_signatures;
  v_cert text;
  v_org  text;
  v_name text;
  v_new  boolean := false;
begin
  select * into p from public.pledges where share_code = upper(btrim(coalesce(p_share_code, ''))) for update;
  if p.id is null then raise exception 'PLEDGE_NOT_FOUND'; end if;

  select * into sig from public.pledge_signatures where pledge_id = p.id and user_id = v_uid;
  if sig.id is null then
    if p.status <> 'active' then raise exception 'PLEDGE_CLOSED'; end if;
    insert into public.pledge_signatures (pledge_id, user_id, signature_no)
    values (p.id, v_uid, (select coalesce(max(signature_no), 0) + 1 from public.pledge_signatures where pledge_id = p.id))
    returning * into sig;

    select o.name into v_org from public.organisations o where o.id = p.org_id;
    select coalesce(nullif(btrim(pr.full_name), ''), 'Volunteer') into v_name from public.profiles pr where pr.id = v_uid;
    v_cert := public.mint_certificate_code();
    insert into public.certificates
      (code, kind, user_id, pledge_signature_id, org_id, subject_name, org_name, title, hours)
    values (v_cert, 'pledge', v_uid, sig.id, p.org_id, v_name, v_org, p.title, null);
    v_new := true;
    perform public.log_action('pledge.sign', 'pledge', p.id);
  else
    select code into v_cert from public.certificates where pledge_signature_id = sig.id;
  end if;

  return json_build_object(
    'pledge_id', p.id, 'pledge_title', p.title, 'signature_no', sig.signature_no,
    'signed_at', sig.signed_at, 'certificate_code', v_cert, 'already', not v_new);
end $$;

-- pledge_detail(share_code) -> json   (public; my_signature only when signed in)
create or replace function public.pledge_detail(p_share_code text)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v_uid uuid := auth.uid(); p public.pledges; o public.organisations; v json;
begin
  select * into p from public.pledges where share_code = upper(btrim(coalesce(p_share_code, '')));
  if p.id is null then raise exception 'PLEDGE_NOT_FOUND'; end if;
  select * into o from public.organisations where id = p.org_id;
  select json_build_object(
    'id', p.id, 'org_id', o.id, 'org_name', o.name, 'org_verified', o.verification_tier >= 2,
    'title', p.title, 'campaign', p.campaign, 'body', p.body, 'status', p.status,
    'share_code', p.share_code, 'created_at', p.created_at,
    'signatures', (select count(*) from public.pledge_signatures s where s.pledge_id = p.id),
    'can_manage', v_uid is not null and public.is_org_member(p.org_id, 'coordinator'),
    'my_signature', (select json_build_object('signature_no', s.signature_no, 'signed_at', s.signed_at,
                                              'certificate_code', c.code)
                     from public.pledge_signatures s
                     left join public.certificates c on c.pledge_signature_id = s.id
                     where s.pledge_id = p.id and s.user_id = v_uid))
    into v;
  return v;
end $$;

-- pledge_signers(id) -> [{name, signature_no, signed_at}]   (coordinator; no contact details)
create or replace function public.pledge_signers(p_id uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v_org uuid; v json;
begin
  select org_id into v_org from public.pledges where id = p_id;
  if v_org is null then raise exception 'PLEDGE_NOT_FOUND'; end if;
  perform public.require_role(v_org, 'coordinator');
  select coalesce(json_agg(json_build_object(
           'name', coalesce(nullif(btrim(pr.full_name), ''), 'Volunteer'),
           'signature_no', s.signature_no, 'signed_at', s.signed_at)
         order by s.signature_no desc), '[]'::json)
    into v
  from public.pledge_signatures s
  left join public.profiles pr on pr.id = s.user_id
  where s.pledge_id = p_id;
  return v;
end $$;

-- org_pledges(org) -> [{id, title, campaign, body, share_code, status, created_at, signatures}]
create or replace function public.org_pledges(p_org uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v json;
begin
  perform public.require_role(p_org, 'coordinator');
  select coalesce(json_agg(json_build_object(
           'id', p.id, 'title', p.title, 'campaign', p.campaign, 'body', p.body,
           'share_code', p.share_code, 'status', p.status, 'created_at', p.created_at,
           'signatures', (select count(*) from public.pledge_signatures s where s.pledge_id = p.id))
         order by p.created_at desc), '[]'::json)
    into v
  from public.pledges p
  where p.org_id = p_org;
  return v;
end $$;

-- my_passport() -> {certified_hours, pending_hours, certified_drives,
--                   attendance:[...], pledges:[...]}
-- One call for the whole Passport screen. Includes cancelled drives and
-- rejected rows so nothing silently disappears from a person's history.
create or replace function public.my_passport()
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v_uid uuid := public.require_user(); v json;
begin
  select json_build_object(
    'certified_hours', coalesce((select sum(hours) from public.attendance where user_id = v_uid and status = 'certified'), 0),
    'pending_hours',   coalesce((select sum(hours) from public.attendance where user_id = v_uid and status = 'pending'), 0),
    'certified_drives', (select count(*) from public.attendance where user_id = v_uid and status = 'certified'),
    'attendance', coalesce((select json_agg(json_build_object(
        'attendance_id', a.id, 'drive_id', d.id, 'drive_title', d.title, 'starts_at', d.starts_at,
        'drive_status', d.status, 'org_id', o.id, 'org_name', o.name,
        'hours', a.hours, 'status', a.status, 'method', a.method,
        'check_in_at', a.check_in_at, 'certified_at', a.certified_at,
        'certificate_code', c.code)
      order by a.check_in_at desc)
      from public.attendance a
      join public.drives d on d.id = a.drive_id
      join public.organisations o on o.id = d.org_id
      left join public.certificates c on c.attendance_id = a.id
      where a.user_id = v_uid), '[]'::json),
    'pledges', coalesce((select json_agg(json_build_object(
        'pledge_id', p.id, 'title', p.title, 'campaign', p.campaign, 'share_code', p.share_code,
        'org_name', o.name, 'signature_no', s.signature_no, 'signed_at', s.signed_at,
        'certificate_code', c.code)
      order by s.signed_at desc)
      from public.pledge_signatures s
      join public.pledges p on p.id = s.pledge_id
      join public.organisations o on o.id = p.org_id
      left join public.certificates c on c.pledge_signature_id = s.id
      where s.user_id = v_uid), '[]'::json))
    into v;
  return v;
end $$;

-- ------------------------------------------------------------ privileges
select public.lock_fn('public.mint_share_code()');
select public.lock_fn('public.check_pledge_fields(text,text,text)');
select public.grant_rpc('public.create_pledge(uuid,text,text,text)');
select public.grant_rpc('public.update_pledge(uuid,text,text,text)');
select public.grant_rpc('public.set_pledge_status(uuid,text)');
select public.grant_rpc('public.delete_pledge(uuid)');
select public.grant_rpc('public.sign_pledge(text)');
select public.grant_rpc('public.pledge_detail(text)', true);
select public.grant_rpc('public.pledge_signers(uuid)');
select public.grant_rpc('public.org_pledges(uuid)');
select public.grant_rpc('public.my_passport()');

-- migrate:down
drop function if exists public.my_passport();
drop function if exists public.org_pledges(uuid);
drop function if exists public.pledge_signers(uuid);
drop function if exists public.pledge_detail(text);
drop function if exists public.sign_pledge(text);
drop function if exists public.delete_pledge(uuid);
drop function if exists public.set_pledge_status(uuid,text);
drop function if exists public.update_pledge(uuid,text,text,text);
drop function if exists public.create_pledge(uuid,text,text,text);
drop function if exists public.check_pledge_fields(text,text,text);
drop function if exists public.mint_share_code();
alter table public.certificates drop constraint if exists certificates_pledge_signature_fk;
drop table if exists public.pledge_signatures;
drop table if exists public.pledges;
