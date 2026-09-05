# Handoff

Inventory of where everything is and what state it is in. Companion to
ARCHITECTURE.md (how it works) and RELEASE.md (how it ships).

Last updated: 5 September 2026.

## Do these first

1. Read ARCHITECTURE.md and SECURITY.md. The invariants there are not
   negotiable: pending-only check-in, coordinator-only certification, secret
   check-in code, snapshot certificates, no client writes, children hold no
   accounts, no user-to-user interaction.
2. Never touch the keystore or its passwords except to back them up.
3. Never run migrations against production without reading RELEASE.md
   (cutover needs a data copy first).

## Surfaces

| Surface | Where | State |
|---|---|---|
| Flutter app | this repository, branch `flutter` | Feature-complete: 25 screens, builds, analyzes clean, tests green, runs on device |
| Dev database | Supabase project `wancnwamybngeihmwmcl` | v2 schema (migrations 001–009) applied via dbmate; demo organisation seeded |
| Production database | Supabase project `eeodwxisgcpjnkawwcgf` (v1 schema, serving the live RN app) | Untouched by this work |
| Web pages | `soi.yashgb.com` (landing, verify, privacy, delete-account, child-safety) hosted on Hostinger from the RN repo's `web/` | Unchanged; `verify_certificate` and `soi_stats` keep the same contract |
| Play listing | `org.swagofindia.soi`, v1.2.0 (versionCode 5) in review | The Flutter build is versionCode 6 and has not been uploaded |

## Credentials (locations only)

| What | Where |
|---|---|
| Supabase URL + publishable key (dev) | `.env` (gitignored) |
| Dev database password | Not stored anywhere; the owner pastes it per session as `DATABASE_URL` |
| Upload keystore | `E:\MOBILE-APPS\soi-signing\soi-release.keystore` |
| Signing passwords | `~/.gradle/gradle.properties` (user-level, outside the repo) |
| Play reviewer account | `play-review@swagofindia.org`; create in the dev project's Auth dashboard, then run `select public.attach_review_account()` |

## What was verified

- `flutter analyze`: 0 issues. `flutter test`: 31 tests including the
  certificate goldens. `db/tests`: 6 suites, all invariants hold.
- Debug APK installed and launched on a Samsung M52 (Android 13); Welcome
  renders with live counts from the dev database; no runtime exceptions.
- Merged manifest: CAMERA, INTERNET, ACCESS_NETWORK_STATE and the AndroidX
  private receiver permission only.
- Release bundle: see the release section of the session summary / RELEASE.md
  for the signer check result.

## Open items

| Item | Severity | Notes |
|---|---|---|
| Device round trip not yet walked | High | TESTING.md steps 1–14 need two accounts. The dev project's default SMTP allows a handful of OTP emails per hour; create password users in the dashboard for testing. |
| `pg_dump` not installed | Low | `db/schema.sql` dump is skipped until PostgreSQL client tools are installed. |
| Production cutover script | High (before release) | v1→v2 data copy, RELEASE.md. Not written yet. |
| HTTPS App Links | Low | Requires hosting `assetlinks.json`; `soi://` links work now. |
| Hindi strings | Medium | ARB pipeline ready; `app_hi.arb` not written. |
| Keystore not backed up off-machine | High | Single point of unrecoverable failure. |
| Play reviewer flow on dev | Medium | Create the reviewer user, run `attach_review_account()`, test the password path. |

## Where to look

- A screen's behaviour: SCREENS.md, then `lib/features/<name>/`.
- A server function: CONTRACT.md, then `db/migrations/`.
- Why something is the way it is: DECISIONS.md.
- Colours, type, components: DESIGN.md, `lib/core/theme/`, `lib/ui/`.
- Build and ship: RELEASE.md, TOOLING.md, `tools/`.
