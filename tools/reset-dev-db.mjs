// Drops every object in the public schema of the DEV database and the auth trigger.
// Guarded: refuses to run unless the host is the dev project. Never point this at production.
import pg from 'pg';
const url = process.env.DATABASE_URL;
if (!url) throw new Error('DATABASE_URL is not set');
if (!url.includes('wancnwamybngeihmwmcl')) throw new Error('Refusing: DATABASE_URL is not the dev project');
const c = new pg.Client({ connectionString: url.replace(/\?sslmode=\w+/, ''), ssl: { rejectUnauthorized: false } });
await c.connect();
await c.query(`
do $$ declare r record; begin
  execute 'drop trigger if exists on_auth_user_created on auth.users';
  for r in select viewname from pg_views where schemaname='public' loop
    execute format('drop view if exists public.%I cascade', r.viewname); end loop;
  for r in select tablename from pg_tables where schemaname='public' loop
    execute format('drop table if exists public.%I cascade', r.tablename); end loop;
  for r in select p.oid::regprocedure as sig from pg_proc p join pg_namespace n on n.oid=p.pronamespace where n.nspname='public' loop
    execute format('drop function if exists %s cascade', r.sig); end loop;
end $$;`);
const r = await c.query(`select (select count(*) from pg_tables where schemaname='public') t,
  (select count(*) from pg_proc p join pg_namespace n on n.oid=p.pronamespace where n.nspname='public') f,
  (select count(*) from pg_views where schemaname='public') v`);
console.log('public objects left:', r.rows[0]);
await c.end();
