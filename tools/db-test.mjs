// Database invariant tests.
//
// Runs every db/tests/*.sql file (except _helpers.sql, which is prepended to each) against DATABASE_URL inside a transaction that
// is always rolled back, so the tests leave no data behind. Each file is a
// plpgsql DO block that uses `set local role` + `request.jwt.claims` to act as
// anon or as a specific authenticated user, and raises on any violated
// invariant. A file passes when it runs without error.
//
// Usage: DATABASE_URL=postgres://... node db-test.mjs
import fs from 'node:fs';
import path from 'node:path';
import pg from 'pg';

const url = process.env.DATABASE_URL;
if (!url) throw new Error('DATABASE_URL is not set');
if (!/vkcbgcqeqxvaipsqqzev|localhost|127\.0\.0\.1/.test(url)) {
  throw new Error('Refusing: tests create throwaway auth users and must not run against production');
}

const dir = path.resolve('../db/tests');
const helpers = fs.readFileSync(path.join(dir, '_helpers.sql'), 'utf8');
const files = fs.readdirSync(dir).filter((f) => f.endsWith('.sql') && !f.startsWith('_')).sort();
const client = new pg.Client({ connectionString: url.replace(/\?sslmode=\w+/, ''), ssl: { rejectUnauthorized: false } });
await client.connect();

let failed = 0;
for (const f of files) {
  const sql = fs.readFileSync(path.join(dir, f), 'utf8');
  const t0 = Date.now();
  try {
    await client.query('begin');
    await client.query(helpers);
    await client.query(sql);
    console.log(`PASS  ${f}  (${Date.now() - t0} ms)`);
  } catch (e) {
    failed++;
    console.log(`FAIL  ${f}\n      ${e.message}${e.where ? '\n      ' + e.where.split('\n')[0] : ''}`);
  } finally {
    await client.query('rollback').catch(() => {});
  }
}
await client.end();
console.log(`\n${files.length - failed}/${files.length} passed`);
process.exit(failed ? 1 : 0);
