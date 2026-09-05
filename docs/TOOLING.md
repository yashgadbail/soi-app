# Tooling

| Tool | Version / location | Notes |
|---|---|---|
| Flutter | 3.47.2 stable at `E:\flutter` (on user PATH) | Dart 3.13.2 |
| Android SDK | `E:\Android` | platform 36, build-tools 36.0.0, cmdline-tools |
| JDK | Microsoft OpenJDK 17.0.20 | `flutter config --jdk-dir` points here |
| Gradle | 9.3.1 (wrapper, `bin` distribution) | AGP 9.1.0, Kotlin 2.4.0; `kotlin.incremental=false` (see DECISIONS 014) |
| Node | 24 | only for `tools/` (dbmate wrapper, pg client, tests) |
| dbmate | 2.35.1 via npm in `tools/` | `npm run db:status | db:up | db:down | db:new | db:dump | db:test` |
| pg_dump | not installed | `db:dump` needs it; install PostgreSQL 17 client tools or skip the dump |
| adb | `E:\Android\platform-tools\adb.exe` | device `RFCR919ZS2N` (Samsung, Android 13) used for round trips |

## Codegen

```bash
dart run build_runner build --delete-conflicting-outputs   # freezed, json, riverpod, go_router
flutter gen-l10n                                            # lib/l10n/generated
dart run flutter_launcher_icons                             # adaptive icons from assets/brand
```
Generated files are committed only where the analyzer needs them; `*.g.dart`
and `*.freezed.dart` are regenerated on every build.

## Database

```bash
cd tools
export DATABASE_URL='postgresql://postgres:<url-encoded password>@db.<ref>.supabase.co:5432/postgres?sslmode=require'
npm run db:status
npm run db:up
npm run db:test          # dev only; creates and rolls back throwaway users
```
The password is never written to a file. The direct host is IPv6; if your
network lacks IPv6 use the session-pooler URI from the dashboard.

## Lints

`very_good_analysis` with a few app-appropriate exemptions documented in
`analysis_options.yaml`. `flutter analyze` must report zero issues.
