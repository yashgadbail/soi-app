# Decisions

Each entry records what was chosen, what was rejected, and why, so it is not
re-litigated later.

## 001 Clean v2 schema instead of the old migration history

The previous app's SQL was hand-applied in a dashboard, had functions
redefined across files (only the last definition live), a function that
existed only in production, four permissive write policies, a foreign key that
broke API embeds, and no realtime publication. With a blank project available,
the schema was rewritten by domain with the same ledger model and the faults
fixed at the root. Consequence: production cutover needs a one-off data copy
(ids and certificate codes preserved). See RELEASE.md.

## 002 dbmate over Prisma/Drizzle/Atlas/Supabase CLI

The security model is RLS policies, `SECURITY DEFINER` functions, triggers
and grants. ORM migration tools cannot express or diff those (or need paid
tiers), and the client is Dart so an ORM client is dead weight. dbmate is a
single binary, plain SQL with `-- migrate:up/down`, a version table, `status`,
`dump`, and works on any Postgres. Nothing is ever changed in the dashboard.

## 003 Every write is a server function

No client role has insert/update/delete on any table. Registration is
row-locked against capacity, certification checks the caller's role per row,
all validation bounds live in SQL and are mirrored (not replaced) by client
validators. Audit rows are written for every privileged action.

## 004 Riverpod 3 with codegen; automatic retry off

Retry would make error states flicker and hide offline; screens own retry.
Codegen gives typed providers without boilerplate.

## 005 go_router with typed routes; fixed five branches

Rebuilding the router when memberships change would wipe navigation state.
All branches exist; Manage is hidden in the bar until the user coordinates.
Detail routes live on the root navigator so deep links, QR and tabs behave
identically.

## 006 Deep links use `soi://open/<route>`

`soi://drive/x` would parse as host `drive`, path `/x`, and not match the
route. HTTPS App Links are deferred until an `assetlinks.json` is hosted.

## 007 Permissions: CAMERA and INTERNET only

The Play Data Safety form declares no location, photos, audio, files or
contacts. Therefore: no gallery-save plugin (the share sheet reaches Photos
and Files anyway), no connectivity plugin (offline is derived from request
errors), and `tools:node="remove"` on any such permission a plugin might
merge. `ACCESS_NETWORK_STATE` (normal-level, merged by the networking stack)
is tolerated. `tools/check-manifest.ps1` enforces the list before upload.

## 008 Certificate capture via RepaintBoundary

Widget-to-image packages render off-tree without the app's theme. The
certificate is captured from the live tree at 1080 px width inside its own
`Theme` and a no-scaling `MediaQuery`, so dark mode and large text never alter
the shared bytes. A golden test pins it.

## 009 Static Inter instances, no runtime font download

Flutter does not map `FontWeight` to a variable font's `wght` axis without
`fontVariations`; static TTFs are predictable. A runtime font package would
need network at first paint. OFL text is bundled.

## 010 Numeric JSON as `num`

Postgres returns `4` or `4.5`; a Dart `double` field throws on the int.

## 011 Publishing stays open to unverified organisations

Today any registered organisation can publish; the verified badge signals
review. Gating `create_drive` on tier ≥1 would block the pilot's NGOs.
Onboarding phrases it as "Register your organisation" and the form explains
verification. Revisit before the store questionnaire is re-answered.

## 012 Account deletion keeps certificates

Deleting an account removes the profile, memberships, registrations and
signatures. Attendance rows keep the hours for the organisation's ledger
with the person detached; certificates keep their snapshot and remain
verifiable, matching the published deletion policy ("does not retract a
certificate an NGO issued").

## 013 Uniform invite response

`invite_org_member` returns `{status:'ok'}` whether the email has an account
or not, so it cannot be used to probe registered emails.

## 014 Kotlin incremental compilation off

Windows intermittently fails to close Kotlin's incremental caches during
plugin compilation. Non-incremental builds are a few seconds slower and
reliable. Gradle build cache stays on.

## 015 Orientation is not locked

The v1 app locked portrait. A locked orientation letterboxes on foldables
and tablets and fails the Android large-screen tiers; every list here is a
sliver or list view with constrained content width, so landscape works.

## 016 Glass is for chrome only

Frosted surfaces are limited to bars that float over scrolling content (one
BackdropFilter each). Cards, sheets and dialogs stay opaque: nested blurs
are the fastest way to drop frames on a mid-range phone, and text on glass
fails contrast checks.

## 018 Migrations carry no demo rows

The store-review organisation used to be inserted by migration 008 on every
database, production included, with a published demo drive. Now nothing is
inserted until an operator creates the reviewer user and calls
`attach_review_account()`; the drive it creates is a draft, and `soi_stats()`
skips that organisation (010). A fresh production database therefore
contains only schema. Client access to `schema_migrations` is revoked in
010 because dbmate creates that table before Supabase's default grants can
be overridden by a migration.

## 017 Deferred from this release

Facet counts as date chips, a Passport hours chart, a share-my-passport image,
Hindi strings (the ARB pipeline is ready), HTTPS App Links, iOS.
