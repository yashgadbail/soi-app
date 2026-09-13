-- migrate:up
-- =====================================================================
-- 004 students and attendance: the ledger
--
-- Why:   this is the product. One attendance row = one person at one
--        drive. A row is worth something only once a coordinator of the
--        organisation that ran the drive certifies it (migration 005).
-- What:  students (school-held records for people without accounts),
--        attendance, realtime publication, the signup link trigger, and
--        RPCs: enrol_participant, update_student, remove_student,
--        org_roster, mark_students_present, check_in, roster, drive_detail,
--        org_drives, organisation_public.
-- Calls: drive_detail and organisation_public are public (anon).
--        Everything else authenticated.
-- Keys:  NOT_SIGNED_IN, NOT_AUTHORISED, NAME_TOO_SHORT, NAME_TOO_LONG,
--        BAD_KIND, CLASS_TOO_LONG, BAD_ROLL, BAD_EMAIL, BAD_PHONE,
--        DUPLICATE_EMAIL, DUPLICATE_ROLL, STUDENT_NOT_FOUND,
--        STUDENT_HAS_RECORDS, STUDENT_CLAIMED, DRIVE_NOT_FOUND,
--        DRIVE_NOT_OPEN, INVALID_CODE, NO_STUDENTS
--
-- Design notes
--   * check_in() creates PENDING attendance only. Nothing here certifies.
--   * There is no client write policy on attendance or students. Ever.
--   * attendance.user_id references profiles (not auth.users) so the
--     relationship is visible to the API layer; the old schema's FK to
--     auth.users silently broke the coordinator roster.
--   * Children never hold accounts: a student is name + class + roll
--     (optionally the school-held email/phone). No DOB, photo or address.
--   * When an account is deleted, attendance rows keep the hours for the
--     organisation's record but lose the person (user_id -> null).
--   * attendance is in the realtime publication so Coordinator Mode
--     updates live; RLS still applies to what each subscriber receives.
-- =====================================================================

-- ------------------------------------------------------------ students
create table public.students (
  id             uuid primary key default gen_random_uuid(),
  org_id         uuid not null references public.organisations on delete cascade,
  full_name      text not null check (length(full_name) between 2 and 80),
  kind           text not null default 'student' check (kind in ('student','volunteer')),
  class_section  text check (length(class_section) <= 20),
  roll_no        text check (roll_no ~ '^[A-Za-z0-9/-]{1,12}$'),
  email          text check (email ~* '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]{2,}$'),
  phone          text check (phone ~ '^[6-9][0-9]{9}$'),
  claim_code     text not null unique check (claim_code ~ '^[0-9A-F]{8}$'),
  claimed_by     uuid references public.profiles on delete set null,
  created_by     uuid references auth.users on delete set null,
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now()
);
create unique index students_org_roll_uidx on public.students (org_id, lower(coalesce(class_section, '')), lower(roll_no))
  where roll_no is not null;
create unique index students_org_email_uidx on public.students (org_id, lower(email)) where email is not null;
create index students_org_idx   on public.students (org_id, lower(class_section), lower(full_name));
create index students_email_idx on public.students (lower(email)) where claimed_by is null;
alter table public.students enable row level security;
revoke all on public.students from public, anon, authenticated;
create trigger students_touch before update on public.students
  for each row execute function public.set_updated_at();

-- ------------------------------------------------------------ attendance
create table public.attendance (
  id            uuid primary key default gen_random_uuid(),
  drive_id      uuid not null references public.drives on delete cascade,
  user_id       uuid references public.profiles on delete set null,
  student_id    uuid references public.students on delete restrict,
  method        text not null check (method in ('qr','teacher')),
  hours         numeric(5,2) not null check (hours > 0 and hours <= 12),
  status        text not null default 'pending' check (status in ('pending','certified','rejected')),
  check_in_at   timestamptz not null default now(),
  certified_by  uuid references auth.users on delete set null,
  certified_at  timestamptz,
  rejected_by   uuid references auth.users on delete set null,
  rejected_at   timestamptz,
  created_at    timestamptz not null default now()
);
create unique index attendance_drive_user_uidx    on public.attendance (drive_id, user_id)    where user_id is not null;
create unique index attendance_drive_student_uidx on public.attendance (drive_id, student_id) where student_id is not null;
create index attendance_user_idx  on public.attendance (user_id, check_in_at desc);
create index attendance_drive_idx on public.attendance (drive_id, check_in_at desc);
alter table public.attendance enable row level security;
create policy attendance_select on public.attendance
  for select using (
    user_id = auth.uid()
    or public.is_org_member((select d.org_id from public.drives d where d.id = drive_id), 'coordinator'));
alter table public.attendance replica identity full;
alter publication supabase_realtime add table public.attendance;

-- ------------------------------------------------------------ signup link
-- A student enrolled with an email who later signs up with that email is
-- linked automatically, and their school-held attendance follows them.
create or replace function public.link_students_on_signup()
returns trigger language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_email text := lower(new.email);
begin
  update public.students set claimed_by = new.id
   where lower(email) = v_email and claimed_by is null;

  update public.attendance a set user_id = new.id
    from public.students s
   where a.student_id = s.id and s.claimed_by = new.id and a.user_id is null
     and not exists (select 1 from public.attendance b where b.drive_id = a.drive_id and b.user_id = new.id);
  return new;
end $$;

create trigger t2_link_students_on_signup
  after insert on auth.users
  for each row execute function public.link_students_on_signup();

-- ------------------------------------------------------------ helpers
create or replace function public.normalise_phone(p_raw text)
returns text language plpgsql immutable as $$
declare d text := regexp_replace(coalesce(p_raw, ''), '\D', '', 'g');
begin
  if length(d) = 12 and d like '91%' then d := substr(d, 3); end if;
  if length(d) = 11 and d like '0%'  then d := substr(d, 2); end if;
  if d = '' then return null; end if;
  if d !~ '^[6-9][0-9]{9}$' then raise exception 'BAD_PHONE'; end if;
  return d;
end $$;

create or replace function public.mint_claim_code()
returns text language plpgsql as $$
declare v text;
begin
  loop
    v := upper(substr(replace(gen_random_uuid()::text, '-', ''), 1, 8));
    exit when not exists (select 1 from public.students where claim_code = v);
  end loop;
  return v;
end $$;

create or replace function public.check_student_fields(
  p_name text, p_kind text, p_class text, p_roll text, p_email text, p_phone text)
returns void language plpgsql immutable as $$
begin
  if length(btrim(coalesce(p_name, ''))) < 2  then raise exception 'NAME_TOO_SHORT'; end if;
  if length(btrim(p_name)) > 80               then raise exception 'NAME_TOO_LONG'; end if;
  if p_kind not in ('student','volunteer')    then raise exception 'BAD_KIND'; end if;
  if length(coalesce(p_class, '')) > 20       then raise exception 'CLASS_TOO_LONG'; end if;
  if nullif(btrim(p_roll), '') is not null and btrim(p_roll) !~ '^[A-Za-z0-9/-]{1,12}$' then
    raise exception 'BAD_ROLL';
  end if;
  if nullif(btrim(p_email), '') is not null then perform public.check_email(p_email); end if;
end $$;

-- ------------------------------------------------------------ RPCs

-- enrol_participant(org, name, kind, class, roll, email, phone)
--   -> {student_id, claim_code, kind, linked}   (coordinator of org)
create or replace function public.enrol_participant(
  p_org uuid, p_name text, p_kind text default 'student', p_class text default null,
  p_roll text default null, p_email text default null, p_phone text default null)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid   uuid := public.require_role(p_org, 'coordinator');
  v_email text := nullif(lower(btrim(coalesce(p_email, ''))), '');
  v_phone text := public.normalise_phone(p_phone);
  v_roll  text := nullif(btrim(coalesce(p_roll, '')), '');
  v_class text := nullif(btrim(coalesce(p_class, '')), '');
  v_user  uuid;
  v_id    uuid;
  v_code  text;
begin
  perform public.check_student_fields(p_name, p_kind, v_class, v_roll, v_email, v_phone);
  if v_email is not null and exists (
       select 1 from public.students where org_id = p_org and lower(email) = v_email) then
    raise exception 'DUPLICATE_EMAIL';
  end if;
  if v_roll is not null and exists (
       select 1 from public.students
       where org_id = p_org and lower(coalesce(class_section, '')) = lower(coalesce(v_class, ''))
         and lower(roll_no) = lower(v_roll)) then
    raise exception 'DUPLICATE_ROLL';
  end if;
  if v_email is not null then
    select id into v_user from public.profiles where lower(email) = v_email;
  end if;
  v_code := public.mint_claim_code();

  insert into public.students (org_id, full_name, kind, class_section, roll_no, email, phone,
                               claim_code, claimed_by, created_by)
  values (p_org, btrim(p_name), p_kind, v_class, v_roll, v_email, v_phone, v_code, v_user, v_uid)
  returning id into v_id;

  perform public.log_action('student.enrol', 'student', v_id, json_build_object('org_id', p_org)::jsonb);
  return json_build_object('student_id', v_id, 'claim_code', v_code, 'kind', p_kind,
                           'linked', v_user is not null);
end $$;

-- update_student(student, name, class, roll, email, phone) -> {student_id}   (coordinator)
create or replace function public.update_student(
  p_student uuid, p_name text, p_class text default null, p_roll text default null,
  p_email text default null, p_phone text default null)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_s     public.students;
  v_email text := nullif(lower(btrim(coalesce(p_email, ''))), '');
  v_phone text := public.normalise_phone(p_phone);
  v_roll  text := nullif(btrim(coalesce(p_roll, '')), '');
  v_class text := nullif(btrim(coalesce(p_class, '')), '');
  v_user  uuid;
begin
  select * into v_s from public.students where id = p_student;
  if v_s.id is null then raise exception 'STUDENT_NOT_FOUND'; end if;
  perform public.require_role(v_s.org_id, 'coordinator');
  perform public.check_student_fields(p_name, v_s.kind, v_class, v_roll, v_email, v_phone);
  if v_email is not null and exists (
       select 1 from public.students where org_id = v_s.org_id and lower(email) = v_email and id <> p_student) then
    raise exception 'DUPLICATE_EMAIL';
  end if;
  if v_roll is not null and exists (
       select 1 from public.students
       where org_id = v_s.org_id and id <> p_student
         and lower(coalesce(class_section, '')) = lower(coalesce(v_class, ''))
         and lower(roll_no) = lower(v_roll)) then
    raise exception 'DUPLICATE_ROLL';
  end if;
  if v_s.claimed_by is null and v_email is not null then
    select id into v_user from public.profiles where lower(email) = v_email;
  end if;

  update public.students
     set full_name = btrim(p_name), class_section = v_class, roll_no = v_roll,
         email = v_email, phone = v_phone, claimed_by = coalesce(claimed_by, v_user)
   where id = p_student;
  perform public.log_action('student.update', 'student', p_student);
  return json_build_object('student_id', p_student);
end $$;

-- remove_student(student) -> void   (coordinator; refused once records exist)
create or replace function public.remove_student(p_student uuid)
returns void language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_s public.students;
begin
  select * into v_s from public.students where id = p_student;
  if v_s.id is null then raise exception 'STUDENT_NOT_FOUND'; end if;
  perform public.require_role(v_s.org_id, 'coordinator');
  if v_s.claimed_by is not null then raise exception 'STUDENT_CLAIMED'; end if;
  if exists (select 1 from public.attendance where student_id = p_student) then
    raise exception 'STUDENT_HAS_RECORDS';
  end if;
  delete from public.students where id = p_student;
  perform public.log_action('student.remove', 'student', p_student, json_build_object('org_id', v_s.org_id)::jsonb);
end $$;

-- org_roster(org) -> [{student_id, full_name, kind, class_section, roll_no, email, phone,
--                      claim_code, claimed, certified_hours, pending_hours}]   (coordinator)
create or replace function public.org_roster(p_org uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v json;
begin
  perform public.require_role(p_org, 'coordinator');
  select coalesce(json_agg(json_build_object(
           'student_id', s.id, 'full_name', s.full_name, 'kind', s.kind,
           'class_section', s.class_section, 'roll_no', s.roll_no,
           'email', s.email, 'phone', s.phone, 'claim_code', s.claim_code,
           'claimed', s.claimed_by is not null,
           'certified_hours', coalesce(t.certified, 0), 'pending_hours', coalesce(t.pending, 0))
         order by s.class_section nulls last, s.full_name), '[]'::json)
    into v
  from public.students s
  left join lateral (
    select sum(hours) filter (where status = 'certified') as certified,
           sum(hours) filter (where status = 'pending')   as pending
    from public.attendance a where a.student_id = s.id) t on true
  where s.org_id = p_org;
  return v;
end $$;

-- mark_students_present(drive, students[]) -> int rows created
-- The caller must coordinate the students' organisation (a teacher marking
-- their own pupils). The drive's organisation still certifies the hours.
create or replace function public.mark_students_present(p_drive uuid, p_students uuid[])
returns int language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid   uuid := public.require_user();
  v_drive public.drives;
  v_n     int;
begin
  if p_students is null or cardinality(p_students) = 0 then raise exception 'NO_STUDENTS'; end if;
  select * into v_drive from public.drives where id = p_drive;
  if v_drive.id is null then raise exception 'DRIVE_NOT_FOUND'; end if;
  if v_drive.status <> 'published' then raise exception 'DRIVE_NOT_OPEN'; end if;
  if exists (select 1 from public.students s
             where s.id = any(p_students) and not public.is_org_member(s.org_id, 'coordinator')) then
    raise exception 'NOT_AUTHORISED';
  end if;

  with ins as (
    insert into public.attendance (drive_id, user_id, student_id, method, hours)
    select p_drive,
           case when s.claimed_by is not null
                 and not exists (select 1 from public.attendance b
                                 where b.drive_id = p_drive and b.user_id = s.claimed_by)
                then s.claimed_by end,
           s.id, 'teacher', v_drive.default_hours
    from public.students s
    where s.id = any(p_students)
      and not exists (select 1 from public.attendance a where a.drive_id = p_drive and a.student_id = s.id)
    returning 1)
  select count(*) into v_n from ins;

  perform public.log_action('attendance.mark_students', 'drive', p_drive,
                            json_build_object('count', v_n, 'by', v_uid)::jsonb);
  return v_n;
end $$;

-- check_in(drive, code) -> {attendance_id, drive_title, org_name, hours, status, already}
-- Validated server-side: a client cannot forge attendance. Creates PENDING.
create or replace function public.check_in(p_drive uuid, p_code uuid)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid   uuid := public.require_user();
  v_drive public.drives;
  v_org   text;
  v_att   public.attendance;
  v_new   boolean := false;
begin
  select * into v_drive from public.drives where id = p_drive;
  if v_drive.id is null then raise exception 'INVALID_CODE'; end if;
  if not exists (select 1 from public.drive_checkin_codes where drive_id = p_drive and code = p_code) then
    raise exception 'INVALID_CODE';
  end if;
  if v_drive.status <> 'published' then raise exception 'DRIVE_NOT_OPEN'; end if;

  select * into v_att from public.attendance where drive_id = p_drive and user_id = v_uid;
  if v_att.id is null then
    insert into public.attendance (drive_id, user_id, method, hours)
    values (p_drive, v_uid, 'qr', v_drive.default_hours)
    returning * into v_att;
    v_new := true;
    perform public.log_action('attendance.check_in', 'attendance', v_att.id);
  end if;
  select name into v_org from public.organisations where id = v_drive.org_id;

  return json_build_object(
    'attendance_id', v_att.id, 'drive_title', v_drive.title, 'org_name', v_org,
    'hours', v_att.hours, 'status', v_att.status, 'already', not v_new);
end $$;

-- roster(drive) -> [{attendance_id, subject_kind, display_name, class_section, roll_no,
--                    school_name, method, status, check_in_at, hours, certified_at}]   (coordinator)
create or replace function public.roster(p_drive uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v_org uuid; v json;
begin
  select org_id into v_org from public.drives where id = p_drive;
  if v_org is null then raise exception 'DRIVE_NOT_FOUND'; end if;
  perform public.require_role(v_org, 'coordinator');
  select coalesce(json_agg(json_build_object(
           'attendance_id', a.id,
           'subject_kind', case when a.student_id is not null then 'student' else 'volunteer' end,
           'display_name', coalesce(nullif(btrim(p.full_name), ''), s.full_name, 'Volunteer'),
           'class_section', s.class_section, 'roll_no', s.roll_no, 'school_name', so.name,
           'method', a.method, 'status', a.status, 'check_in_at', a.check_in_at,
           'hours', a.hours, 'certified_at', a.certified_at)
         order by a.check_in_at desc), '[]'::json)
    into v
  from public.attendance a
  left join public.profiles p on p.id = a.user_id
  left join public.students s on s.id = a.student_id
  left join public.organisations so on so.id = s.org_id
  where a.drive_id = p_drive;
  return v;
end $$;

-- drive_detail(drive) -> json   (public for published drives; members see their own)
create or replace function public.drive_detail(p_drive uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid uuid := auth.uid();
  d     public.drives;
  o     public.organisations;
  v_taken int;
  v_manage boolean;
  v_att public.attendance;
begin
  select * into d from public.drives where id = p_drive;
  if d.id is null then raise exception 'DRIVE_NOT_FOUND'; end if;
  v_manage := v_uid is not null and public.is_org_member(d.org_id, 'coordinator');
  if d.status <> 'published' and not (v_uid is not null and public.is_org_member(d.org_id)) then
    raise exception 'DRIVE_NOT_FOUND';
  end if;
  select * into o from public.organisations where id = d.org_id;
  select count(*) into v_taken from public.registrations where drive_id = p_drive and status = 'confirmed';
  if v_uid is not null then
    select * into v_att from public.attendance where drive_id = p_drive and user_id = v_uid;
  end if;

  return json_build_object(
    'id', d.id, 'title', d.title, 'description', d.description, 'cause', d.cause,
    'venue', d.venue, 'city', d.city, 'starts_at', d.starts_at, 'ends_at', d.ends_at,
    'capacity', d.capacity, 'default_hours', d.default_hours, 'status', d.status,
    'spots_left', greatest(d.capacity - v_taken, 0),
    'registrations', case when v_manage then v_taken end,
    'registered', v_uid is not null and exists (
       select 1 from public.registrations r where r.drive_id = p_drive and r.user_id = v_uid and r.status = 'confirmed'),
    'can_manage', v_manage,
    'my_attendance', case when v_att.id is null then null else json_build_object(
       'status', v_att.status, 'hours', v_att.hours, 'check_in_at', v_att.check_in_at) end,
    'org', json_build_object('id', o.id, 'name', o.name, 'type', o.type, 'city', o.city,
                             'verification_tier', o.verification_tier));
end $$;

-- org_drives(org) -> [{id, title, starts_at, ends_at, status, city, venue, default_hours,
--                      capacity, registrations, checked_in, pending, certified}]   (coordinator)
create or replace function public.org_drives(p_org uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v json;
begin
  perform public.require_role(p_org, 'coordinator');
  select coalesce(json_agg(json_build_object(
           'id', d.id, 'title', d.title, 'starts_at', d.starts_at, 'ends_at', d.ends_at,
           'status', d.status, 'city', d.city, 'venue', d.venue, 'cause', d.cause,
           'default_hours', d.default_hours, 'capacity', d.capacity,
           'registrations', coalesce(r.n, 0), 'checked_in', coalesce(a.total, 0),
           'pending', coalesce(a.pending, 0), 'certified', coalesce(a.certified, 0))
         order by d.starts_at desc), '[]'::json)
    into v
  from public.drives d
  left join lateral (select count(*)::int n from public.registrations x
                     where x.drive_id = d.id and x.status = 'confirmed') r on true
  left join lateral (select count(*)::int total,
                            count(*) filter (where status = 'pending')::int pending,
                            count(*) filter (where status = 'certified')::int certified
                     from public.attendance y where y.drive_id = d.id) a on true
  where d.org_id = p_org;
  return v;
end $$;

-- organisation_public(org) -> {id, name, type, city, about, verification_tier,
--                              drives_run, certified_hours, upcoming:[...]}   (public)
create or replace function public.organisation_public(p_org uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare o public.organisations; v json;
begin
  select * into o from public.organisations where id = p_org;
  if o.id is null then raise exception 'ORG_NOT_FOUND'; end if;
  select json_build_object(
    'id', o.id, 'name', o.name, 'type', o.type, 'city', o.city, 'about', o.about,
    'verification_tier', o.verification_tier, 'created_at', o.created_at,
    'drives_run', (select count(*) from public.drives d
                   where d.org_id = p_org and d.status in ('published','completed') and d.ends_at < now()),
    'certified_hours', coalesce((select sum(a.hours) from public.attendance a
                                 join public.drives d on d.id = a.drive_id
                                 where d.org_id = p_org and a.status = 'certified'), 0),
    'upcoming', coalesce((select json_agg(json_build_object(
                    'id', d.id, 'title', d.title, 'starts_at', d.starts_at, 'ends_at', d.ends_at,
                    'city', d.city, 'venue', d.venue, 'cause', d.cause, 'default_hours', d.default_hours)
                  order by d.starts_at)
                  from public.drives d
                  where d.org_id = p_org and d.status = 'published' and d.ends_at >= now()), '[]'::json))
    into v;
  return v;
end $$;

-- ------------------------------------------------------------ privileges
select public.lock_fn('public.link_students_on_signup()');
select public.lock_fn('public.normalise_phone(text)');
select public.lock_fn('public.mint_claim_code()');
select public.lock_fn('public.check_student_fields(text,text,text,text,text,text)');
select public.grant_rpc('public.enrol_participant(uuid,text,text,text,text,text,text)');
select public.grant_rpc('public.update_student(uuid,text,text,text,text,text)');
select public.grant_rpc('public.remove_student(uuid)');
select public.grant_rpc('public.org_roster(uuid)');
select public.grant_rpc('public.mark_students_present(uuid,uuid[])');
select public.grant_rpc('public.check_in(uuid,uuid)');
select public.grant_rpc('public.roster(uuid)');
select public.grant_rpc('public.drive_detail(uuid)', true);
select public.grant_rpc('public.org_drives(uuid)');
select public.grant_rpc('public.organisation_public(uuid)', true);

-- drive_marked_students(drive) -> uuid[]   (authenticated)
-- A teacher marking pupils at another organisation's drive cannot read that
-- roster, yet must see who is already marked so nobody is ticked twice.
-- Returns only ids of the caller's own students with attendance there.
create or replace function public.drive_marked_students(p_drive uuid)
returns json language plpgsql stable security definer set search_path = public, extensions, pg_temp as $$
declare v json;
begin
  perform public.require_user();
  select coalesce(json_agg(a.student_id), '[]'::json) into v
  from public.attendance a
  join public.students s on s.id = a.student_id
  where a.drive_id = p_drive
    and public.is_org_member(s.org_id, 'coordinator');
  return v;
end $$;

select public.grant_rpc('public.drive_marked_students(uuid)');

-- migrate:down
drop function if exists public.drive_marked_students(uuid);
drop function if exists public.organisation_public(uuid);
drop function if exists public.org_drives(uuid);
drop function if exists public.drive_detail(uuid);
drop function if exists public.roster(uuid);
drop function if exists public.check_in(uuid,uuid);
drop function if exists public.mark_students_present(uuid,uuid[]);
drop function if exists public.org_roster(uuid);
drop function if exists public.remove_student(uuid);
drop function if exists public.update_student(uuid,text,text,text,text,text);
drop function if exists public.enrol_participant(uuid,text,text,text,text,text,text);
drop function if exists public.check_student_fields(text,text,text,text,text,text);
drop function if exists public.mint_claim_code();
drop function if exists public.normalise_phone(text);
drop function if exists public.link_students_on_signup();
alter publication supabase_realtime drop table public.attendance;
drop table if exists public.attendance;
drop table if exists public.students;
