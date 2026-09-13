-- migrate:up
-- =====================================================================
-- 001 foundation
--
-- Why:   shared building blocks every later migration relies on.
-- What:  pg_trgm (search indexes), updated_at trigger, audit log, the
--        role-hierarchy check, and the require_* guards that raise the
--        standard error keys.
-- Calls: nothing here is callable by app clients except is_org_member.
-- Keys:  NOT_SIGNED_IN, NOT_AUTHORISED
--
-- Conventions used by the whole schema
--   * Every table has RLS enabled. Clients never write to tables directly:
--     all writes go through SECURITY DEFINER functions ("RPCs").
--   * RPCs raise `exception 'KEY'` with a bare, stable, UPPER_SNAKE key.
--     The client maps keys to translated messages; anything else is a bug.
--   * search_path = public, extensions, pg_temp. `extensions` is where
--     Supabase keeps pgcrypto and pg_trgm; without it gen_random_bytes and
--     the trigram opclass are not resolvable.
--   * Function privileges are set explicitly with grant_rpc()/lock_fn()
--     because the platform's default privileges grant EXECUTE to anon and
--     authenticated on every new function.
-- =====================================================================

create extension if not exists pg_trgm with schema extensions;

-- ------------------------------------------------------------ helpers

create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end $$;

-- Explicit privilege management. p_public = true also allows anon.
create or replace function public.grant_rpc(p_sig text, p_public boolean default false)
returns void language plpgsql as $$
begin
  execute format('revoke all on function %s from public, anon, authenticated', p_sig);
  execute format('grant execute on function %s to authenticated', p_sig);
  if p_public then
    execute format('grant execute on function %s to anon', p_sig);
  end if;
end $$;

create or replace function public.lock_fn(p_sig text)
returns void language plpgsql as $$
begin
  execute format('revoke all on function %s from public, anon, authenticated', p_sig);
end $$;

-- ------------------------------------------------------------ audit log
-- Append-only record of every privileged action. Never readable by clients.

create table public.audit_log (
  id           bigint generated always as identity primary key,
  actor_id     uuid,
  action       text not null,
  target_type  text not null,
  target_id    uuid,
  detail       jsonb,
  at           timestamptz not null default now()
);
create index audit_log_target_idx on public.audit_log (target_type, target_id);
create index audit_log_actor_idx  on public.audit_log (actor_id, at desc);
alter table public.audit_log enable row level security;
revoke all on public.audit_log from public, anon, authenticated;

create or replace function public.log_action(
  p_action text, p_target_type text, p_target_id uuid, p_detail jsonb default null)
returns void language sql security definer set search_path = public, extensions, pg_temp as $$
  insert into public.audit_log (actor_id, action, target_type, target_id, detail)
  values (auth.uid(), p_action, p_target_type, p_target_id, p_detail);
$$;

-- ------------------------------------------------------------ guards
create or replace function public.require_user()
returns uuid language plpgsql stable as $$
declare v uuid := auth.uid();
begin
  if v is null then raise exception 'NOT_SIGNED_IN'; end if;
  return v;
end $$;

create or replace function public.require_role(p_org uuid, p_min_role text)
returns uuid language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v uuid := public.require_user();
begin
  if not public.is_org_member(p_org, p_min_role) then raise exception 'NOT_AUTHORISED'; end if;
  return v;
end $$;

-- ------------------------------------------------------------ privileges
-- dbmate creates public.schema_migrations before this file runs, so it
-- inherits Supabase's default grants; clients have no business reading it.
revoke all on public.schema_migrations from public, anon, authenticated;

select public.lock_fn('public.set_updated_at()');
select public.lock_fn('public.grant_rpc(text,boolean)');
select public.lock_fn('public.lock_fn(text)');
select public.lock_fn('public.log_action(text,text,uuid,jsonb)');
select public.lock_fn('public.require_user()');
select public.lock_fn('public.require_role(uuid,text)');

-- migrate:down
drop function if exists public.require_role(uuid,text);
drop function if exists public.require_user();
drop function if exists public.log_action(text,text,uuid,jsonb);
drop table if exists public.audit_log;
drop function if exists public.lock_fn(text);
drop function if exists public.grant_rpc(text,boolean);
drop function if exists public.set_updated_at();
