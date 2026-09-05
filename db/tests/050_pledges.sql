-- Invariants: signing is idempotent and mints a pledge certificate (no hours);
-- a signed pledge's body is locked and it cannot be deleted; closed pledges
-- refuse new signatures; signers are visible to coordinators by name only.
do $$
declare
  v_owner uuid := pg_temp.soi_test_user('owner5@test.soi', 'Owner Five');
  v_vol   uuid := pg_temp.soi_test_user('vol5@test.soi', 'Arjun Mehta');
  v_org   uuid; v_pledge uuid; v_code text; v_json json;
begin
  perform pg_temp.soi_as(v_owner);
  v_org := (public.create_organisation('Pledge NGO', 'ngo')->>'id')::uuid;
  perform pg_temp.soi_expect_error(format('select public.create_pledge(%L, ''Short'', ''too short body'')', v_org), 'BODY_TOO_SHORT');
  v_json := public.create_pledge(v_org, 'Say no to plastic', 'I pledge to refuse single-use plastic for one year.', 'Plastic-free 2026');
  v_pledge := (v_json->>'id')::uuid; v_code := v_json->>'share_code';
  if v_code !~ '^[0-9A-F]{6}$' then raise exception 'share code %', v_code; end if;
  perform pg_temp.soi_reset();

  -- anon can read the pledge page
  perform pg_temp.soi_as(null);
  v_json := public.pledge_detail(lower(v_code));
  if v_json->>'title' <> 'Say no to plastic' or (v_json->>'signatures')::int <> 0 then raise exception 'detail: %', v_json; end if;
  if v_json->'my_signature' is not null and v_json->>'my_signature' is not null then raise exception 'anon has signature'; end if;
  perform pg_temp.soi_expect_error(format('select public.sign_pledge(%L)', v_code), 'permission denied');
  perform pg_temp.soi_reset();

  -- sign, then sign again: same signature, same certificate
  perform pg_temp.soi_as(v_vol);
  v_json := public.sign_pledge(v_code);
  if (v_json->>'signature_no')::int <> 1 or (v_json->>'already')::boolean then raise exception 'sign: %', v_json; end if;
  if v_json->>'certificate_code' !~ '^SOI-' then raise exception 'no certificate: %', v_json; end if;
  if public.sign_pledge(v_code)->>'certificate_code' <> v_json->>'certificate_code' then raise exception 'second sign minted again'; end if;
  if not (public.sign_pledge(v_code)->>'already')::boolean then raise exception 'already flag'; end if;
  -- a pledge certificate has no hours and is verifiable
  if (public.verify_certificate(v_json->>'certificate_code')->>'hours') is not null then raise exception 'pledge certificate has hours'; end if;
  if public.verify_certificate(v_json->>'certificate_code')->>'kind' <> 'pledge' then raise exception 'kind'; end if;
  -- passport separates pledges from hours
  v_json := public.my_passport();
  if (v_json->>'certified_hours')::numeric <> 0 then raise exception 'pledge counted as hours'; end if;
  if json_array_length(v_json->'pledges') <> 1 then raise exception 'passport pledges: %', v_json; end if;
  perform pg_temp.soi_reset();

  perform pg_temp.soi_as(v_owner);
  -- body locked once signed; title still editable; delete refused
  perform pg_temp.soi_expect_error(format('select public.update_pledge(%L, ''Say no to plastic'', ''Different body text that is long enough.'')', v_pledge), 'PLEDGE_ALREADY_SIGNED');
  v_json := public.update_pledge(v_pledge, 'Refuse plastic', 'I pledge to refuse single-use plastic for one year.', 'Plastic-free 2026');
  if (v_json->>'signatures')::int <> 1 then raise exception 'update: %', v_json; end if;
  perform pg_temp.soi_expect_error(format('select public.delete_pledge(%L)', v_pledge), 'PLEDGE_HAS_SIGNATURES');
  -- signers visible by name only
  v_json := public.pledge_signers(v_pledge);
  if v_json->0->>'name' <> 'Arjun Mehta' then raise exception 'signers: %', v_json; end if;
  if v_json::text like '%test.soi%' then raise exception 'signers leaked email'; end if;
  -- close, then a new person cannot sign
  perform public.set_pledge_status(v_pledge, 'closed');
  perform pg_temp.soi_expect_error(format('select public.set_pledge_status(%L, ''bogus'')', v_pledge), 'BAD_STATUS');
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(pg_temp.soi_test_user('late@test.soi', 'Late Signer'));
  perform pg_temp.soi_expect_error(format('select public.sign_pledge(%L)', v_code), 'PLEDGE_CLOSED');
  perform pg_temp.soi_reset();
end $$;
