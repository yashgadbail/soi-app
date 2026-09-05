-- migrate:up
-- =====================================================================
-- 008 app-review seed
--
-- Why:   store reviewers sign in with a password account that cannot
--        receive email. This seed gives that account an organisation to
--        coordinate and a drive to inspect, so both sides of the app are
--        visible to the reviewer.
-- What:  a demo organisation with a fixed id, and attach_review_account(),
--        which links the reviewer user (created by hand in the auth
--        dashboard, email play-review@swagofindia.org) to it. Safe to run
--        repeatedly; a no-op until the user exists.
-- Calls: attach_review_account is not callable by clients. Run it from a
--        migration or an operator session after creating the user.
-- =====================================================================

insert into public.organisations (id, type, name, about, city, verification_tier)
values ('44444444-4444-4444-4444-444444444444', 'ngo', 'Demo NGO (App Review)',
        'Sample organisation so app reviewers can see the coordinator features.',
        'Nashik', 2)
on conflict (id) do nothing;

create or replace function public.attach_review_account()
returns void language plpgsql security definer set search_path = public, extensions, auth, pg_temp as $$
declare v_uid uuid; v_org uuid := '44444444-4444-4444-4444-444444444444';
begin
  select id into v_uid from auth.users where email = 'play-review@swagofindia.org';
  if v_uid is null then return; end if;

  update public.profiles set full_name = 'Play Reviewer'
   where id = v_uid and coalesce(btrim(full_name), '') = '';

  insert into public.org_members (org_id, user_id, role) values (v_org, v_uid, 'owner')
  on conflict (org_id, user_id) do update set role = 'owner';

  if not exists (select 1 from public.drives where org_id = v_org and status = 'published' and ends_at > now()) then
    insert into public.drives (org_id, title, description, cause, venue, city, starts_at, ends_at,
                               capacity, default_hours, created_by)
    values (v_org, 'Demo drive (App Review)',
            'A sample drive so reviewers can register, check in and see certification.',
            'Community', 'Godavari Ghat', 'Nashik',
            date_trunc('day', now()) + interval '3 days 9 hours',
            date_trunc('day', now()) + interval '3 days 13 hours',
            40, 4, v_uid);
  end if;
end $$;

select public.lock_fn('public.attach_review_account()');
select public.attach_review_account();

-- migrate:down
drop function if exists public.attach_review_account();
delete from public.organisations where id = '44444444-4444-4444-4444-444444444444';
