# Architecture

## Shape

```
┌──────────────────────── Flutter app (lib/) ────────────────────────┐
│ features/*   screens + per-feature providers (Riverpod, codegen)   │
│ ui/          design system: cards, chips, states, sheets, QR, motion│
│ router/      typed go_router routes, shell tabs, auth guard         │
│ data/        models (freezed), repositories (one method per RPC),  │
│              session controller, on-device snapshots               │
│ core/        env, links, SoiError + message map, theme tokens,      │
│              formatting, validators, QR payloads                    │
└────────────────────────────┬───────────────────────────────────────┘
                             │ supabase_flutter (PostgREST rpc + realtime)
┌────────────────────────────┴───────────────────────────────────────┐
│ Postgres (Supabase)                                                 │
│  tables with RLS ── read policies only ── every write is a          │
│  SECURITY DEFINER function that validates, authorises, audits       │
│  db/migrations/*.sql (dbmate) is the only way the schema changes    │
└─────────────────────────────────────────────────────────────────────┘
```

## Layers and rules

**Screens never talk to Supabase.** They watch providers and call repository
methods. A repository method maps one-to-one to a server function and returns
a typed model; anything thrown is a `SoiError` with a stable key.

**No table writes from the client.** The database has no insert/update/delete
policies for app roles. `registrations`, `attendance`, `certificates`,
`organisations`, everything: written only by functions. This is enforced by
`db/tests/020_secrets_and_visibility.sql`, not by convention.

**Errors are keys, not sentences.** Server functions `raise exception 'KEY'`.
`SoiError.from` extracts the key; `errorMessage()` turns it into copy from the
ARB file. A test fails if a key raised in SQL has no message.

**Async screens have three explicit states**: `LoadingView`, `ErrorView`
(with retry; offline and not-found are distinguished), `EmptyView`. An error is
never rendered as an empty list.

**Sign-in gates doing, not looking.** Discover, drive, organisation, pledge and
certificate pages are public. The tabs render a `SignedOutView` when needed.
Gated routes carry `from=` so the original target survives sign-in.

## State

Riverpod 3 with code generation.

- `sessionControllerProvider` (keepAlive): session, profile, memberships,
  first-run flags. Preloaded in `main()` with a 3 s timeout and a snapshot
  fallback so the router can decide synchronously and offline.
- Feature providers are autoDispose futures keyed by id (`driveDetail(id)`,
  `pledgeDetail(code)`, `orgDrives(orgId)`…). Mutations invalidate them.
- `DiscoverController` holds query/filters/sort/pages with a generation
  counter so a slow old response never overwrites a newer one.
- `DriveRoster` (Coordinator Mode) owns the realtime subscription: UPDATE
  patches the row in place, INSERTs are coalesced for 300 ms then fetched once,
  reconnect triggers a full fetch.
- Automatic retry is disabled at the `ProviderScope`; screens show retry.

## Navigation

`go_router` with `go_router_builder`. Five `StatefulShellRoute` branches
always exist; the Manage destination is hidden in the bar until the user
coordinates an organisation, so the router is never rebuilt. Detail routes
live on the root navigator (no bottom bar) and are the same whether reached
from a tab, a QR or a deep link (`soi://open/drive/<id>`, `/pledge/<code>`,
`/certificate/<code>`).

Redirect order: signed-out + gated → sign-in; signed-in without name →
onboarding name; without intent → onboarding intent; auth/onboarding pages
when done → `from` or Discover; manage sub-pages without rights → Manage hub.

## Data flow examples

**Check-in.** Scan → `QrPayload.parse` → `DrivesRepo.checkIn(drive, code)` →
server validates the secret code, creates a *pending* attendance row → result
sheet → Passport provider invalidated.

**Certification.** Coordinator Mode → `certify_attendance(ids)` → server checks
the caller coordinates the drive's organisation, marks rows certified, mints
one certificate per row (snapshot of name, organisation, title, hours) →
realtime UPDATE patches the roster → volunteer's Passport shows the code.

**Verification.** Anyone → `verify_certificate(code)` → issuance facts only.
The in-app certificate renders from that same call, so holder and verifier see
identical bytes.

## Offline and caching

- First Discover page and the Passport are persisted as JSON snapshots and
  painted immediately on cold start; the network result replaces them.
- Profile and memberships are snapshotted per user for the router's benefit.
- Snapshots are cleared on sign-out. Nothing private to another user is
  ever stored.
- Offline is detected from socket/timeout errors on the request itself; no
  connectivity plugin.

## Theme

Material 3, light and dark from the system. Brand tokens live in a
`ThemeExtension` (`SoiColors`); components are styled once in `SoiTheme`.
The certificate uses a fixed palette and a no-scaling text scaler inside its
own `Theme`, so it is identical in both themes and at any text size (pinned
by a golden test). Body text scaling is capped at 1.3× app-wide.

## Build-time configuration

`--dart-define-from-file=.env` supplies `SUPABASE_URL`,
`SUPABASE_PUBLISHABLE_KEY`, `SOI_WEB_ORIGIN`. Missing values show a
configuration error screen rather than crashing.
