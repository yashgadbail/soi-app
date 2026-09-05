# Testing

## Automated

| Suite | Where | What it proves |
|---|---|---|
| Database invariants | `db/tests/*.sql` via `tools/db-test.mjs` | The security model, as anon and as real users, in rolled-back transactions. Refuses to run against production. |
| Unit | `test/unit/` | Error key extraction and classification; QR payload parsing; every validator bound; date/number formatting. |
| Error key coverage | `test/unit/error_key_coverage_test.dart` | Every `raise exception 'KEY'` in the migrations has a sentence in the app. |
| Widget | `test/widget/` | The state views: offline vs rule vs not-found are distinct, raw server text never shows, no overflow at 1.3× text. |
| Golden | `test/golden/` | The certificate is pixel-identical in light and dark and at 1.3× text; long names and titles do not overflow. |

Run everything:

```bash
flutter analyze
flutter test
cd tools && DATABASE_URL='postgres://…dev…' npm run db:test
```

Regenerate goldens only when the certificate design changes on purpose:
`flutter test --update-goldens`. Goldens are rendered with the bundled Inter
fonts (`test/flutter_test_config.dart`) on this project's Windows toolchain.

## Device round trip (before every release)

Two accounts: a coordinator (owner of an organisation) and a volunteer.

1. Volunteer: sign up with a fresh email → name → intent "I volunteer" →
   lands on Discover. Search a word from a drive title; filter by cause and
   city; sort by hours; page 2 loads.
2. Volunteer: open a drive → Register → spots count drops → Cancel → rises.
3. Coordinator: Manage → Publish a drive → it appears in Discover.
4. Coordinator: drive → Coordinator Mode. Screen stays awake, brightness up.
5. Volunteer: Check in → scan the QR → result sheet says pending, names the
   organisation. Scan again → "already checked in".
6. Coordinator: the roster row appears without pulling to refresh (realtime).
   Rotate the code; the volunteer's old QR is refused.
7. Coordinator: Certify → the row turns green live; the volunteer's Passport
   shows the hours and a certificate code.
8. Volunteer: certificate → share as image (renders the same in dark mode),
   copy the number; anyone verifies at the verify page.
9. Coordinator: reject a second volunteer → their Passport shows "not counted".
10. Pledge: create → open via code on Welcome → sign → certificate; body edit
    refused after signing; delete refused, close works.
11. School: register a school → roster → enrol two students (one with an
    email) → mark them present at the NGO's drive → NGO certifies → student
    signs up with the enrolled email and is linked automatically; the other
    claims with the code.
12. Airplane mode on Discover and Passport: snapshots paint, retry shown, no
    empty state.
13. TalkBack: tabs, buttons and the certificate are announced sensibly.
14. Profile: sign out (confirm), sign back in, delete account (confirm);
    the certificate still verifies.

Capture screenshots with `adb exec-out screencap -p > shot.png`.
