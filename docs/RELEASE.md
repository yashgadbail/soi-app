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
  Gradle does not read `.env`. `android/app/build.gradle.kts` refuses to build
  a release bundle without these properties.

## Versioning

`pubspec.yaml` `version: 2.0.0+6`. The build number must exceed the latest
versionCode on Play (5 at the time of writing). Override at build time when in
doubt: `--build-number <N>`.

## Build

```bash
flutter build appbundle --release \
  --dart-define-from-file=.env \
  --obfuscate --split-debug-info=build/symbols \
  --build-number 6
```

Outputs: `build/app/outputs/bundle/release/app-release.aab`, R8 mapping under
`build/app/outputs/mapping/release/`, Dart symbols under `build/symbols/`
(archive both with the release; upload the mapping to Play for readable
crash reports).

## GitHub Actions

`.github/workflows/android-release.yml` runs analysis and tests on every pull
request targeting `main`. After merge, it repeats those checks before building
the signed AAB and APK, checking the signer and manifest, and storing the
packages, mapping and Dart symbols as a 30-day Actions artifact. To enable it,
add these repository secrets:

- `SOI_DART_DEFINES`: the complete contents of the deployment `.env` file.
- `SOI_UPLOAD_KEYSTORE_BASE64`: base64-encoded `soi-release.keystore`.
- `SOI_UPLOAD_STORE_PASSWORD`, `SOI_UPLOAD_KEY_ALIAS`, `SOI_UPLOAD_KEY_PASSWORD`.

The workflow automatically assigns a unique Android build number from the
GitHub run number. If the current Play `versionCode` ever exceeds that value,
set the optional repository variable `ANDROID_BUILD_NUMBER` to a higher value.
A workflow-dispatch run with `publish_release` enabled additionally creates a
GitHub Release; this does not upload to Google Play automatically.

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
3. Point `.env` at production (URL + publishable key) and rebuild.
4. Existing users must sign in again (different session storage): say so in
   the Play "What's new".
5. The web verify page calls `verify_certificate(p_code)` — unchanged.
   `soi_stats()` keys are unchanged for the landing page.

## Rollout

Use a **staged rollout** (available now that a production release exists):
start at 10%, watch Android vitals and crash reports for 48 hours, widen.
Rollback = halt the rollout; the previous AAB stays live for users who have
not updated.

## Store declarations to keep true

Content rating 3+ with "users interact" = No (only coordinators publish;
no comments, no messaging). Target audience 13+. Data safety: name, email,
phone (students, school-held), city/class/roll, app activity; nothing for
location, photos, audio, files, contacts, device ids. Camera decodes QR
on-device and stores nothing. Any feature that adds user-to-user interaction
breaks the rating and forces the questionnaire to be re-answered.
