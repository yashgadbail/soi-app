# Data safety mapping

Which screens send which declared data, so the Play form stays true.

| Declared data | Where it is collected | Where it goes | Stored |
|---|---|---|---|
| Email | Sign-in | Supabase Auth (OTP delivery, account id); `profiles.email` | Yes, until account deletion |
| Name | Onboarding, Profile → Edit name; school roster (entered by a teacher) | `profiles.full_name`; `students.full_name`; snapshotted on certificates | Yes; certificates keep the snapshot after deletion |
| Phone | School roster only (optional, entered by a teacher) | `students.phone` | Yes, unreadable by any client role except via coordinator functions |
| City, class, roll number | School roster (teacher); organisation city | `students.*`, `organisations.city` | Yes |
| App activity | Registering, checking in, signing pledges | `registrations`, `attendance`, `pledge_signatures`, `audit_log` | Yes |

Not collected anywhere: precise or coarse location (directions open the maps
app with a text query), photos or videos (the camera decodes QR frames on
device and stores nothing; the certificate image is generated, not captured),
audio, files, contacts, device identifiers, advertising id.

Encryption in transit: HTTPS/WSS to Supabase. Deletion: Profile → Delete my
account, or the web page. Children: no accounts under 13; students are held
by their school as name + class + roll only.
