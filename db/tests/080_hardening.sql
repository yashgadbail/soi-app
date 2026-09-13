-- Invariants: the migrations table is unreadable by clients, and the store
-- review organisation never leaks into public surfaces.
do $$
declare
  v_vol    uuid := pg_temp.soi_test_user('vol8@test.soi', 'Vol Unteer');
  v_org    uuid := '44444444-4444-4444-4444-444444444444';
  v_before int;
  v_after  int;
  v_n      int;
  v_status text;
  v_uid    uuid;
begin
  -- 1. schema_migrations is unreadable by anon and by signed-in users
  perform pg_temp.soi_as(null);
  perform pg_temp.soi_expect_error('select * from public.schema_migrations', 'permission denied');
  perform pg_temp.soi_reset();
  perform pg_temp.soi_as(v_vol);
  perform pg_temp.soi_expect_error('select * from public.schema_migrations', 'permission denied');
  perform pg_temp.soi_reset();

  -- 2. without the reviewer user, attach_review_account inserts nothing
  delete from public.organisations where id = v_org;
  select count(*) into v_before from public.organisations;
  perform public.attach_review_account();
  select count(*) into v_after from public.organisations;
  if v_after <> v_before then
    raise exception 'attach_review_account created rows without a reviewer user';
  end if;

  -- 3. with the reviewer user it creates the organisation and a DRAFT drive
  v_before := (public.soi_stats()->>'organisations')::int;
  v_uid := pg_temp.soi_test_user('play-review@swagofindia.org');
  perform public.attach_review_account();
  select status into v_status from public.drives where org_id = v_org;
  if v_status is distinct from 'draft' then
    raise exception 'review drive should be a draft, got %', v_status;
  end if;
  if not exists (select 1 from public.org_members where org_id = v_org and user_id = v_uid and role = 'owner') then
    raise exception 'reviewer is not owner of the review organisation';
  end if;

  -- 4. it is invisible to the public: stats unchanged, discover and facets empty
  v_after := (public.soi_stats()->>'organisations')::int;
  if v_after <> v_before then
    raise exception 'soi_stats counted the review organisation (% -> %)', v_before, v_after;
  end if;
  perform pg_temp.soi_as(null);
  select count(*) into v_n from public.discover_drives(null, null, null, 'soonest', 50, 0) d
   where d.org_id = v_org;
  if v_n <> 0 then raise exception 'review drive visible in discover_drives'; end if;
  select count(*) into v_n from public.drives where org_id = v_org;
  if v_n <> 0 then raise exception 'anon can see the review draft through RLS'; end if;
  perform pg_temp.soi_reset();

  -- 5. a plain volunteer cannot call it
  perform pg_temp.soi_as(v_vol);
  perform pg_temp.soi_expect_error('select public.attach_review_account()', 'permission denied');
  perform pg_temp.soi_reset();
end $$;
