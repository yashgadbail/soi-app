-- migrate:up
-- =====================================================================
-- 008 store-review account
--
-- Why:   store reviewers sign in with a password account that cannot
--        receive email. They need an organisation to coordinate so both
--        sides of the app are visible to them.
-- What:  attach_review_account(): links the reviewer user (created by
--        hand in the auth dashboard, email play-review@swagofindia.org)
--        to a review organisation with a fixed id, creating the
--        organisation and one DRAFT drive if they do not exist. Nothing
--        is inserted until that user exists, so a database that never
--        hosts a store review carries no demo rows at all. The draft
--        drive is visible only inside Manage for the reviewer; it never
--        appears in Discover, facets or the public stats.
-- Calls: attach_review_account is not callable by clients. Run it from
--        an operator session after creating the user:
--          select public.attach_review_account();
-- =====================================================================

create or replace function public.attach_review_account()
returns void language plpgsql security definer set search_path = public, extensions, auth, pg_temp as $$
declare v_uid uuid; v_org uuid := '44444444-4444-4444-4444-444444444444';
begin
  select id into v_uid from auth.users where email = 'play-review@swagofindia.org';
  if v_uid is null then return; end if;

  insert into public.organisations (id, type, name, about, city, verification_tier, created_by)
  values (v_org, 'ngo', 'Review organisation (App Review)',
          'Used by store reviewers to inspect the coordinator features. Not a real organisation.',
          'Nashik', 2, v_uid)
  on conflict (id) do nothing;

  update public.profiles set full_name = 'Play Reviewer'
   where id = v_uid and coalesce(btrim(full_name), '') = '';

  insert into public.org_members (org_id, user_id, role) values (v_org, v_uid, 'owner')
  on conflict (org_id, user_id) do update set role = 'owner';

  if not exists (select 1 from public.drives where org_id = v_org and status = 'draft') then
    insert into public.drives (org_id, title, description, cause, venue, city, starts_at, ends_at,
                               capacity, default_hours, status, created_by)
    values (v_org, 'Sample drive (App Review)',
            'A draft drive so reviewers can open Coordinator Mode, the roster and the check-in code.',
            'Community', 'Godavari Ghat', 'Nashik',
            date_trunc('day', now()) + interval '3 days 9 hours',
            date_trunc('day', now()) + interval '3 days 13 hours',
            40, 4, 'draft', v_uid);
  end if;
end $$;

select public.lock_fn('public.attach_review_account()');

-- migrate:down
drop function if exists public.attach_review_account();
delete from public.organisations where id = '44444444-4444-4444-4444-444444444444';
