-- migrate:up
-- =====================================================================
-- 009 marked students lookup
--
-- Why:   a teacher marking pupils present at another organisation's drive
--        cannot read that drive's roster (they do not coordinate it), yet
--        the screen must show who is already marked so nobody is ticked
--        twice. This returns only the caller's own students' ids.
-- What:  drive_marked_students(p_drive) -> uuid[]
-- Calls: authenticated. Returns ids of students belonging to organisations
--        the caller coordinates that already have attendance at the drive.
-- Keys:  NOT_SIGNED_IN
-- =====================================================================

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
