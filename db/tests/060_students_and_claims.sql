-- Invariants: students hold no accounts; a teacher marks students present but
-- the drive's organisation certifies; a claim code moves records to a new
-- account; students with records cannot be removed; validation keys fire.
do $$
declare
  v_ngo_owner    uuid := pg_temp.soi_test_user('ngo6@test.soi', 'NGO Owner');
  v_teacher      uuid := pg_temp.soi_test_user('teacher6@test.soi', 'Teacher T');
  v_ngo uuid; v_school uuid; v_drive uuid; v_student uuid; v_claim text; v_json json; v_n int;
  v_student_user uuid; v_roster json; v_att uuid;
begin
  perform pg_temp.soi_as(v_ngo_owner);
  v_ngo := (public.create_organisation('Field NGO', 'ngo')->>'id')::uuid;
  v_drive := (public.create_drive(v_ngo, 'Lake clean-up', now() + interval '1 hour', now() + interval '4 hours',
              null, 'Environment', 'Lake', 'Nashik', 100, 3)->>'id')::uuid;
  perform pg_temp.soi_reset();

  perform pg_temp.soi_as(v_teacher);
  v_school := (public.create_organisation('St Mary School', 'school')->>'id')::uuid;
  -- validation
  perform pg_temp.soi_expect_error(format('select public.enrol_participant(%L, ''A'')', v_school), 'NAME_TOO_SHORT');
  perform pg_temp.soi_expect_error(format('select public.enrol_participant(%L, ''Rahul'', ''student'', ''9A'', ''bad roll!'')', v_school), 'BAD_ROLL');
  perform pg_temp.soi_expect_error(format('select public.enrol_participant(%L, ''Rahul'', ''student'', ''9A'', ''12'', null, ''12345'')', v_school), 'BAD_PHONE');
  perform pg_temp.soi_expect_error(format('select public.enrol_participant(%L, ''Rahul'', ''alien'')', v_school), 'BAD_KIND');
  v_json := public.enrol_participant(v_school, 'Rahul Verma', 'student', '9A', '12', null, '+91 98765 43210');
  v_student := (v_json->>'student_id')::uuid; v_claim := v_json->>'claim_code';
  if v_claim !~ '^[0-9A-F]{8}$' then raise exception 'claim code %', v_claim; end if;
  perform pg_temp.soi_expect_error(format('select public.enrol_participant(%L, ''Rahul Verma 2'', ''student'', ''9A'', ''12'')', v_school), 'DUPLICATE_ROLL');
  -- phone was normalised
  perform pg_temp.soi_reset();
  if (select phone from public.students where id = v_student) <> '9876543210' then raise exception 'phone not normalised'; end if;

  -- a stranger cannot mark the school's students
  perform pg_temp.soi_as(v_ngo_owner);
  perform pg_temp.soi_expect_error(format('select public.mark_students_present(%L, array[%L]::uuid[])', v_drive, v_student), 'NOT_AUTHORISED');
  perform pg_temp.soi_reset();

  -- the teacher marks the student present at the NGO's drive: PENDING, method teacher
  perform pg_temp.soi_as(v_teacher);
  v_n := public.mark_students_present(v_drive, array[v_student]);
  if v_n <> 1 then raise exception 'marked %', v_n; end if;
  if public.mark_students_present(v_drive, array[v_student]) <> 0 then raise exception 'marked twice'; end if;
  perform pg_temp.soi_reset();
  select id into v_att from public.attendance where drive_id = v_drive and student_id = v_student;
  perform pg_temp.soi_as(v_teacher);
  v_roster := public.org_roster(v_school);
  if (v_roster->0->>'pending_hours')::numeric <> 3 then raise exception 'org_roster pending: %', v_roster; end if;
  -- the teacher cannot certify (not the drive's organisation), nor remove a student with records
  perform pg_temp.soi_expect_error(format('select public.certify_attendance(array[%L]::uuid[])', v_att), 'NOT_AUTHORISED');
  perform pg_temp.soi_expect_error(format('select public.remove_student(%L)', v_student), 'STUDENT_HAS_RECORDS');
  perform pg_temp.soi_reset();

  -- the NGO certifies; the roster shows the student with school name and no phone
  perform pg_temp.soi_as(v_ngo_owner);
  v_roster := public.roster(v_drive);
  if v_roster->0->>'subject_kind' <> 'student' or v_roster->0->>'school_name' <> 'St Mary School' then raise exception 'roster: %', v_roster; end if;
  if v_roster::text like '%9876543210%' then raise exception 'roster leaked phone'; end if;
  v_n := public.certify_attendance((select array_agg(id) from public.attendance where drive_id = v_drive));
  if v_n <> 1 then raise exception 'certified %', v_n; end if;
  perform pg_temp.soi_reset();
  -- the certificate carries the student's name and no user yet
  if (select subject_name from public.certificates where student_id = v_student) <> 'Rahul Verma' then raise exception 'student cert name'; end if;
  if (select user_id from public.certificates where student_id = v_student) is not null then raise exception 'student cert has user'; end if;

  -- the student later gets an account and claims the record
  v_student_user := pg_temp.soi_test_user('rahul@test.soi');
  perform pg_temp.soi_as(v_student_user);
  perform pg_temp.soi_expect_error('select public.claim_student_record(''ZZZZZZZZ'')', 'INVALID_CLAIM_CODE');
  v_json := public.claim_student_record(lower(v_claim));
  if (v_json->>'records_claimed')::int <> 1 then raise exception 'claim: %', v_json; end if;
  v_json := public.my_passport();
  if (v_json->>'certified_hours')::numeric <> 3 then raise exception 'claimed hours: %', v_json; end if;
  if v_json->'attendance'->0->>'certificate_code' !~ '^SOI-' then raise exception 'claimed certificate missing'; end if;
  -- profile name was filled from the school record
  if public.my_profile()->>'full_name' <> 'Rahul Verma' then raise exception 'name not filled: %', public.my_profile(); end if;
  perform pg_temp.soi_reset();

  -- someone else cannot claim the same code
  perform pg_temp.soi_as(pg_temp.soi_test_user('imposter@test.soi', 'Imp Oster'));
  perform pg_temp.soi_expect_error(format('select public.claim_student_record(%L)', v_claim), 'ALREADY_CLAIMED');
  perform pg_temp.soi_reset();

  -- signup with the enrolled email auto-links (no claim code needed)
  perform pg_temp.soi_as(v_teacher);
  v_json := public.enrol_participant(v_school, 'Sneha Iyer', 'student', '9B', '4', 'sneha@test.soi');
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_teacher); perform public.mark_students_present(v_drive, array[(v_json->>'student_id')::uuid]); perform pg_temp.soi_reset();
  v_student_user := pg_temp.soi_test_user('SNEHA@test.soi');
  if (select claimed_by from public.students where id = (v_json->>'student_id')::uuid) <> v_student_user then raise exception 'auto-link failed'; end if;
  if (select user_id from public.attendance where student_id = (v_json->>'student_id')::uuid) <> v_student_user then raise exception 'attendance not linked'; end if;
end $$;
