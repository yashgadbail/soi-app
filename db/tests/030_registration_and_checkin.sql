-- Invariants: capacity is enforced under lock, check-in creates PENDING only,
-- bad codes are rejected, cancellation frees the spot.
do $$
declare
  v_owner uuid := pg_temp.soi_test_user('owner2@test.soi', 'Owner Two');
  v_a     uuid := pg_temp.soi_test_user('a@test.soi', 'Vol A');
  v_b     uuid := pg_temp.soi_test_user('b@test.soi', 'Vol B');
  v_c     uuid := pg_temp.soi_test_user('c@test.soi', 'Vol C');
  v_org   uuid;
  v_drive uuid;
  v_code  uuid;
  v_json  json;
begin
  perform pg_temp.soi_as(v_owner);
  v_org := (public.create_organisation('Cap NGO', 'ngo')->>'id')::uuid;
  v_drive := (public.create_drive(v_org, 'Tiny drive', now() + interval '2 hours', now() + interval '6 hours',
              null, 'Community', 'Hall', 'Pune', 2, 3)->>'id')::uuid;
  v_code := public.get_checkin_code(v_drive);
  perform pg_temp.soi_reset();

  -- validation keys on create_drive
  perform pg_temp.soi_as(v_owner);
  perform pg_temp.soi_expect_error(format('select public.create_drive(%L, ''abc'', now() + interval ''1 day'', now() + interval ''1 day 1 hour'')', v_org), 'TITLE_TOO_SHORT');
  perform pg_temp.soi_expect_error(format('select public.create_drive(%L, ''Valid title'', now() + interval ''1 day'', now() + interval ''1 day 1 hour'', null, null, null, null, 50, 13)', v_org), 'BAD_HOURS');
  perform pg_temp.soi_expect_error(format('select public.create_drive(%L, ''Valid title'', now() + interval ''1 day'', now() + interval ''23 hours'')', v_org), 'END_BEFORE_START');
  perform pg_temp.soi_expect_error(format('select public.create_drive(%L, ''Valid title'', now() - interval ''2 days'', now() - interval ''1 day'')', v_org), 'STARTS_IN_PAST');
  perform pg_temp.soi_reset();

  -- capacity 2: A and B register, C is refused
  perform pg_temp.soi_as(v_a);
  v_json := public.register_for_drive(v_drive);
  if (v_json->>'spots_left')::int <> 1 then raise exception 'spots_left after A: %', v_json; end if;
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_b);
  perform public.register_for_drive(v_drive);
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_c);
  perform pg_temp.soi_expect_error(format('select public.register_for_drive(%L)', v_drive), 'DRIVE_FULL');
  perform pg_temp.soi_reset();

  -- A re-registering is idempotent, not a second seat
  perform pg_temp.soi_as(v_a);
  v_json := public.register_for_drive(v_drive);
  if (v_json->>'spots_left')::int <> 0 then raise exception 'idempotent register broke count: %', v_json; end if;
  -- A cancels, C can now register
  v_json := public.cancel_registration(v_drive);
  if (v_json->>'spots_left')::int <> 1 then raise exception 'cancel did not free spot: %', v_json; end if;
  perform pg_temp.soi_expect_error(format('select public.cancel_registration(%L)', v_drive), 'NOT_REGISTERED');
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_c);
  perform public.register_for_drive(v_drive);
  perform pg_temp.soi_reset();

  -- check-in: wrong code refused, right code creates PENDING, repeat is idempotent
  perform pg_temp.soi_as(v_b);
  perform pg_temp.soi_expect_error(format('select public.check_in(%L, %L)', v_drive, gen_random_uuid()), 'INVALID_CODE');
  perform pg_temp.soi_expect_error(format('select public.check_in(%L, %L)', gen_random_uuid(), v_code), 'INVALID_CODE');
  v_json := public.check_in(v_drive, v_code);
  if v_json->>'status' <> 'pending' then raise exception 'check_in must be pending: %', v_json; end if;
  if (v_json->>'already')::boolean then raise exception 'first check-in flagged already'; end if;
  if (v_json->>'hours')::numeric <> 3 then raise exception 'hours should follow drive default: %', v_json; end if;
  if v_json->>'org_name' <> 'Cap NGO' then raise exception 'org_name missing: %', v_json; end if;
  v_json := public.check_in(v_drive, v_code);
  if not (v_json->>'already')::boolean then raise exception 'second check-in should be already'; end if;
  -- the volunteer sees exactly one pending row in the passport
  v_json := public.my_passport();
  if (v_json->>'pending_hours')::numeric <> 3 then raise exception 'passport pending: %', v_json; end if;
  if (v_json->>'certified_hours')::numeric <> 0 then raise exception 'passport certified should be 0'; end if;
  perform pg_temp.soi_reset();

  -- rotating the code invalidates the old one
  perform pg_temp.soi_as(v_owner);
  perform public.rotate_checkin_code(v_drive);
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_c);
  perform pg_temp.soi_expect_error(format('select public.check_in(%L, %L)', v_drive, v_code), 'INVALID_CODE');
  perform pg_temp.soi_reset();

  -- cancelled drives refuse check-in and registration
  perform pg_temp.soi_as(v_owner);
  perform public.cancel_drive(v_drive);
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_c);
  perform pg_temp.soi_expect_error(format('select public.register_for_drive(%L)', v_drive), 'DRIVE_NOT_OPEN');
  perform pg_temp.soi_reset();
end $$;
