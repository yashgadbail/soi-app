# Release

## Identity that must never change

- Application id `org.swagofindia.soi` (same listing as the app on Play).
- Upload key: `E:\MOBILE-APPS\soi-signing\soi-release.keystore`, alias `soi`.
  Not in this repository. **Back it up off-machine.** Losing it means never
  updating the app again under this name.
- Signing properties live in the user-level `~/.gradle/gradle.properties`:
  ```
  SOI_UPLOAD_STORE_FILE=E:/MOBILE-APPS/soi-signing/soi-release.keystore
  SOI_UPLOAD_KEY_ALIAS=soi
  SOI_UPLOAD_STORE_PASSWORD=…
  SOI_UPLOAD_KEY_PASSWORD=…
  ```
  Gradle does not read the `.env.*` files. `android/app/build.gradle.kts` refuses to build
  a release bundle without these properties.

## Versioning

`pubspec.yaml` `version: 2.0.0+6`. The build number must exceed the latest
versionCode on Play (5 at the time of writing). Override at build time when in
doubt: `--build-number <N>`.

## Build

```bash
flutter build appbundle --release \
  --dart-define-from-file=.env.prod \
  --obfuscate --split-debug-info=build/symbols \
  --build-number 6
```

Outputs: `build/app/outputs/bundle/release/app-release.aab`, R8 mapping under
`build/app/outputs/mapping/release/`, Dart symbols under `build/symbols/`
(archive both with the release; upload the mapping to Play for readable
crash reports).

## GitHub Actions

`.github/workflows/android-release.yml` has three jobs.

- `checks` (every pull request and push to `main`, Windows runner):
  `flutter analyze` and `flutter test`.
- `release` (pushes to `main` and manual runs): builds the signed AAB and APK
  with obfuscation, verifies the signer and the permission allowlist, and
  stores the packages, R8 mapping and Dart symbols as a 30-day artifact. A
  manual run with `publish_release` on also creates a GitHub Release.
- `publish` (manual runs only): uploads that same AAB to Google Play on the
  track chosen at dispatch time, together with the mapping file and the
  release notes in `distribution/whatsnew/`.

Repository secrets for `release`:

- `SOI_DART_DEFINES`: the three lines of `.env.dev` (internal and testing
  builds run against the dev project).
- `SOI_DART_DEFINES_PRODUCTION`: same shape, pointing at the production
  Supabase project. Read only when the track is `production`; the job stops
  if it is missing, so a production run can never silently ship the dev
  configuration.
- `SOI_UPLOAD_KEYSTORE_BASE64`: base64-encoded `soi-release.keystore`.
- `SOI_UPLOAD_STORE_PASSWORD`, `SOI_UPLOAD_KEY_ALIAS`, `SOI_UPLOAD_KEY_PASSWORD`.

The build number is 1000 + the workflow run number, or the repository variable
`ANDROID_BUILD_NUMBER` when that is set higher. Play rejects an upload whose
versionCode is not above every existing release; if that happens, raise the
variable rather than re-running.

### Publishing to Google Play from CI

One-time setup, done by the Play Console owner:

1. Google Cloud Console: pick or create a project, enable the **Google Play
   Android Developer API**, create a service account (it needs no Cloud
   roles) and download a JSON key for it.
2. Play Console → **Users and permissions** → **Invite new users** → the
   service account's email. Under app permissions for SWAG of India grant
   **Release to testing tracks**; add **Release to production, exclude
   devices, and use Play App Signing** only when production publishing is
   wanted. Never make it an admin, and give it no listing or pricing rights.
3. GitHub → **Settings → Secrets and variables → Actions**: secret
   `PLAY_SERVICE_ACCOUNT_JSON` with the JSON key contents.
4. GitHub → **Settings → Environments**: the workflow uses `play-internal`,
   `play-alpha`, `play-beta` and `play-production` (created on first use).
   Add **required reviewers** to `play-production` so a production upload
   pauses for approval after the build is verified. Optionally store
   `PLAY_SERVICE_ACCOUNT_JSON` there instead of at repository level.
5. The first upload of a brand-new package must be done by hand in the
   Console. This listing already has releases, so the API path works.

Running a release: **Actions → Android CI and release → Run workflow**,
choose `play_track`:

- `internal`: published to internal testers straight away. Every candidate
  goes here first.
- `alpha` / `beta`: the Console's Closed and Open testing tracks, published
  straight away.
- `production`: staged rollout at `rollout_fraction` (default `0.1`, that is
  10 %). Enter `1` for a full rollout. Widen or halt afterwards in the
  Console under **Release → Production → Manage rollout**; re-running the
  workflow builds and uploads a new bundle instead.
- `none`: build and archive only (the default).

Release notes come from `distribution/whatsnew/whatsnew-en-US`; edit it
before dispatching and add `whatsnew-hi-IN` and others for further listing
languages. Play allows 500 characters per file.

Guard rails: production needs the cutover below finished and
`SOI_DART_DEFINES_PRODUCTION` in place; the service account holds release
rights only, so the listing, pricing and signing key stay manual; the
bundle is signed with the upload key, Play re-signs it with the app
signing key exactly as it does for Console uploads.

## Required branch protection

In GitHub, protect `main` under **Settings -> Branches -> Add branch ruleset**:

- Require a pull request before merging.
- Require approvals (at least one reviewer).
- Require status checks to pass, and select `Android CI and release / checks`.
- Require branches to be up to date before merging.
- Require conversation resolution before merging.
- Do not allow force pushes or branch deletion.
- Restrict direct pushes to administrators too, unless an emergency bypass is
   intentionally needed.

Do not select the `release` job as the PR requirement; it is intentionally
skipped for pull requests because signing secrets must not be exposed there.

## Pre-upload checks (all must pass)

```powershell
pwsh tools/verify-aab-signer.ps1 build/app/outputs/bundle/release/app-release.aab
#   expect CN=Yash Gadbail
pwsh tools/check-manifest.ps1 build/app/outputs/flutter-apk/app-release.apk
#   (build a release APK for this check, or pass -Bundletool for the AAB)
flutter analyze && flutter test
```
Plus the device round trip in TESTING.md.

## Cutover from the v1 app

The v2 schema is not the v1 schema. Before the Play release:

1. Apply `db/migrations` to the production project with dbmate
   (`npm run db:up` with `DATABASE_URL` pointing at production; the tests
   refuse production, the migrations do not).
2. Copy v1 data into the v2 tables with a one-off SQL script, preserving ids
   and certificate codes: organizations→organisations, events→drives
   (+ codes into drive_checkin_codes), registrations, students, attendance,
   pledges, pledge_signatures, certificates, profiles, org_members.
3. Put the three lines of `.env.prod` in the `SOI_DART_DEFINES_PRODUCTION`
   secret; a local production build uses `--dart-define-from-file=.env.prod`.
4. Existing users must sign in again (different session storage): say so in
   the Play "What's new".
5. The web verify page calls `verify_certificate(p_code)` — unchanged.
   `soi_stats()` keys are unchanged for the landing page.

## Rollout

Use a **staged rollout** (the workflow's `production` track starts one at
`rollout_fraction`, default 10%): watch Android vitals and crash reports for
48 hours, then widen in the Console.
Rollback = halt the rollout; the previous AAB stays live for users who have
not updated.

## Store declarations to keep true

Content rating 3+ with "users interact" = No (only coordinators publish;
no comments, no messaging). Target audience 13+. Data safety: name, email,
phone (students, school-held), city/class/roll, app activity; nothing for
location, photos, audio, files, contacts, device ids. Camera decodes QR
on-device and stores nothing. Any feature that adds user-to-user interaction
breaks the rating and forces the questionnaire to be re-answered.
