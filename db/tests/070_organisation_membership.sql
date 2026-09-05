-- Invariants: only admins invite; invites never grant owner; invites are
-- accepted on signup; the sole owner cannot leave; owners cannot be removed;
-- a non-member sees no org members; the invite response is uniform.
do $$
declare
  v_owner uuid := pg_temp.soi_test_user('owner7@test.soi', 'Owner Seven');
  v_coord uuid := pg_temp.soi_test_user('coord7@test.soi', 'Coord Seven');
  v_org uuid; v_json json; v_new uuid; v_members json;
begin
  perform pg_temp.soi_as(v_owner);
  v_org := (public.create_organisation('Members NGO', 'ngo')->>'id')::uuid;
  perform pg_temp.soi_expect_error(format('select public.invite_org_member(%L, ''x@y.zz'', ''owner'')', v_org), 'BAD_ROLE');
  perform pg_temp.soi_expect_error(format('select public.invite_org_member(%L, ''not-an-email'', ''coordinator'')', v_org), 'BAD_EMAIL');
  -- existing user: added immediately; unknown user: pending invite. Same response.
  v_json := public.invite_org_member(v_org, 'COORD7@test.soi', 'coordinator');
  if v_json->>'status' <> 'ok' then raise exception 'invite: %', v_json; end if;
  if public.invite_org_member(v_org, 'future@test.soi', 'member')::text <> v_json::text then raise exception 'invite response not uniform'; end if;
  v_members := public.org_members_list(v_org);
  if json_array_length(v_members) <> 2 then raise exception 'members: %', v_members; end if;
  if json_array_length(public.org_invites_list(v_org)) <> 1 then raise exception 'pending invites should be 1'; end if;
  -- the sole owner cannot leave
  perform pg_temp.soi_expect_error(format('select public.leave_org(%L)', v_org), 'SOLE_OWNER');
  perform pg_temp.soi_reset();

  -- the coordinator now has authority, but not admin rights
  perform pg_temp.soi_as(v_coord);
  if not public.is_org_member(v_org, 'coordinator') then raise exception 'coordinator not a member'; end if;
  perform pg_temp.soi_expect_error(format('select public.invite_org_member(%L, ''z@z.zz'', ''member'')', v_org), 'NOT_AUTHORISED');
  perform pg_temp.soi_expect_error(format('select public.org_members_list(%L)', v_org), 'NOT_AUTHORISED');
  perform pg_temp.soi_expect_error(format('select public.remove_org_member(%L, %L)', v_org, v_owner), 'NOT_AUTHORISED');
  if json_array_length(public.my_memberships()) <> 1 then raise exception 'my_memberships'; end if;
  -- a coordinator can leave
  perform public.leave_org(v_org);
  if json_array_length(public.my_memberships()) <> 0 then raise exception 'leave failed'; end if;
  perform pg_temp.soi_reset();

  -- the invited stranger signs up and is a member immediately
  v_new := pg_temp.soi_test_user('future@test.soi', 'Future Member');
  perform pg_temp.soi_as(v_new);
  v_json := public.my_memberships();
  if json_array_length(v_json) <> 1 or v_json->0->>'role' <> 'member' then raise exception 'invite not accepted on signup: %', v_json; end if;
  perform pg_temp.soi_reset();

  -- owners cannot be removed; members can; a cancelled invite is gone
  perform pg_temp.soi_as(v_owner);
  perform pg_temp.soi_expect_error(format('select public.remove_org_member(%L, %L)', v_org, v_owner), 'CANNOT_REMOVE_OWNER');
  perform public.remove_org_member(v_org, v_new);
  perform pg_temp.soi_expect_error(format('select public.remove_org_member(%L, %L)', v_org, v_new), 'MEMBER_NOT_FOUND');
  perform public.invite_org_member(v_org, 'pending@test.soi', 'member');
  perform public.cancel_invite(v_org, 'pending@test.soi');
  if json_array_length(public.org_invites_list(v_org)) <> 0 then raise exception 'cancel_invite failed'; end if;
  perform pg_temp.soi_reset();

  -- statistics are public and count what they claim
  perform pg_temp.soi_as(null);
  v_json := public.soi_stats();
  if (v_json->>'organisations')::int < 1 or not (v_json::jsonb ? 'certified_hours') then raise exception 'stats: %', v_json; end if;
  perform pg_temp.soi_reset();
end $$;
