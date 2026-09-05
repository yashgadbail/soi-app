-- Invariants: only a coordinator of the drive's organisation certifies or
-- rejects; certification mints a verifiable certificate that snapshots the
-- name and survives account deletion; the verifier leaks no contact data;
-- revocation is visible; set_my_name propagates to valid certificates.
do $$
declare
  v_owner uuid := pg_temp.soi_test_user('owner3@test.soi', 'Owner Three');
  v_other uuid := pg_temp.soi_test_user('other-owner@test.soi', 'Other Owner');
  v_vol   uuid := pg_temp.soi_test_user('vol3@test.soi', 'Priya Sharma');
  v_org   uuid; v_org2 uuid; v_drive uuid; v_code uuid; v_att uuid;
  v_json  json; v_n int; v_cert text; v_roster json;
begin
  perform pg_temp.soi_as(v_owner);
  v_org := (public.create_organisation('Cert NGO', 'ngo')->>'id')::uuid;
  v_drive := (public.create_drive(v_org, 'Tree planting', now() + interval '1 hour', now() + interval '5 hours',
              null, 'Environment', 'Park', 'Nashik', 50, 4)->>'id')::uuid;
  v_code := public.get_checkin_code(v_drive);
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_other);
  v_org2 := (public.create_organisation('Unrelated NGO', 'ngo')->>'id')::uuid;
  perform pg_temp.soi_reset();

  perform pg_temp.soi_as(v_vol);
  v_att := (public.check_in(v_drive, v_code)->>'attendance_id')::uuid;
  -- a volunteer cannot certify their own row
  perform pg_temp.soi_expect_error(format('select public.certify_attendance(array[%L]::uuid[])', v_att), 'NOT_AUTHORISED');
  perform pg_temp.soi_reset();

  -- a coordinator of a different organisation cannot certify it either
  perform pg_temp.soi_as(v_other);
  perform pg_temp.soi_expect_error(format('select public.certify_attendance(array[%L]::uuid[])', v_att), 'NOT_AUTHORISED');
  perform pg_temp.soi_expect_error(format('select public.roster(%L)', v_drive), 'NOT_AUTHORISED');
  perform pg_temp.soi_reset();

  -- the right coordinator sees the roster with a name but no email, then certifies
  perform pg_temp.soi_as(v_owner);
  v_roster := public.roster(v_drive);
  if json_array_length(v_roster) <> 1 then raise exception 'roster should have 1 row: %', v_roster; end if;
  if v_roster->0->>'display_name' <> 'Priya Sharma' then raise exception 'roster name: %', v_roster; end if;
  if v_roster::text like '%test.soi%' then raise exception 'roster leaked an email'; end if;
  v_n := public.certify_attendance(array[v_att]);
  if v_n <> 1 then raise exception 'certified count %', v_n; end if;
  -- certifying again is a no-op (row is no longer pending)
  v_n := public.certify_attendance(array[v_att]);
  if v_n <> 0 then raise exception 'double certification minted again'; end if;
  -- a certified row cannot be rejected
  v_n := public.reject_attendance(array[v_att]);
  if v_n <> 0 then raise exception 'rejected a certified row'; end if;
  perform pg_temp.soi_reset();

  -- the volunteer's passport now shows 4 certified hours and a code
  perform pg_temp.soi_as(v_vol);
  v_json := public.my_passport();
  if (v_json->>'certified_hours')::numeric <> 4 then raise exception 'certified hours: %', v_json; end if;
  v_cert := v_json->'attendance'->0->>'certificate_code';
  if v_cert !~ '^SOI-[0-9A-F]{4}-[0-9A-F]{4}$' then raise exception 'bad code %', v_cert; end if;
  perform pg_temp.soi_reset();

  -- public verification: genuine, issuance facts only
  perform pg_temp.soi_as(null);
  v_json := public.verify_certificate(lower(v_cert));   -- case-insensitive input
  if not (v_json->>'found')::boolean or not (v_json->>'valid')::boolean then raise exception 'verify failed: %', v_json; end if;
  if v_json->>'subject_name' <> 'Priya Sharma' or v_json->>'org_name' <> 'Cert NGO' or v_json->>'title' <> 'Tree planting' then
    raise exception 'verify facts wrong: %', v_json;
  end if;
  if (v_json->>'hours')::numeric <> 4 then raise exception 'verify hours: %', v_json; end if;
  if v_json::jsonb ? 'email' or v_json::jsonb ? 'user_id' or v_json::jsonb ? 'phone' then raise exception 'verify leaked private fields'; end if;
  perform pg_temp.soi_reset();

  -- renaming updates the valid certificate
  perform pg_temp.soi_as(v_vol);
  v_json := public.set_my_name('Priya S. Sharma');
  if (v_json->>'certificates_updated')::int <> 1 then raise exception 'rename did not update certificate: %', v_json; end if;
  perform pg_temp.soi_expect_error('select public.set_my_name(''a@b.c'')', 'NAME_LOOKS_LIKE_EMAIL');
  perform pg_temp.soi_reset();
  if (public.verify_certificate(v_cert)->>'subject_name') <> 'Priya S. Sharma' then raise exception 'rename not reflected'; end if;

  -- revocation: only the issuing organisation, visible on verify
  perform pg_temp.soi_as(v_other);
  perform pg_temp.soi_expect_error(format('select public.revoke_certificate(%L, ''fraud'')', v_cert), 'NOT_AUTHORISED');
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_owner);
  perform pg_temp.soi_expect_error(format('select public.revoke_certificate(%L, ''x'')', v_cert), 'BAD_REASON');
  perform public.revoke_certificate(v_cert, 'Issued in error');
  perform pg_temp.soi_reset();
  v_json := public.verify_certificate(v_cert);
  if (v_json->>'valid')::boolean or v_json->>'revoked_reason' <> 'Issued in error' then raise exception 'revoke not visible: %', v_json; end if;

  -- account deletion keeps the certificate verifiable (snapshot), detached from the user
  perform pg_temp.soi_as(v_vol);
  perform public.delete_my_account();
  perform pg_temp.soi_reset();
  if not exists (select 1 from auth.users where id = v_vol) then null; else raise exception 'user not deleted'; end if;
  v_json := public.verify_certificate(v_cert);
  if not (v_json->>'found')::boolean then raise exception 'certificate vanished with the account'; end if;
  if (select user_id from public.certificates where code = v_cert) is not null then raise exception 'certificate still linked'; end if;
  -- the organisation keeps the hours in its ledger, without the person
  if (select count(*) from public.attendance where id = v_att and user_id is null) <> 1 then raise exception 'ledger row lost'; end if;
end $$;
