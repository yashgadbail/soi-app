# Server contract

The exact surface the app depends on. Source of truth: `db/migrations`. The
Dart side is `lib/data/repositories.dart` (one method per function) and
`lib/data/models.dart` (one class per JSON shape).

All functions are `SECURITY DEFINER` with `search_path = public, extensions,
pg_temp`. Privileges are explicit: **auth** = authenticated only, **public** =
anon and authenticated. Errors are raised as bare keys (`raise exception
'KEY'`); the client matches the key, never the sentence.

## Identity (002)

| Function | Returns | Who | Keys |
|---|---|---|---|
| `my_profile()` | `{id, email, full_name, city, created_at, needs_name}` | auth | NOT_SIGNED_IN |
| `my_memberships()` | `[{org_id, org_name, org_type, verification_tier, role, city}]` | auth | NOT_SIGNED_IN |
| `create_organisation(p_name, p_type='ngo', p_about, p_city)` | `{id}`; caller becomes owner | auth | NAME_TOO_SHORT, NAME_TOO_LONG, BAD_TYPE, ABOUT_TOO_LONG, CITY_TOO_LONG |
| `update_organisation(p_org, p_name, p_about, p_city)` | `{id}` | admin | NOT_AUTHORISED, ORG_NOT_FOUND + name bounds |
| `invite_org_member(p_org, p_email, p_role)` | `{status:'ok'}` (uniform: never reveals whether the email has an account) | admin | BAD_EMAIL, BAD_ROLE (owner not allowed) |
| `cancel_invite(p_org, p_email)` | void | admin | INVITE_NOT_FOUND |
| `remove_org_member(p_org, p_user)` | void | admin | MEMBER_NOT_FOUND, CANNOT_REMOVE_OWNER |
| `leave_org(p_org)` | void | member | MEMBER_NOT_FOUND, SOLE_OWNER |
| `org_members_list(p_org)` | `[{user_id, name, email, role, joined_at}]` | admin | NOT_AUTHORISED |
| `org_invites_list(p_org)` | `[{email, role, created_at}]` pending only | admin | NOT_AUTHORISED |
| `delete_my_account()` | void; cascades; certificates keep their snapshot with `user_id = null` | auth | |

Roles: `owner > admin > coordinator > member`. `is_org_member(org, min_role)`
implements the hierarchy and is what every policy and guard calls.

## Drives (003, 004)

| Function | Returns | Who | Keys |
|---|---|---|---|
| `discover_drives(p_query, p_cause, p_city, p_sort='soonest'\|'hours', p_limit≤50, p_offset)` | rows: `id, title, cause, venue, city, starts_at, ends_at, default_hours, capacity, spots_left, org_id, org_name, org_verified, registered` | public | |
| `discover_facets()` | `{causes:[{value,count}], cities:[…]}` | public | |
| `drive_detail(p_drive)` | drive fields + `spots_left, registrations (managers only), registered, can_manage, my_attendance{status,hours,check_in_at}, org{id,name,type,city,verification_tier}` | public | DRIVE_NOT_FOUND |
| `register_for_drive(p_drive)` | `{registered:true, spots_left}`; row-locked capacity check | auth | DRIVE_NOT_FOUND, DRIVE_NOT_OPEN, DRIVE_ENDED, DRIVE_FULL |
| `cancel_registration(p_drive)` | `{registered:false, spots_left}` | auth | NOT_REGISTERED |
| `my_upcoming_drives()` | `[{id, title, starts_at, ends_at, venue, city, org_name, default_hours, status}]` | auth | |
| `create_drive(p_org, p_title, p_starts, p_ends, p_description, p_cause, p_venue, p_city, p_capacity=50, p_hours=4)` | `{id}`; mints the secret check-in code | coordinator | TITLE_TOO_SHORT/LONG, DESCRIPTION_TOO_LONG, CAUSE_TOO_LONG, VENUE_TOO_LONG, CITY_TOO_LONG, END_BEFORE_START, STARTS_IN_PAST, BAD_CAPACITY, BAD_HOURS |
| `update_drive(p_drive, …same)` | `{id}`; past start allowed, cancelled refused | coordinator | same + DRIVE_NOT_FOUND, DRIVE_NOT_OPEN |
| `cancel_drive(p_drive)` | void | coordinator | DRIVE_NOT_FOUND |
| `get_checkin_code(p_drive)` / `rotate_checkin_code(p_drive)` | uuid | coordinator | DRIVE_NOT_FOUND, NOT_AUTHORISED |
| `check_in(p_drive, p_code)` | `{attendance_id, drive_title, org_name, hours, status:'pending', already}` | auth | INVALID_CODE (also for unknown drive), DRIVE_NOT_OPEN |
| `roster(p_drive)` | `[{attendance_id, subject_kind, display_name, class_section, roll_no, school_name, method, status, check_in_at, hours, certified_at}]` — never emails | coordinator | DRIVE_NOT_FOUND, NOT_AUTHORISED |
| `org_drives(p_org)` | `[{id, title, starts_at, ends_at, status, city, venue, cause, default_hours, capacity, registrations, checked_in, pending, certified}]` | coordinator | |
| `organisation_public(p_org)` | `{id, name, type, city, about, verification_tier, created_at, drives_run, certified_hours, upcoming:[…]}` | public | ORG_NOT_FOUND |

Bounds: title 5–120, description ≤4000, cause ≤40, venue ≤160, city ≤60,
capacity 1–5000, hours (0, 12], start ≥ now − 1 h on create.

## Students and attendance (004, 009)

| Function | Returns | Who | Keys |
|---|---|---|---|
| `enrol_participant(p_org, p_name, p_kind='student', p_class, p_roll, p_email, p_phone)` | `{student_id, claim_code, kind, linked}` | coordinator | NAME_TOO_SHORT/LONG, BAD_KIND, CLASS_TOO_LONG, BAD_ROLL, BAD_EMAIL, BAD_PHONE, DUPLICATE_EMAIL, DUPLICATE_ROLL |
| `update_student(p_student, p_name, p_class, p_roll, p_email, p_phone)` | `{student_id}` | coordinator | STUDENT_NOT_FOUND + same |
| `remove_student(p_student)` | void | coordinator | STUDENT_NOT_FOUND, STUDENT_CLAIMED, STUDENT_HAS_RECORDS |
| `org_roster(p_org)` | `[{student_id, full_name, kind, class_section, roll_no, email, phone, claim_code, claimed, certified_hours, pending_hours}]` | coordinator | |
| `mark_students_present(p_drive, p_students[])` | int rows created; pending, method `teacher` | coordinator of the students' org | NO_STUDENTS, DRIVE_NOT_FOUND, DRIVE_NOT_OPEN, NOT_AUTHORISED |
| `drive_marked_students(p_drive)` | `[student_id]` of the caller's own students already at the drive | auth | |
| `claim_student_record(p_claim_code)` | `{student_name, records_claimed}`; links attendance and certificates, fills an empty profile name | auth | INVALID_CLAIM_CODE, ALREADY_CLAIMED |

Student fields: name 2–80, class ≤20, roll `^[A-Za-z0-9/-]{1,12}$`, phone
normalised to 10 digits starting 6–9. Claim codes are 8 upper-hex.

## Certificates (005)

| Function | Returns | Who | Keys |
|---|---|---|---|
| `certify_attendance(p_ids[])` | int certified; pending rows only; one certificate each | coordinator of each drive's org | NOTHING_TO_CERTIFY, NOT_AUTHORISED |
| `reject_attendance(p_ids[])` | int rejected; pending only | coordinator | same |
| `verify_certificate(p_code)` | `{found:false}` or `{found, valid, code, kind, subject_name, org_name, title, hours, issued_at, revoked_reason}` | public | |
| `revoke_certificate(p_code, p_reason)` | `{code, revoked:true}` | coordinator of issuing org | CERTIFICATE_NOT_FOUND, NOT_AUTHORISED, BAD_REASON |
| `set_my_name(p_name)` | `{name, certificates_updated}` | auth | NAME_TOO_SHORT/LONG, NAME_LOOKS_LIKE_EMAIL |

Codes are `SOI-XXXX-XXXX` (upper hex). Verification URL:
`https://soi.yashgb.com/verify.html?code=SOI-XXXX-XXXX`.

## Pledges and Passport (006)

| Function | Returns | Who | Keys |
|---|---|---|---|
| `create_pledge(p_org, p_title, p_body, p_campaign)` | `{id, share_code}` | coordinator | TITLE_TOO_SHORT/LONG, BODY_TOO_SHORT/LONG, CAMPAIGN_TOO_LONG |
| `update_pledge(p_id, p_title, p_body, p_campaign)` | `{id, signatures}`; body locked once signed | coordinator | PLEDGE_NOT_FOUND, PLEDGE_ALREADY_SIGNED + bounds |
| `set_pledge_status(p_id, 'active'\|'closed')` | `{id, status}` | coordinator | BAD_STATUS, PLEDGE_NOT_FOUND |
| `delete_pledge(p_id)` | void | coordinator | PLEDGE_NOT_FOUND, PLEDGE_HAS_SIGNATURES |
| `sign_pledge(p_share_code)` | `{pledge_id, pledge_title, signature_no, signed_at, certificate_code, already}` | auth | PLEDGE_NOT_FOUND, PLEDGE_CLOSED |
| `pledge_detail(p_share_code)` | `{id, org_id, org_name, org_verified, title, campaign, body, status, share_code, created_at, signatures, can_manage, my_signature{signature_no, signed_at, certificate_code}\|null}` | public | PLEDGE_NOT_FOUND |
| `pledge_signers(p_id)` | `[{name, signature_no, signed_at}]` | coordinator | |
| `org_pledges(p_org)` | `[{id, title, campaign, body, share_code, status, created_at, signatures}]` | coordinator | |
| `my_passport()` | `{certified_hours, pending_hours, certified_drives, attendance:[…incl. rejected and cancelled drives…], pledges:[…]}` | auth | |

Pledge title 5–120, body 20–2000, campaign ≤60. Share codes are 6 upper hex.

## Reports and statistics (007)

| Function | Returns | Who | Keys |
|---|---|---|---|
| `report_content(p_target_type 'drive'\|'organisation'\|'pledge', p_target_id, p_reason)` | `{id}`; 20/day per user | auth | BAD_TARGET, BAD_REASON, TOO_MANY_REPORTS |
| `soi_stats()` | `{organisations, drives, certified_hours, volunteers, pledges}` | public | |

## QR payloads

```
soi:checkin:<driveId uuid>:<code uuid>    exactly 4 colon-separated parts
soi:pledge:<shareCode 6 hex>              exactly 3 parts
```
Parsed by `lib/core/utils/qr_payload.dart`; generated by the same file.

## Deep links

`soi://open/drive/<id>`, `soi://open/pledge/<code>`, `soi://open/certificate/<code>`.
The `open` host makes the URI path equal the in-app route.

## Realtime

`public.attendance` is in the `supabase_realtime` publication with
`replica identity full`. Subscribers receive only rows their RLS lets them
read: own rows, or rows of drives they coordinate. Payloads carry attendance
columns only (no names).

## Tables directly readable by clients (select only)

`organisations` (all), `drives` (published, or own org's), `registrations`
(own), `attendance` (own, or coordinator of the drive), `profiles` (own),
`certificates` (own), `pledges` (active, or own org's), `pledge_signatures`
(own), `org_members` (own rows, or admin of the org). The app reads none of
these directly today; everything goes through the functions above.
Unreadable by any client role: `drive_checkin_codes`, `students`,
`org_invites`, `audit_log`, `content_reports`.
