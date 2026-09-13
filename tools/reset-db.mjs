// Empties a Supabase project so the migrations can be applied from scratch:
// drops every table, view and function in the public schema plus the auth
// signup trigger, and with --auth-users also deletes every account.
//
// Two guards, both deliberate:
//   * the project ref must be named on the command line AND appear in
//     DATABASE_URL, so a stale shell variable can never wipe the wrong one;
//   * the live v1 project (eeodwxisgcpjnkawwcgf, the React Native app's
//     data) is refused outright.
//
//   DATABASE_URL=postgres://... node reset-db.mjs --project <ref> [--auth-users]
//   then: npm run db:up
import pg from 'pg';

const args = process.argv.slice(2);
const ref = args[args.indexOf('--project') + 1];
const withAuthUsers = args.includes('--auth-users');
if (args.indexOf('--project') < 0 || !ref || ref.startsWith('--')) {
  throw new Error('Usage: node reset-db.mjs --project <ref> [--auth-users]');
}
if (ref === 'eeodwxisgcpjnkawwcgf') throw new Error('Refusing: that is the live v1 project');
const url = process.env.DATABASE_URL;
if (!url) throw new Error('DATABASE_URL is not set');
if (!url.includes(ref)) throw new Error(`Refusing: DATABASE_URL does not point at project ${ref}`);

const c = new pg.Client({ connectionString: url.replace(/\?sslmode=\w+/, ''), ssl: { rejectUnauthorized: false } });
await c.connect();
const count = async () => (await c.query(`select
  (select count(*) from pg_tables where schemaname = 'public')::int as tables,
  (select count(*) from pg_views where schemaname = 'public')::int as views,
  (select count(*) from pg_proc p join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public')::int as functions,
  (select count(*) from auth.users)::int as auth_users`)).rows[0];
console.log('before:', await count());
await c.query(`
do $$ declare r record; begin
  execute 'drop trigger if exists on_auth_user_created on auth.users';
  for r in select viewname from pg_views where schemaname = 'public' loop
    execute format('drop view if exists public.%I cascade', r.viewname); end loop;
  for r in select tablename from pg_tables where schemaname = 'public' loop
    execute format('drop table if exists public.%I cascade', r.tablename); end loop;
  for r in select p.oid::regprocedure as sig from pg_proc p
           join pg_namespace n on n.oid = p.pronamespace where n.nspname = 'public' loop
    execute format('drop function if exists %s cascade', r.sig); end loop;
end $$;`);
if (withAuthUsers) await c.query('delete from auth.users');
console.log('after: ', await count());
await c.end();
