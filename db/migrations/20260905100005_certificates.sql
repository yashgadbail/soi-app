-- migrate:up
-- =====================================================================
-- 005 certificates: certification, rejection, verification
--
-- Why:   a certificate is the proof object. It must remain verifiable
--        by anyone, forever, without revealing contact details, even if
--        the drive, the account or the organisation is later deleted.
-- What:  certificates (snapshot rows), certify_attendance,
--        reject_attendance, verify_certificate, revoke_certificate,
--        set_my_name, claim_student_record, the signup certificate link.
-- Calls: verify_certificate is public (anon). Everything else authenticated.
-- Keys:  NOT_SIGNED_IN, NOT_AUTHORISED, NOTHING_TO_CERTIFY,
--        CERTIFICATE_NOT_FOUND, BAD_REASON, NAME_TOO_SHORT, NAME_TOO_LONG,
--        NAME_LOOKS_LIKE_EMAIL, INVALID_CLAIM_CODE, ALREADY_CLAIMED
--
-- Design notes
--   * subject_name, org_name and title are SNAPSHOTS at issue time.
--   * Only coordinators of the organisation that ran the drive certify.
--     Certified rows are immutable; the only later change is revocation,
--     which is visible on the certificate ("WITHDRAWN") and audited.
--   * Codes are SOI-XXXX-XXXX from a random UUID: 32 bits of entropy,
--     unguessable in practice, unique by construction.
--   * The public verifier returns issuance facts only.
-- =====================================================================

create table public.certificates (
  id                   uuid primary key default gen_random_uuid(),
  code                 text not null unique check (code ~ '^SOI-[0-9A-F]{4}-[0-9A-F]{4}$'),
  kind                 text not null check (kind in ('volunteering','pledge')),
  user_id              uuid references public.profiles on delete set null,
  student_id           uuid references public.students on delete set null,
  attendance_id        uuid unique references public.attendance on delete set null,
  pledge_signature_id  uuid unique,   -- FK added in 006 once pledge_signatures exists
  org_id               uuid references public.organisations on delete set null,
  subject_name         text not null,
  org_name             text not null,
  title                text not null,
  hours                numeric(5,2),
  issued_at            timestamptz not null default now(),
  revoked_at           timestamptz,
  revoked_by           uuid,
  revoked_reason       text
);
create index certificates_user_idx    on public.certificates (user_id, issued_at desc);
create index certificates_student_idx on public.certificates (student_id) where student_id is not null;
alter table public.certificates enable row level security;
create policy certificates_select_own on public.certificates
  for select using (user_id = auth.uid());

-- ------------------------------------------------------------ helpers
create or replace function public.mint_certificate_code()
returns text language plpgsql as $$
declare raw text; v text;
begin
  loop
    raw := upper(replace(gen_random_uuid()::text, '-', ''));
    v := 'SOI-' || substr(raw, 1, 4) || '-' || substr(raw, 5, 4);
    exit when not exists (select 1 from public.certificates where code = v);
  end loop;
  return v;
end $$;

create or replace function public.link_certificates_on_signup()
returns trigger language plpgsql security definer set search_path = public, extensions, pg_temp as $$
begin
  update public.certificates c set user_id = new.id
    from public.students s
   where c.student_id = s.id and s.claimed_by = new.id and c.user_id is null;
  return new;
end $$;

create trigger t3_link_certificates_on_signup
  after insert on auth.users
  for each row execute function public.link_certificates_on_signup();

-- ------------------------------------------------------------ RPCs

-- certify_attendance(ids[]) -> int certified   (coordinator of each drive's org)
-- Pending rows only. Mints one certificate per row.
create or replace function public.certify_attendance(p_ids uuid[])
returns int language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid uuid := public.require_user();
  v_n   int := 0;
  r     record;
begin
  if p_ids is null or cardinality(p_ids) = 0 then raise exception 'NOTHING_TO_CERTIFY'; end if;
  if exists (select 1 from public.attendance a join public.drives d on d.id = a.drive_id
             where a.id = any(p_ids) and not public.is_org_member(d.org_id, 'coordinator')) then
    raise exception 'NOT_AUTHORISED';
  end if;

  for r in
    select a.id, a.user_id, a.student_id, a.hours, d.title, d.org_id, o.name as org_name,
           coalesce(nullif(btrim(p.full_name), ''), s.full_name, 'Volunteer') as subject
    from public.attendance a
    join public.drives d on d.id = a.drive_id
    join public.organisations o on o.id = d.org_id
    left join public.profiles p on p.id = a.user_id
    left join public.students s on s.id = a.student_id
    where a.id = any(p_ids) and a.status = 'pending'
    for update of a
  loop
    update public.attendance
       set status = 'certified', certified_by = v_uid, certified_at = now()
     where id = r.id;
    insert into public.certificates
      (code, kind, user_id, student_id, attendance_id, org_id, subject_name, org_name, title, hours)
    values (public.mint_certificate_code(), 'volunteering', r.user_id, r.student_id, r.id, r.org_id,
            r.subject, r.org_name, r.title, r.hours);
    v_n := v_n + 1;
  end loop;

  perform public.log_action('attendance.certify', 'attendance', null,
                            json_build_object('ids', p_ids, 'count', v_n)::jsonb);
  return v_n;
end $$;

-- reject_attendance(ids[]) -> int rejected   (coordinator; pending rows only)
create or replace function public.reject_attendance(p_ids uuid[])
returns int language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_uid uuid := public.require_user(); v_n int;
begin
  if p_ids is null or cardinality(p_ids) = 0 then raise exception 'NOTHING_TO_CERTIFY'; end if;
  if exists (select 1 from public.attendance a join public.drives d on d.id = a.drive_id
             where a.id = any(p_ids) and not public.is_org_member(d.org_id, 'coordinator')) then
    raise exception 'NOT_AUTHORISED';
  end if;
  with upd as (
    update public.attendance
       set status = 'rejected', rejected_by = v_uid, rejected_at = now()
     where id = any(p_ids) and status = 'pending'
    returning 1)
  select count(*) into v_n from upd;
  perform public.log_action('attendance.reject', 'attendance', null,
                            json_build_object('ids', p_ids, 'count', v_n)::jsonb);
  return v_n;
end $$;

-- verify_certificate(code) -> {found:false} | {found, valid, code, kind, subject_name,
--                              org_name, title, hours, issued_at, revoked_reason}   (public)
create or replace function public.verify_certificate(p_code text)
returns json language sql stable security definer set search_path = public, extensions, pg_temp as $$
  select coalesce(
    (select json_build_object(
       'found', true, 'valid', c.revoked_at is null, 'code', c.code, 'kind', c.kind,
       'subject_name', c.subject_name, 'org_name', c.org_name, 'title', c.title,
       'hours', c.hours, 'issued_at', c.issued_at, 'revoked_reason', c.revoked_reason)
     from public.certificates c
     where c.code = upper(btrim(coalesce(p_code, '')))),
    json_build_object('found', false));
$$;

-- revoke_certificate(code, reason) -> {code, revoked:true}   (coordinator of issuing org)
create or replace function public.revoke_certificate(p_code text, p_reason text)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare v_uid uuid := public.require_user(); c public.certificates;
begin
  select * into c from public.certificates where code = upper(btrim(coalesce(p_code, '')));
  if c.id is null then raise exception 'CERTIFICATE_NOT_FOUND'; end if;
  if c.org_id is null or not public.is_org_member(c.org_id, 'coordinator') then
    raise exception 'NOT_AUTHORISED';
  end if;
  if length(btrim(coalesce(p_reason, ''))) < 3 or length(btrim(p_reason)) > 200 then
    raise exception 'BAD_REASON';
  end if;
  update public.certificates
     set revoked_at = now(), revoked_by = v_uid, revoked_reason = btrim(p_reason)
   where id = c.id and revoked_at is null;
  perform public.log_action('certificate.revoke', 'certificate', c.id,
                            json_build_object('reason', btrim(p_reason))::jsonb);
  return json_build_object('code', c.code, 'revoked', true);
end $$;

-- set_my_name(name) -> {name, certificates_updated}
-- The name printed on certificates. Updates existing valid certificates too.
create or replace function public.set_my_name(p_name text)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid  uuid := public.require_user();
  v_name text := regexp_replace(btrim(coalesce(p_name, '')), '\s+', ' ', 'g');
  v_n    int;
begin
  if length(v_name) < 2  then raise exception 'NAME_TOO_SHORT'; end if;
  if length(v_name) > 80 then raise exception 'NAME_TOO_LONG'; end if;
  if v_name like '%@%' then raise exception 'NAME_LOOKS_LIKE_EMAIL'; end if;

  update public.profiles set full_name = v_name where id = v_uid;
  with upd as (
    update public.certificates set subject_name = v_name
     where user_id = v_uid and revoked_at is null and subject_name is distinct from v_name
    returning 1)
  select count(*) into v_n from upd;
  return json_build_object('name', v_name, 'certificates_updated', v_n);
end $$;

-- claim_student_record(claim_code) -> {student_name, records_claimed}
-- Attaches a school-held student record (and its attendance + certificates)
-- to the calling account.
create or replace function public.claim_student_record(p_claim_code text)
returns json language plpgsql security definer set search_path = public, extensions, pg_temp as $$
declare
  v_uid uuid := public.require_user();
  s     public.students;
  v_n   int;
begin
  select * into s from public.students where claim_code = upper(btrim(coalesce(p_claim_code, '')));
  if s.id is null then raise exception 'INVALID_CLAIM_CODE'; end if;
  if s.claimed_by is not null and s.claimed_by <> v_uid then raise exception 'ALREADY_CLAIMED'; end if;

  update public.students set claimed_by = v_uid where id = s.id;

  with upd as (
    update public.attendance a set user_id = v_uid
     where a.student_id = s.id and a.user_id is null
       and not exists (select 1 from public.attendance b where b.drive_id = a.drive_id and b.user_id = v_uid)
    returning 1)
  select count(*) into v_n from upd;

  update public.certificates set user_id = v_uid where student_id = s.id and user_id is null;
  update public.profiles set full_name = s.full_name
   where id = v_uid and coalesce(btrim(full_name), '') = '';

  perform public.log_action('student.claim', 'student', s.id, json_build_object('records', v_n)::jsonb);
  return json_build_object('student_name', s.full_name, 'records_claimed', v_n);
end $$;

-- ------------------------------------------------------------ privileges
select public.lock_fn('public.mint_certificate_code()');
select public.lock_fn('public.link_certificates_on_signup()');
select public.grant_rpc('public.certify_attendance(uuid[])');
select public.grant_rpc('public.reject_attendance(uuid[])');
select public.grant_rpc('public.verify_certificate(text)', true);
select public.grant_rpc('public.revoke_certificate(text,text)');
select public.grant_rpc('public.set_my_name(text)');
select public.grant_rpc('public.claim_student_record(text)');

-- migrate:down
drop function if exists public.claim_student_record(text);
drop function if exists public.set_my_name(text);
drop function if exists public.revoke_certificate(text,text);
drop function if exists public.verify_certificate(text);
drop function if exists public.reject_attendance(uuid[]);
drop function if exists public.certify_attendance(uuid[]);
drop function if exists public.link_certificates_on_signup();
drop function if exists public.mint_certificate_code();
drop table if exists public.certificates;
