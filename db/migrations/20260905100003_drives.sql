-- migrate:up
-- =====================================================================
-- 003 drives: drives, check-in codes, registrations, discovery
--
-- Why:   a "drive" is a volunteering event run by an organisation. This
--        migration owns its lifecycle, its secret check-in code, public
--        discovery (search + filters + pagination) and registrations.
-- What:  drives, drive_checkin_codes, registrations; RPCs create_drive,
--        update_drive, cancel_drive, get_checkin_code, rotate_checkin_code,
--        discover_drives, discover_facets, register_for_drive,
--        cancel_registration, my_upcoming_drives.
-- Calls: discover_* are public (anon). Everything else authenticated.
-- Keys:  NOT_SIGNED_IN, NOT_AUTHORISED, TITLE_TOO_SHORT, TITLE_TOO_LONG,
--        DESCRIPTION_TOO_LONG, CAUSE_TOO_LONG, VENUE_TOO_LONG, CITY_TOO_LONG,
--        END_BEFORE_START, STARTS_IN_PAST, BAD_CAPACITY, BAD_HOURS,
--        DRIVE_NOT_FOUND, DRIVE_NOT_OPEN, DRIVE_ENDED, DRIVE_FULL,
--        NOT_REGISTERED
--
-- Design notes
--   * The check-in code is a secret. It lives in drive_checkin_codes, a
--     table no client role can read; it is handed out only by
--     get_checkin_code() to coordinators of the owning organisation.
--     Never put it on a readable table.
--   * Clients never write to drives or registrations. The old schema's
--     permissive write policies let a coordinator set 1000 default hours
--     with a plain update; here the only path is the validated RPC.
--   * Registration is capacity-checked under a row lock so two people
--     cannot both take the last spot.
--   * discover_drives is SECURITY DEFINER and therefore filters
--     status = 'published' explicitly; RLS does not apply inside it.
-- =====================================================================

-- ------------------------------------------------------------ drives
create table public.drives (
  id             uuid primary key default gen_random_uuid(),
  org_id         uuid not null references public.organisations on delete cascade,
  title          text not null,
  description    text,
  cause          text,
  venue          text,
  city           text,
  starts_at      timestamptz not null,
  ends_at        timestamptz not null,
  capacity       int     not null default 50 check (capacity between 1 and 5000),
  default_hours  numeric(5,2) not null default 4 check (default_hours > 0 and default_hours <= 12),
  status         text not null default 'published'
                 check (status in ('draft','published','completed','cancelled')),
  created_by     uuid references auth.users on delete set null,
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now(),
  check (ends_at > starts_at)
);
create index drives_open_idx       on public.drives (ends_at) where status = 'published';
create index drives_org_idx        on public.drives (org_id, starts_at desc);
create index drives_city_idx       on public.drives (lower(city)) where status = 'published';
create index drives_cause_idx      on public.drives (cause) where status = 'published';
create index drives_title_trgm_idx on public.drives using gin (title extensions.gin_trgm_ops);
alter table public.drives enable row level security;
create policy drives_select on public.drives
  for select using (status = 'published' or public.is_org_member(org_id));
create trigger drives_touch before update on public.drives
  for each row execute function public.set_updated_at();

-- ------------------------------------------------------------ check-in codes
create table public.drive_checkin_codes (
  drive_id    uuid primary key references public.drives on delete cascade,
  code        uuid not null default gen_random_uuid(),
  rotated_at  timestamptz not null default now()
);
alter table public.drive_checkin_codes enable row level security;
revoke all on public.drive_checkin_codes from public, anon, authenticated;

create or replace function public.mint_checkin_code()
returns trigger language plpgsql security definer set search_path = public, extensions, pg_temp as $$
begin
  insert into public.drive_checkin_codes (drive_id) values (new.id) on conflict do nothing;
  return new;
end $$;
create trigger drives_mint_code after insert on public.drives
  for each row execute function public.mint_checkin_code();

-- ------------------------------------------------------------ registrations
create table public.registrations (
  id          uuid primary key default gen_random_uuid(),
  drive_id    uuid not null references public.drives on delete cascade,
  user_id     uuid not null references public.profiles on delete cascade,
  status      text not null default 'confirmed' check (status in ('confirmed','cancelled')),
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),
  unique (drive_id, user_id)
);
create index registrations_drive_idx on public.registrations (drive_id) where status = 'confirmed';
create index registrations_user_idx  on public.registrations (user_id);
alter table public.registrations enable row level security;
create policy registrations_select_own on public.registrations
  for select using (user_id = auth.uid());
create trigger registrations_touch before update on public.registrations
  for each row execute function public.set_updated_at();

-- ------------------------------------------------------------ validation
create or replace function public.check_drive_fields(
  p_title text, p_starts timestamptz, p_ends timestamptz, p_desc text, p_cause text,
  p_venue text, p_city text, p_capacity int, p_hours numeric, p_allow_past boolean)
returns void language plpgsql stable as $$
begin
  if length(btrim(coalesce(p_title, ''))) < 5   then raise exception 'TITLE_TOO_SHORT'; end if;
  if length(btrim(p_title)) > 120               then raise exception 'TITLE_TOO_LONG'; end if;
  if length(coalesce(p_desc, ''))  > 4000       then raise exception 'DESCRIPTION_TOO_LONG'; end if;
  if length(coalesce(p_cause, '')) > 40         then raise exception 'CAUSE_TOO_LONG'; end if;
  if length(coalesce(p_venue, '')) > 160        then raise exception 'VENUE_TOO_LONG'; end if;
  if length(coalesce(p_city, ''))  > 60         then raise exception 'CITY_TOO_LONG'; end if;
  if p_ends is null or p_starts is null or p_ends <= p_starts then raise exception 'END_BEFORE_START'; end if;
  if not p_allow_past and p_starts < now() - interval '1 hour' then raise exception 'STARTS_IN_PAST'; end if;
  if p_capacity is null or p_capacity < 1 or p_capacity > 5000 then raise exception 'BAD_CAPACITY'; end if;
  if p_hours is null or p_hours <= 0 or p_hours > 12 then raise exception 'BAD_HOURS'; end if;
end $$;

-- ------------------------------------------------------------ RPCs

-- create_drive(...) -> {id}   (coordinator of org)
create or replace function public.create_drive(
  p_org uuid, p_title text, p_starts timestamptz, p_ends timestamptz,
  p_description text default null, p_cause text default null, p_venue text default null,
  p_city text default null, p_capacity int default 50, p_hours numeric default 4)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid uuid := public.require_role(p_org, 'coordinator');
  v_id  uuid;
begin
  perform public.check_drive_fields(p_title, p_starts, p_ends, p_description, p_cause,
                                    p_venue, p_city, p_capacity, p_hours, false);
  insert into public.drives (org_id, title, description, cause, venue, city, starts_at, ends_at,
                             capacity, default_hours, created_by)
  values (p_org, btrim(p_title), nullif(btrim(p_description), ''), nullif(btrim(p_cause), ''),
          nullif(btrim(p_venue), ''), nullif(btrim(p_city), ''), p_starts, p_ends,
          p_capacity, p_hours, v_uid)
  returning id into v_id;
  perform public.log_action('drive.create', 'drive', v_id);
  return json_build_object('id', v_id);
end $$;

-- update_drive(...) -> {id}   (coordinator; cancelled drives cannot be edited)
create or replace function public.update_drive(
  p_drive uuid, p_title text, p_starts timestamptz, p_ends timestamptz,
  p_description text default null, p_cause text default null, p_venue text default null,
  p_city text default null, p_capacity int default 50, p_hours numeric default 4)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_drive public.drives;
begin
  select * into v_drive from public.drives where id = p_drive;
  if v_drive.id is null then raise exception 'DRIVE_NOT_FOUND'; end if;
  perform public.require_role(v_drive.org_id, 'coordinator');
  if v_drive.status = 'cancelled' then raise exception 'DRIVE_NOT_OPEN'; end if;
  -- Editing a drive that already started is allowed (fix a venue typo mid-day).
  perform public.check_drive_fields(p_title, p_starts, p_ends, p_description, p_cause,
                                    p_venue, p_city, p_capacity, p_hours, true);
  update public.drives
     set title = btrim(p_title), description = nullif(btrim(p_description), ''),
         cause = nullif(btrim(p_cause), ''), venue = nullif(btrim(p_venue), ''),
         city = nullif(btrim(p_city), ''), starts_at = p_starts, ends_at = p_ends,
         capacity = p_capacity, default_hours = p_hours
   where id = p_drive;
  perform public.log_action('drive.update', 'drive', p_drive);
  return json_build_object('id', p_drive);
end $$;

-- cancel_drive(drive) -> void   (coordinator)
create or replace function public.cancel_drive(p_drive uuid)
returns void language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_org uuid;
begin
  select org_id into v_org from public.drives where id = p_drive;
  if v_org is null then raise exception 'DRIVE_NOT_FOUND'; end if;
  perform public.require_role(v_org, 'coordinator');
  update public.drives set status = 'cancelled' where id = p_drive;
  perform public.log_action('drive.cancel', 'drive', p_drive);
end $$;

-- get_checkin_code(drive) -> uuid   (coordinator)
create or replace function public.get_checkin_code(p_drive uuid)
returns uuid language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v_org uuid; v_code uuid;
begin
  select org_id into v_org from public.drives where id = p_drive;
  if v_org is null then raise exception 'DRIVE_NOT_FOUND'; end if;
  perform public.require_role(v_org, 'coordinator');
  select code into v_code from public.drive_checkin_codes where drive_id = p_drive;
  return v_code;
end $$;

-- rotate_checkin_code(drive) -> uuid   (coordinator; use if the QR was photographed)
create or replace function public.rotate_checkin_code(p_drive uuid)
returns uuid language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_org uuid; v_code uuid;
begin
  select org_id into v_org from public.drives where id = p_drive;
  if v_org is null then raise exception 'DRIVE_NOT_FOUND'; end if;
  perform public.require_role(v_org, 'coordinator');
  insert into public.drive_checkin_codes (drive_id, code, rotated_at)
  values (p_drive, gen_random_uuid(), now())
  on conflict (drive_id) do update set code = excluded.code, rotated_at = excluded.rotated_at
  returning code into v_code;
  perform public.log_action('drive.rotate_code', 'drive', p_drive);
  return v_code;
end $$;

-- discover_drives(query, cause, city, sort, limit, offset) -> rows   (public)
-- Search matches title, venue, city and organisation name. Only published
-- drives that have not ended. sort: 'soonest' (default) | 'hours'.
create or replace function public.discover_drives(
  p_query text default null, p_cause text default null, p_city text default null,
  p_sort text default 'soonest', p_limit int default 20, p_offset int default 0)
returns table (
  id uuid, title text, cause text, venue text, city text,
  starts_at timestamptz, ends_at timestamptz, default_hours numeric, capacity int,
  spots_left int, org_id uuid, org_name text, org_verified boolean, registered boolean)
language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare
  v_pat   text;
  v_limit int := least(greatest(coalesce(p_limit, 20), 1), 50);
  v_off   int := greatest(coalesce(p_offset, 0), 0);
  v_uid   uuid := auth.uid();
begin
  if nullif(btrim(p_query), '') is not null then
    v_pat := '%' || replace(replace(replace(btrim(p_query), '\', '\\'), '%', '\%'), '_', '\_') || '%';
  end if;

  return query
  select d.id, d.title, d.cause, d.venue, d.city, d.starts_at, d.ends_at, d.default_hours, d.capacity,
         greatest(d.capacity - coalesce(r.n, 0), 0)::int as spots_left,
         o.id, o.name, (o.verification_tier >= 2),
         (v_uid is not null and exists (
            select 1 from public.registrations x
            where x.drive_id = d.id and x.user_id = v_uid and x.status = 'confirmed'))
  from public.drives d
  join public.organisations o on o.id = d.org_id
  left join lateral (
    select count(*)::int as n from public.registrations x
    where x.drive_id = d.id and x.status = 'confirmed') r on true
  where d.status = 'published'
    and d.ends_at >= now()
    and (p_cause is null or d.cause = p_cause)
    and (p_city is null or lower(d.city) = lower(p_city))
    and (v_pat is null
         or d.title ilike v_pat escape '\'
         or d.venue ilike v_pat escape '\'
         or d.city  ilike v_pat escape '\'
         or o.name  ilike v_pat escape '\')
  order by case when p_sort = 'hours' then d.default_hours end desc nulls last,
           d.starts_at asc, d.id
  limit v_limit offset v_off;
end $$;

-- discover_facets() -> {causes:[{value,count}], cities:[{value,count}]}   (public)
create or replace function public.discover_facets()
returns json language sql stable security definer set search_path = public, extensions, pg_temp as $$
  with open as (
    select cause, city from public.drives where status = 'published' and ends_at >= now())
  select json_build_object(
    'causes', coalesce((select json_agg(json_build_object('value', cause, 'count', n) order by n desc, cause)
                        from (select cause, count(*) n from open where cause is not null group by cause) c), '[]'::json),
    'cities', coalesce((select json_agg(json_build_object('value', city, 'count', n) order by n desc, city)
                        from (select city, count(*) n from open where city is not null group by city) c), '[]'::json));
$$;

-- register_for_drive(drive) -> {registered:true, spots_left}
create or replace function public.register_for_drive(p_drive uuid)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid   uuid := public.require_user();
  v_drive public.drives;
  v_taken int;
  v_mine  text;
begin
  select * into v_drive from public.drives where id = p_drive for update;
  if v_drive.id is null then raise exception 'DRIVE_NOT_FOUND'; end if;
  if v_drive.status <> 'published' then raise exception 'DRIVE_NOT_OPEN'; end if;
  if v_drive.ends_at < now() then raise exception 'DRIVE_ENDED'; end if;

  select status into v_mine from public.registrations where drive_id = p_drive and user_id = v_uid;
  select count(*) into v_taken from public.registrations where drive_id = p_drive and status = 'confirmed';

  if v_mine is distinct from 'confirmed' and v_taken >= v_drive.capacity then
    raise exception 'DRIVE_FULL';
  end if;

  insert into public.registrations (drive_id, user_id, status) values (p_drive, v_uid, 'confirmed')
  on conflict (drive_id, user_id) do update set status = 'confirmed';

  select count(*) into v_taken from public.registrations where drive_id = p_drive and status = 'confirmed';
  return json_build_object('registered', true, 'spots_left', greatest(v_drive.capacity - v_taken, 0));
end $$;

-- cancel_registration(drive) -> {registered:false, spots_left}
create or replace function public.cancel_registration(p_drive uuid)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid uuid := public.require_user();
  v_cap int; v_taken int;
begin
  update public.registrations set status = 'cancelled'
   where drive_id = p_drive and user_id = v_uid and status = 'confirmed';
  if not found then raise exception 'NOT_REGISTERED'; end if;
  select capacity into v_cap from public.drives where id = p_drive;
  select count(*) into v_taken from public.registrations where drive_id = p_drive and status = 'confirmed';
  return json_build_object('registered', false, 'spots_left', greatest(coalesce(v_cap, 0) - v_taken, 0));
end $$;

-- my_upcoming_drives() -> [{id, title, starts_at, ends_at, venue, city, org_name, default_hours}]
create or replace function public.my_upcoming_drives()
returns json language sql stable security definer set search_path = public, extensions, pg_temp as $$
  select coalesce(json_agg(json_build_object(
           'id', d.id, 'title', d.title, 'starts_at', d.starts_at, 'ends_at', d.ends_at,
           'venue', d.venue, 'city', d.city, 'org_name', o.name, 'default_hours', d.default_hours,
           'status', d.status)
         order by d.starts_at), '[]'::json)
  from public.registrations r
  join public.drives d on d.id = r.drive_id
  join public.organisations o on o.id = d.org_id
  where r.user_id = public.require_user()
    and r.status = 'confirmed'
    and d.status = 'published'
    and d.ends_at >= now();
$$;

-- ------------------------------------------------------------ privileges
select public.lock_fn('public.mint_checkin_code()');
select public.lock_fn('public.check_drive_fields(text,timestamptz,timestamptz,text,text,text,text,int,numeric,boolean)');
select public.grant_rpc('public.create_drive(uuid,text,timestamptz,timestamptz,text,text,text,text,int,numeric)');
select public.grant_rpc('public.update_drive(uuid,text,timestamptz,timestamptz,text,text,text,text,int,numeric)');
select public.grant_rpc('public.cancel_drive(uuid)');
select public.grant_rpc('public.get_checkin_code(uuid)');
select public.grant_rpc('public.rotate_checkin_code(uuid)');
select public.grant_rpc('public.discover_drives(text,text,text,text,int,int)', true);
select public.grant_rpc('public.discover_facets()', true);
select public.grant_rpc('public.register_for_drive(uuid)');
select public.grant_rpc('public.cancel_registration(uuid)');
select public.grant_rpc('public.my_upcoming_drives()');

-- migrate:down
drop function if exists public.my_upcoming_drives();
drop function if exists public.cancel_registration(uuid);
drop function if exists public.register_for_drive(uuid);
drop function if exists public.discover_facets();
drop function if exists public.discover_drives(text,text,text,text,int,int);
drop function if exists public.rotate_checkin_code(uuid);
drop function if exists public.get_checkin_code(uuid);
drop function if exists public.cancel_drive(uuid);
drop function if exists public.update_drive(uuid,text,timestamptz,timestamptz,text,text,text,text,int,numeric);
drop function if exists public.create_drive(uuid,text,timestamptz,timestamptz,text,text,text,text,int,numeric);
drop function if exists public.check_drive_fields(text,timestamptz,timestamptz,text,text,text,text,int,numeric,boolean);
drop table if exists public.registrations;
drop trigger if exists drives_mint_code on public.drives;
drop function if exists public.mint_checkin_code();
drop table if exists public.drive_checkin_codes;
drop table if exists public.drives;
