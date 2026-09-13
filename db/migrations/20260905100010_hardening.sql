-- migrate:up
-- =====================================================================
-- 010 hardening
--
-- Why:   two things surfaced in the pre-production audit of the live
--        project.
--        1. dbmate creates public.schema_migrations before any migration
--           runs, so it picks up Supabase's default grants and every
--           anonymous client could list the applied migration versions.
--        2. The public stats counted the store-review organisation and
--           its drives whenever that organisation existed.
-- What:  revoke client access to schema_migrations; make soi_stats skip
--        the review organisation. Draft drives were already excluded
--        from discover_drives, discover_facets and the stats.
-- Calls: no new callable surface.
-- Rollback: restores the previous soi_stats body; the revoke is left in
--        place on purpose (there is no reason to expose the table).
-- =====================================================================

revoke all on public.schema_migrations from public, anon, authenticated;

create or replace function public.soi_stats()
returns json language sql stable security definer set search_path = public, extensions, pg_temp as $$
  select json_build_object(
    'organisations',   (select count(*) from public.organisations
                         where id <> '44444444-4444-4444-4444-444444444444'),
    'drives',          (select count(*) from public.drives
                         where status in ('published','completed')
                           and org_id <> '44444444-4444-4444-4444-444444444444'),
    'certified_hours', coalesce((select sum(hours) from public.attendance where status = 'certified'), 0),
    'volunteers',      (select count(*) from public.profiles),
    'pledges',         (select count(*) from public.pledge_signatures));
$$;

-- migrate:down
create or replace function public.soi_stats()
returns json language sql stable security definer set search_path = public, extensions, pg_temp as $$
  select json_build_object(
    'organisations',   (select count(*) from public.organisations),
    'drives',          (select count(*) from public.drives where status in ('published','completed')),
    'certified_hours', coalesce((select sum(hours) from public.attendance where status = 'certified'), 0),
    'volunteers',      (select count(*) from public.profiles),
    'pledges',         (select count(*) from public.pledge_signatures));
$$;
