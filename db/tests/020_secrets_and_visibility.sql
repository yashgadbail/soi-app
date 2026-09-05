-- Invariants: secrets are unreadable, RLS hides what it should, public read
-- RPCs expose nothing private, and write policies do not exist.
do $$
declare
  v_owner uuid := pg_temp.soi_test_user('owner@test.soi', 'Owner One');
  v_vol   uuid := pg_temp.soi_test_user('vol@test.soi', 'Vol Unteer');
  v_org   uuid;
  v_drive uuid;
  v_json  json;
  v_n     int;
  v_code  uuid;
begin
  -- setup as owner
  perform pg_temp.soi_as(v_owner);
  v_org := (public.create_organisation('Test NGO', 'ngo', null, 'Nashik')->>'id')::uuid;
  v_drive := (public.create_drive(v_org, 'Beach clean-up', now() + interval '1 day',
              now() + interval '1 day 4 hours', 'desc', 'Environment', 'Beach', 'Mumbai', 10, 4)->>'id')::uuid;
  perform pg_temp.soi_reset();

  -- 1. the check-in code table is unreadable by every client role
  perform pg_temp.soi_as(null);
  perform pg_temp.soi_expect_error('select * from public.drive_checkin_codes', 'permission denied');
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_vol);
  perform pg_temp.soi_expect_error('select * from public.drive_checkin_codes', 'permission denied');
  perform pg_temp.soi_expect_error('select * from public.students', 'permission denied');
  perform pg_temp.soi_expect_error('select * from public.org_invites', 'permission denied');
  perform pg_temp.soi_expect_error('select * from public.audit_log', 'permission denied');
  perform pg_temp.soi_expect_error('select * from public.content_reports', 'permission denied');

  -- 2. a volunteer cannot read another user's profile
  select count(*) into v_n from public.profiles;
  if v_n <> 1 then raise exception 'profiles: expected only own row, saw %', v_n; end if;

  -- 3. a volunteer cannot obtain the check-in code, nor rotate it
  perform pg_temp.soi_expect_error(format('select public.get_checkin_code(%L)', v_drive), 'NOT_AUTHORISED');
  perform pg_temp.soi_expect_error(format('select public.rotate_checkin_code(%L)', v_drive), 'NOT_AUTHORISED');

  -- 4. no client write path exists on any ledger table
  perform pg_temp.soi_expect_error(
    format('insert into public.attendance (drive_id, user_id, method, hours) values (%L, %L, ''qr'', 4)', v_drive, v_vol),
    'row-level security');
  -- updates without a policy are filtered to zero rows by RLS (no error); prove nothing changed
  update public.drives set default_hours = 99 where id = v_drive;
  update public.organisations set verification_tier = 3 where id = v_org;
  perform pg_temp.soi_reset();
  if (select default_hours from public.drives where id = v_drive) <> 4 then raise exception 'volunteer changed drive hours'; end if;
  if (select verification_tier from public.organisations where id = v_org) <> 0 then raise exception 'volunteer changed verification tier'; end if;
  perform pg_temp.soi_as(v_vol);
  perform pg_temp.soi_expect_error(format('insert into public.org_members (org_id, user_id, role) values (%L, %L, ''owner'')', v_org, v_vol), 'row-level security');
  perform pg_temp.soi_expect_error(format('insert into public.certificates (code, kind, subject_name, org_name, title) values (''SOI-0000-0000'', ''volunteering'', ''x'', ''y'', ''z'')'), 'row-level security');
  perform pg_temp.soi_reset();

  -- 5. anon can discover published drives and read the public verifier, nothing else
  perform pg_temp.soi_as(null);
  select count(*) into v_n from public.discover_drives('beach', null, null, 'soonest', 20, 0);
  if v_n <> 1 then raise exception 'discover_drives as anon: expected 1, got %', v_n; end if;
  v_json := public.drive_detail(v_drive);
  if (v_json->>'registered')::boolean then raise exception 'anon should not be registered'; end if;
  if v_json::jsonb ? 'registrations' and v_json->>'registrations' is not null then raise exception 'anon must not see registration counts'; end if;
  v_json := public.verify_certificate('SOI-ZZZZ-ZZZZ');
  if (v_json->>'found')::boolean then raise exception 'verify: unknown code must be not found'; end if;
  perform pg_temp.soi_expect_error(format('select public.register_for_drive(%L)', v_drive), 'permission denied');
  perform pg_temp.soi_expect_error(format('select public.check_in(%L, %L)', v_drive, gen_random_uuid()), 'permission denied');
  perform pg_temp.soi_expect_error('select public.my_passport()', 'permission denied');
  perform pg_temp.soi_expect_error('select public.my_profile()', 'permission denied');
  perform pg_temp.soi_reset();

  -- 6. the owner can read the code; it matches the secret table
  perform pg_temp.soi_as(v_owner);
  v_code := public.get_checkin_code(v_drive);
  if v_code is null then raise exception 'owner should get a code'; end if;
  perform pg_temp.soi_reset();
  if v_code is distinct from (select code from public.drive_checkin_codes where drive_id = v_drive) then
    raise exception 'code mismatch';
  end if;
end $$;
