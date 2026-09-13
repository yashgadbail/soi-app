# SWAG of India (SOI)

Volunteering drives run by NGOs, schools and companies. A volunteer registers,
turns up, scans the coordinator's QR code, and the organisation that ran the
drive certifies the hours. Every certified hour produces a certificate that
anyone can verify at `soi.yashgb.com/verify.html` without an account.

**The one promise:** an hour only counts when the NGO that ran the drive
countersigns it. Every design decision defends that.

| | |
|---|---|
| App | Flutter 3.47 (Dart 3.13), Android. Package `org.swagofindia.soi` |
| Backend | Postgres on Supabase: row-level security, every write through a server function |
| Migrations | Plain SQL, versioned with dbmate (`db/migrations`) |
| Docs | [docs/](docs/) — start with [ARCHITECTURE.md](docs/ARCHITECTURE.md), [HANDOFF.md](docs/HANDOFF.md) and [SUPABASE_SETUP.md](docs/SUPABASE_SETUP.md) |

## Run it

```bash
cp .env.example .env.dev       # fill in SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY
flutter pub get
dart run build_runner build    # models, providers, routes
flutter gen-l10n               # strings
flutter run --dart-define-from-file=.env.dev
```

## Check it

```bash
flutter analyze                # zero issues is the bar
flutter test                   # unit, widget and golden tests
cd tools && DATABASE_URL=... npm run db:test    # database invariant tests
```

## Ship it

See [docs/RELEASE.md](docs/RELEASE.md). Short version: same package and upload
key as the app already on Google Play, verify the signer before uploading, use
a staged rollout.

## Layout

```
lib/            app code — core/ (env, errors, theme, utils), data/ (models,
                repositories, session, snapshots), features/<screen>/, ui/, router/
db/             migrations/ (dbmate), tests/ (invariant checks), schema.sql (dump)
docs/           the product of record: architecture, contract, design, screens,
                decisions, security, testing, release, tooling, data safety, handoff
tools/          db runner (node + dbmate), AAB signer check, manifest check
android/        committed Gradle project; signing from the user-level gradle.properties
assets/         brand icon layers and the Inter font (OFL)
test/           unit/, widget/, golden/
```
