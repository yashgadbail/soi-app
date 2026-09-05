# Security model

## Threat model

The product's value is a certificate that a college or employer trusts. The
attacks that matter are therefore: forging attendance, certifying oneself,
minting or altering a certificate, reading another person's data, and
escalating to coordinator or owner of an organisation.

## Controls

**Row-level security on every table; no client write policies.** App roles
(`anon`, `authenticated`) can only *select*, and only what a policy allows.
Every mutation is a `SECURITY DEFINER` function that validates input, checks
`is_org_member(org, role)`, and writes an `audit_log` row. Tables no client
role can read at all: `drive_checkin_codes`, `students`, `org_invites`,
`audit_log`, `content_reports`.

**The check-in code is a secret.** It lives in `drive_checkin_codes`, is
handed out only by `get_checkin_code()` to coordinators, and can be rotated.
`check_in()` compares server-side and creates a *pending* row. A photographed
QR is neutralised by rotating.

**Only the drive's organisation certifies.** `certify_attendance` and
`reject_attendance` check coordinator membership of the drive's organisation
for every id in the batch. Teachers can mark their own pupils present
(pending) but cannot certify.

**Certificates are snapshots.** Name, organisation and title are copied at
issue time. Codes are derived from random UUIDs. `verify_certificate` is
public and returns issuance facts only; contact details never appear in any
public or coordinator-facing function (`roster`, `pledge_signers` return
names only).

**Privilege boundaries.** Owners are minted only by `create_organisation`.
Admins can invite admins/coordinators/members, never owners. The last owner
cannot leave. `verification_tier` has no client path at all; it is set by the
operator in the database.

**Function privileges are explicit.** The platform's default privileges grant
EXECUTE on new functions to anon and authenticated; every function in the
migrations revokes that and re-grants deliberately (`grant_rpc`, `lock_fn`).
Trigger and helper functions are locked to everyone.

**search_path is pinned** to `public, extensions, pg_temp` on every function,
so extension functions resolve and object lookups cannot be hijacked.

**Input bounds** are enforced in SQL (the real boundary) and mirrored in
`lib/core/utils/validators.dart` for immediate feedback.

**Uniform responses** where an answer would leak membership: inviting an
email returns the same shape whether or not it has an account.

## What the client stores

Session tokens (Supabase SDK, app-private storage), the user's own profile and
memberships, the first Discover page and their own Passport as JSON snapshots.
Cleared on sign-out. No photos, no location, no contacts.

## Verification

`db/tests/*.sql` run as anon and as specific users and assert: secrets are
unreadable, direct writes are refused, capacity is enforced, only the right
coordinator certifies, the verifier leaks nothing, account deletion detaches
but does not retract, invites cannot escalate, the sole owner cannot leave.
Run with `npm run db:test` in `tools/` against a non-production database.

## Reporting

`report_content` exists for Play's UGC requirements; reports are stored
server-side for operator review, rate-limited per user.
