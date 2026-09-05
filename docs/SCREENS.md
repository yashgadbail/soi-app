# Screens

One section per screen: purpose, entry points, states, actions, server
calls, edge cases. Routes are typed in `lib/router/routes.dart`.

## Welcome `/welcome`
Public landing shown once per device (then Discover is the start). Hero with
tagline, live counts (`soi_stats`), Browse / Sign in, three steps, three
upcoming drives (`discover_drives` first page), pledge-code box (opens
`/pledge/<code>`). Counts show an em dash while loading; a failed load hides
the drives section rather than blaming the user.

## Sign in `/sign-in?from=`
Email → one-time code (`signInWithOtp` → `verifyOTP`), with a 30 s resend
timer and a "different email" escape. Password path kept for the store
review account. The screen never navigates itself: the router's redirect
takes over on session change and honours `from`. Errors are inline
(`Notice`), never below the fold.

## Onboarding name `/onboarding/name`, intent `/onboarding/intent`
Forced after first sign-in: the name printed on certificates (`set_my_name`),
then "I volunteer" / "I run an organisation" (creates or lands on
Discover/`from`). Both paths stay open forever from Profile.

## Discover `/discover` (tab)
Search (title, venue, city, organisation; debounced 350 ms), cause and city
menus from `discover_facets`, sort Soonest/Most hours, 20-per-page paging on
scroll, pull to refresh, cached first page painted instantly. Card: relative
day, hours, title, organisation (+verified), cause, time, venue, spots left,
Registered tag. States: skeleton, error with retry, empty (with/without
filters), end-of-list.

## Drive `/drive/:id` (public, root)
`drive_detail`. Banners for cancelled / ended / full and for the caller's own
check-in status. Organiser row → organisation page. Facts: when, where
(→ maps app), hours credited, spots. Description. "Nothing is certified
automatically" notice. Register / Registered→cancel (confirm) via
`register_for_drive` / `cancel_registration`; Discover's row is patched
optimistically. Share (deep link), Report (sheet, `report_content`).
Coordinators see Edit and Coordinator Mode.

## Organisation `/org/:id` (public, root)
`organisation_public`: identity, tags, about, drives run, hours certified,
upcoming drives.

## Check in `/check-in` (tab)
Signed-out: explanation + sign in. Signed-in: full-screen scanner (QR only,
no-duplicates), corner reticle, torch, "Enter code instead" sheet (paste), a
latch so one code fires one `check_in`. Success/already/failure sheets with
haptics; "View my Passport" switches tab. Permission denied: rationale +
Allow + Open settings. Pledge QRs open the pledge page.

## Passport `/passport` (tab)
`my_passport` (+ `my_upcoming_drives`). Hero: count-up certified hours,
pending, drives, pledges. Upcoming drives (3). Segments All / Certified /
Pending / Not counted / Pledges. Pending rows name the organisation that
must sign; certified rows open the certificate; rejected rows are struck
through. Pledges listed separately with a note. Snapshot painted first;
errors are shown compactly above cached data. Link to claim a school code.

## Certificate `/certificate/:code` (public, root)
`verify_certificate`. Renders `CertificateCard` (fixed identity). Actions:
share as image (RepaintBoundary at 1080 px, temp file, share sheet), share
verification link, copy number. Network error → retry; server not-found →
"Certificate not found" with the expected format. Never confused.

## Pledge `/pledge/:code` (public, root)
`pledge_detail`. Campaign tag, title, organisation, quoted body, signature
count, "What this is — and isn't". Take this pledge (`sign_pledge`, sign-in
gated with `from`), signed state with certificate button, QR sheet, share.
Coordinators see Edit.

## Profile `/profile` (tab)
Name card → `/profile/name`; organisations with role tags (→ settings or
public page); Register an organisation; Link school records (`/claim`);
appearance note; privacy, child safety, support; version; sign out
(confirm); delete account (confirm, destructive) → `delete_my_account`.

## Claim `/claim` (root, gated)
8-hex code → `claim_student_record` → Passport refreshed, tab switched.

## Manage `/manage` (tab, coordinators)
Organisation card (switcher if several), quick actions (Roster, Pledges,
Organisation), Publish FAB, drives grouped Today / Upcoming / Past
(collapsed) from `org_drives` with registration/check-in/certified counts
and a pending badge; each row opens the drive, the QR icon opens Coordinator
Mode. Non-coordinators see how to register or get invited.

## Drive form `/manage/drive/new?org=`, `/manage/drive/:id/edit`
Organisation chips (if several), title, cause chips, description, date +
start/end time pickers (end before start rolls to next day), venue, city,
spots, hours with the "nothing is certified automatically" help. Validation
on interaction mirrors the server. Unsaved-changes guard. Edit adds Cancel
this drive (confirm). `create_drive` / `update_drive` / `cancel_drive`.

## Coordinator Mode `/manage/drive/:id/mode`
Keeps the screen awake and at full brightness. Big QR of
`soi:checkin:<id>:<code>` (`get_checkin_code`), Rotate (`rotate_checkin_code`),
copy code. Live roster (`roster` + realtime): search when > 6 rows, per-row
Certify / Don't count (confirm), Certify all FAB, stats line. Roster errors
carry the "do not tell anyone they were absent" warning. Schools get a Mark
students action.

## Roster `/manage/org/:id/roster`
`org_roster` grouped by class with search. Add person sheet (student /
volunteer, name, class, roll, email, mobile; privacy note), paste-a-list
sheet, person sheet (hours, claim code copy/share, edit, remove only while
recordless and unlinked). `enrol_participant`, `update_student`,
`remove_student`.

## Mark attendance `/manage/drive/:id/mark`
All students of the schools the caller coordinates, already-marked ones
ticked and disabled (`drive_marked_students`), search, select all, confirm →
`mark_students_present`.

## Pledges `/manage/org/:id/pledges`, form `/manage/org/:id/pledge/new`, `/manage/pledge/:code/edit`
List with Active/Closed filter; per pledge: QR sheet, signers sheet
(`pledge_signers`), edit, close/reopen (`set_pledge_status`), delete (blocked
with the constructive "close instead" dialog once signed;
`delete_pledge`). Form: title, campaign, body (locked once signed, explained
inline), counters, unsaved guard. `create_pledge` / `update_pledge`.

## Organisation form `/manage/org/new`, `/manage/org/:id/edit`; settings `/manage/org/:id`
Type segment, name, city, about, verification note → `create_organisation`
(caller becomes owner, Manage tab appears) / `update_organisation`. Settings:
identity, public page link, team list with roles and remove (admins),
invite by email with role help (`invite_org_member`), pending invites with
cancel, leave organisation (confirm; the sole owner is refused).
