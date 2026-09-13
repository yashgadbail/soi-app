-- migrate:up
-- =====================================================================
-- 002 identity: profiles, organisations, memberships, invites
--
-- Why:   who a user is and which organisations they may act for.
-- What:  profiles (1:1 with auth.users), organisations, org_members,
--        org_invites, the signup trigger, and the organisation RPCs.
-- Calls: authenticated only, except organisations SELECT which is public.
-- Keys:  NOT_SIGNED_IN, NOT_AUTHORISED, NAME_TOO_SHORT, NAME_TOO_LONG,
--        ABOUT_TOO_LONG, CITY_TOO_LONG, BAD_TYPE, BAD_ROLE, BAD_EMAIL,
--        ORG_NOT_FOUND, MEMBER_NOT_FOUND, CANNOT_REMOVE_OWNER, SOLE_OWNER,
--        INVITE_NOT_FOUND
--
-- Design notes
--   * There is no role column on profiles. Authority is derived from
--     org_members only.
--   * Owner rows are minted only by create_organisation(). Admins can add
--     admins/coordinators/members, never owners.
--   * profiles are readable only by their owner. Coordinators see volunteer
--     names through roster() (migration 004), never emails.
--   * verification_tier is set by the platform operator in the database,
--     never by an app client. There is deliberately no RPC for it.
-- =====================================================================

-- ------------------------------------------------------------ profiles
create table public.profiles (
  id          uuid primary key references auth.users on delete cascade,
  full_name   text,
  email       text,
  city        text,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index profiles_email_idx on public.profiles (lower(email));
alter table public.profiles enable row level security;
create policy profiles_select_own on public.profiles
  for select using (id = auth.uid());
create trigger profiles_touch before update on public.profiles
  for each row execute function public.set_updated_at();

-- ------------------------------------------------------------ organisations
create table public.organisations (
  id                 uuid primary key default gen_random_uuid(),
  type               text not null check (type in ('ngo','school','corporate')),
  name               text not null,
  about              text,
  city               text,
  verification_tier  int  not null default 0 check (verification_tier between 0 and 3),
  created_by         uuid references auth.users on delete set null,
  created_at         timestamptz not null default now(),
  updated_at         timestamptz not null default now()
);
create index organisations_name_trgm_idx on public.organisations
  using gin (name extensions.gin_trgm_ops);
alter table public.organisations enable row level security;
create policy organisations_select_public on public.organisations
  for select using (true);
create trigger organisations_touch before update on public.organisations
  for each row execute function public.set_updated_at();

-- ------------------------------------------------------------ org_members
create table public.org_members (
  org_id      uuid not null references public.organisations on delete cascade,
  user_id     uuid not null references public.profiles on delete cascade,
  role        text not null default 'member'
              check (role in ('owner','admin','coordinator','member')),
  created_at  timestamptz not null default now(),
  primary key (org_id, user_id)
);
create index org_members_user_idx on public.org_members (user_id);
alter table public.org_members enable row level security;

-- ------------------------------------------------------------ authority
-- Defined here (not in 001) because SQL-language bodies are validated at
-- creation time and must see org_members.
-- Membership is the unit of authority. Role hierarchy:
--   owner > admin > coordinator > member

create or replace function public.is_org_member(p_org uuid, p_min_role text default 'member')
returns boolean language sql stable security definer set search_path = public, extensions, pg_temp as $$
  select exists (
    select 1 from public.org_members m
    where m.org_id = p_org
      and m.user_id = auth.uid()
      and case p_min_role
            when 'owner'       then m.role = 'owner'
            when 'admin'       then m.role in ('owner','admin')
            when 'coordinator' then m.role in ('owner','admin','coordinator')
            else true
          end
  );
$$;

-- is_org_member is referenced by RLS policies evaluated as the calling role.
select public.grant_rpc('public.is_org_member(uuid,text)', true);

create policy org_members_select on public.org_members
  for select using (user_id = auth.uid() or public.is_org_member(org_id, 'admin'));

-- ------------------------------------------------------------ org_invites
-- Invitations by email. Accepted automatically when the invitee signs up
-- (trigger below) or immediately when an existing user is invited.
create table public.org_invites (
  id           uuid primary key default gen_random_uuid(),
  org_id       uuid not null references public.organisations on delete cascade,
  email        text not null,
  role         text not null check (role in ('admin','coordinator','member')),
  invited_by   uuid references auth.users on delete set null,
  created_at   timestamptz not null default now(),
  accepted_at  timestamptz,
  accepted_by  uuid,
  unique (org_id, email)
);
create index org_invites_email_idx on public.org_invites (email) where accepted_at is null;
alter table public.org_invites enable row level security;
revoke all on public.org_invites from public, anon, authenticated;

-- ------------------------------------------------------------ signup trigger
-- Creates the profile row and accepts any pending invites for that email.
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_email text := lower(new.email);
  v_name  text := nullif(btrim(coalesce(new.raw_user_meta_data->>'full_name', '')), '');
begin
  insert into public.profiles (id, email, full_name)
  values (new.id, v_email, v_name)
  on conflict (id) do nothing;

  insert into public.org_members (org_id, user_id, role)
  select i.org_id, new.id, i.role
  from public.org_invites i
  where lower(i.email) = v_email and i.accepted_at is null
  on conflict (org_id, user_id) do nothing;

  update public.org_invites
     set accepted_at = now(), accepted_by = new.id
   where lower(email) = v_email and accepted_at is null;

  return new;
end $$;

create trigger t1_profile_on_signup
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ------------------------------------------------------------ validation
create or replace function public.check_email(p_email text)
returns text language plpgsql immutable as $$
declare v text := lower(btrim(coalesce(p_email, '')));
begin
  if v !~* '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]{2,}$' or length(v) > 120 then
    raise exception 'BAD_EMAIL';
  end if;
  return v;
end $$;

-- ------------------------------------------------------------ RPCs

-- my_profile() -> {id, email, full_name, city, created_at, needs_name}
create or replace function public.my_profile()
returns json language sql stable security definer set search_path = public, extensions, pg_temp as $$
  select json_build_object(
    'id', p.id, 'email', p.email, 'full_name', p.full_name, 'city', p.city,
    'created_at', p.created_at,
    'needs_name', (coalesce(btrim(p.full_name), '') = ''))
  from public.profiles p
  where p.id = public.require_user();
$$;

-- my_memberships() -> [{org_id, org_name, org_type, verification_tier, role, city}]
create or replace function public.my_memberships()
returns json language sql stable security definer set search_path = public, extensions, pg_temp as $$
  select coalesce(json_agg(json_build_object(
           'org_id', o.id, 'org_name', o.name, 'org_type', o.type,
           'verification_tier', o.verification_tier, 'role', m.role,
           'city', o.city)
         order by o.name), '[]'::json)
  from public.org_members m
  join public.organisations o on o.id = m.org_id
  where m.user_id = public.require_user();
$$;

-- create_organisation(name, type, about, city) -> {id}
-- The caller becomes owner. Verification tier starts at 0 (unverified).
create or replace function public.create_organisation(
  p_name text, p_type text default 'ngo', p_about text default null, p_city text default null)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid  uuid := public.require_user();
  v_name text := btrim(coalesce(p_name, ''));
  v_id   uuid;
begin
  if length(v_name) < 3  then raise exception 'NAME_TOO_SHORT'; end if;
  if length(v_name) > 80 then raise exception 'NAME_TOO_LONG'; end if;
  if p_type not in ('ngo','school','corporate') then raise exception 'BAD_TYPE'; end if;
  if length(coalesce(p_about, '')) > 1000 then raise exception 'ABOUT_TOO_LONG'; end if;
  if length(coalesce(p_city, ''))  > 60   then raise exception 'CITY_TOO_LONG'; end if;

  insert into public.organisations (type, name, about, city, created_by)
  values (p_type, v_name, nullif(btrim(p_about), ''), nullif(btrim(p_city), ''), v_uid)
  returning id into v_id;

  insert into public.org_members (org_id, user_id, role) values (v_id, v_uid, 'owner');
  perform public.log_action('organisation.create', 'organisation', v_id,
                            json_build_object('type', p_type)::jsonb);
  return json_build_object('id', v_id);
end $$;

-- update_organisation(org, name, about, city) -> {id}   (admin)
create or replace function public.update_organisation(
  p_org uuid, p_name text, p_about text default null, p_city text default null)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_name text := btrim(coalesce(p_name, ''));
begin
  perform public.require_role(p_org, 'admin');
  if length(v_name) < 3  then raise exception 'NAME_TOO_SHORT'; end if;
  if length(v_name) > 80 then raise exception 'NAME_TOO_LONG'; end if;
  if length(coalesce(p_about, '')) > 1000 then raise exception 'ABOUT_TOO_LONG'; end if;
  if length(coalesce(p_city, ''))  > 60   then raise exception 'CITY_TOO_LONG'; end if;

  update public.organisations
     set name = v_name, about = nullif(btrim(p_about), ''), city = nullif(btrim(p_city), '')
   where id = p_org;
  if not found then raise exception 'ORG_NOT_FOUND'; end if;
  perform public.log_action('organisation.update', 'organisation', p_org);
  return json_build_object('id', p_org);
end $$;

-- invite_org_member(org, email, role) -> {status:'ok'}   (admin)
-- Uniform response whether or not the email already has an account, so the
-- call cannot be used to probe which emails are registered.
create or replace function public.invite_org_member(p_org uuid, p_email text, p_role text)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid   uuid := public.require_role(p_org, 'admin');
  v_email text := public.check_email(p_email);
  v_user  uuid;
begin
  if p_role not in ('admin','coordinator','member') then raise exception 'BAD_ROLE'; end if;

  select id into v_user from public.profiles where lower(email) = v_email;

  insert into public.org_invites (org_id, email, role, invited_by, accepted_at, accepted_by)
  values (p_org, v_email, p_role, v_uid,
          case when v_user is null then null else now() end, v_user)
  on conflict (org_id, email) do update
    set role = excluded.role, invited_by = excluded.invited_by,
        accepted_at = excluded.accepted_at, accepted_by = excluded.accepted_by;

  if v_user is not null then
    insert into public.org_members (org_id, user_id, role) values (p_org, v_user, p_role)
    on conflict (org_id, user_id) do update
      set role = excluded.role
      where public.org_members.role <> 'owner';
  end if;

  perform public.log_action('organisation.invite', 'organisation', p_org,
                            json_build_object('role', p_role)::jsonb);
  return json_build_object('status', 'ok');
end $$;

-- cancel_invite(org, email) -> void   (admin)
create or replace function public.cancel_invite(p_org uuid, p_email text)
returns void language plpgsql security definer set search_path = public, extensions, pg_temp as $$
begin
  perform public.require_role(p_org, 'admin');
  delete from public.org_invites
   where org_id = p_org and email = lower(btrim(p_email)) and accepted_at is null;
  if not found then raise exception 'INVITE_NOT_FOUND'; end if;
end $$;

-- remove_org_member(org, user) -> void   (admin; owners cannot be removed)
create or replace function public.remove_org_member(p_org uuid, p_user uuid)
returns void language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_role text;
begin
  perform public.require_role(p_org, 'admin');
  select role into v_role from public.org_members where org_id = p_org and user_id = p_user;
  if v_role is null then raise exception 'MEMBER_NOT_FOUND'; end if;
  if v_role = 'owner' then raise exception 'CANNOT_REMOVE_OWNER'; end if;
  delete from public.org_members where org_id = p_org and user_id = p_user;
  perform public.log_action('organisation.remove_member', 'organisation', p_org,
                            json_build_object('user_id', p_user)::jsonb);
end $$;

-- leave_org(org) -> void   (any member; the last owner cannot leave)
create or replace function public.leave_org(p_org uuid)
returns void language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid  uuid := public.require_user();
  v_role text;
begin
  select role into v_role from public.org_members where org_id = p_org and user_id = v_uid;
  if v_role is null then raise exception 'MEMBER_NOT_FOUND'; end if;
  if v_role = 'owner'
     and (select count(*) from public.org_members where org_id = p_org and role = 'owner') = 1 then
    raise exception 'SOLE_OWNER';
  end if;
  delete from public.org_members where org_id = p_org and user_id = v_uid;
  perform public.log_action('organisation.leave', 'organisation', p_org);
end $$;

-- org_members_list(org) -> [{user_id, name, email, role, joined_at}]   (admin)
create or replace function public.org_members_list(p_org uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v json;
begin
  perform public.require_role(p_org, 'admin');
  select coalesce(json_agg(json_build_object(
           'user_id', m.user_id, 'name', p.full_name, 'email', p.email,
           'role', m.role, 'joined_at', m.created_at)
         order by case m.role when 'owner' then 0 when 'admin' then 1 when 'coordinator' then 2 else 3 end,
                  p.full_name), '[]'::json)
    into v
  from public.org_members m
  join public.profiles p on p.id = m.user_id
  where m.org_id = p_org;
  return v;
end $$;

-- org_invites_list(org) -> [{email, role, created_at}]   (admin; pending only)
create or replace function public.org_invites_list(p_org uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v json;
begin
  perform public.require_role(p_org, 'admin');
  select coalesce(json_agg(json_build_object('email', i.email, 'role', i.role, 'created_at', i.created_at)
                  order by i.created_at desc), '[]'::json)
    into v
  from public.org_invites i
  where i.org_id = p_org and i.accepted_at is null;
  return v;
end $$;

-- delete_my_account() -> void
-- Removes the auth user; profiles/memberships/registrations cascade.
-- Certificates keep their snapshot and stay verifiable (user_id -> null),
-- matching the public deletion policy: deleting an account does not
-- retract a certificate an organisation issued.
create or replace function public.delete_my_account()
returns void language plpgsql security definer set search_path = public, extensions, auth, pg_temp as $$
declare v_uid uuid := public.require_user();
begin
  perform public.log_action('account.delete', 'profile', v_uid);
  delete from auth.users where id = v_uid;
end $$;

-- ------------------------------------------------------------ privileges
select public.lock_fn('public.handle_new_user()');
select public.lock_fn('public.check_email(text)');
select public.grant_rpc('public.my_profile()');
select public.grant_rpc('public.my_memberships()');
select public.grant_rpc('public.create_organisation(text,text,text,text)');
select public.grant_rpc('public.update_organisation(uuid,text,text,text)');
select public.grant_rpc('public.invite_org_member(uuid,text,text)');
select public.grant_rpc('public.cancel_invite(uuid,text)');
select public.grant_rpc('public.remove_org_member(uuid,uuid)');
select public.grant_rpc('public.leave_org(uuid)');
select public.grant_rpc('public.org_members_list(uuid)');
select public.grant_rpc('public.org_invites_list(uuid)');
select public.grant_rpc('public.delete_my_account()');

-- migrate:down
drop function if exists public.delete_my_account();
drop function if exists public.org_invites_list(uuid);
drop function if exists public.org_members_list(uuid);
drop function if exists public.leave_org(uuid);
drop function if exists public.remove_org_member(uuid,uuid);
drop function if exists public.cancel_invite(uuid,text);
drop function if exists public.invite_org_member(uuid,text,text);
drop function if exists public.update_organisation(uuid,text,text,text);
drop function if exists public.create_organisation(text,text,text,text);
drop function if exists public.my_memberships();
drop function if exists public.my_profile();
drop function if exists public.check_email(text);
drop function if exists public.handle_new_user();
drop table if exists public.org_invites;
drop function if exists public.is_org_member(uuid,text);
drop table if exists public.org_members;
drop table if exists public.organisations;
drop table if exists public.profiles;
