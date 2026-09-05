# Supabase project setup

Everything the app needs from the project that is **not** in `db/migrations`
(dashboard-only settings). Do these once per project (dev and, at cutover,
production).

## 1. Email one-time codes instead of links

The app signs in with a numeric code (`signInWithOtp` → `verifyOTP`). By
default Supabase's templates send a **link** (`{{ .ConfirmationURL }}`), which
is what you received ("Confirm your email address"). Nothing changes in the
app; the templates must include `{{ .Token }}`.

Dashboard → **Authentication → Email Templates**. Change **both** of these,
because a new address gets "Confirm signup" and an existing one gets
"Magic Link":

**Confirm signup** — subject `Your SWAG of India code`

```html
<h2>Your sign-in code</h2>
<p>Enter this code in the SWAG of India app. It expires in 10 minutes.</p>
<p style="font-size:32px;letter-spacing:8px;font-weight:700">{{ .Token }}</p>
<p>If you didn't request this, you can ignore this email.</p>
```

**Magic Link** — subject `Your SWAG of India code`

```html
<h2>Your sign-in code</h2>
<p>Enter this code in the SWAG of India app. It expires in 10 minutes.</p>
<p style="font-size:32px;letter-spacing:8px;font-weight:700">{{ .Token }}</p>
<p>If you didn't request this, you can ignore this email.</p>
```

Then **Authentication → Providers → Email**: keep *Enable email provider* on,
*Confirm email* on, *Secure email change* on. Set **OTP expiry** to 600 s and
**OTP length** to 6 (the app accepts 6–10 digits). Under **Rate limits**, the
built-in SMTP allows only a few emails per hour; for the pilot connect the
Brevo SMTP already used by production (Authentication → SMTP Settings).

## 1b. SMTP (required before real users)

The built-in sender (`noreply@mail.app.supabase.io`) is for development only:
a few emails per hour, generic branding, and the rate limit cannot be raised
while it is in use. Supabase itself sends no mail in production; you bring a
provider.

Chosen provider: **Hostinger email** (mailboxes on the hosting plan).

First, hPanel → **Emails** → create a mailbox for the sender, e.g.
`noreply@swagofindia.org` (or on whichever domain has email hosted there).
Hostinger rejects mail whose From address is not the authenticated mailbox,
so the sender email below must be that exact mailbox. Keep its password in a
password manager; it goes only into the Supabase dashboard.

Dashboard → **Authentication → SMTP Settings** → *Enable custom SMTP*:

| Field | Value |
|---|---|
| Sender email | the mailbox, e.g. `noreply@swagofindia.org` |
| Sender name | SWAG of India |
| Host | `smtp.hostinger.com` |
| Port | `465` (implicit SSL). If the dashboard reports a TLS handshake error, use `587` |
| Username | the full mailbox address |
| Password | the mailbox password |

Save, then **Authentication → Rate Limits** → set *emails sent per hour* to
about 30 for the pilot (Hostinger mailboxes have a daily sending cap of a few
hundred; stay well under it). Hostinger sets SPF and DKIM for its own
mailboxes automatically when the domain's DNS is managed there; check hPanel
→ Emails → DNS records if a code lands in spam.

Alternatives if volume grows: Brevo (the v1 production project used it;
`smtp-relay.brevo.com`, 587, 300/day free), Resend, Amazon SES. If the stack
is ever self-hosted, the same values go into GoTrue's `SMTP_*` environment
variables.

## 2. Redirect and site URL

Authentication → URL Configuration: Site URL `https://soi.yashgb.com`. No
redirect URLs are needed; the app uses codes, not links, and PKCE.

## 3. Realtime

Database → Publications → `supabase_realtime`: migration 004 adds
`public.attendance`. Verify it is listed (Realtime → Inspect).

## 4. Reviewer account (store review)

Authentication → Users → **Add user**: email `play-review@swagofindia.org`,
a strong password, **Auto Confirm = yes**. Then in SQL Editor:

```sql
select public.attach_review_account();
```
This names the profile, makes it owner of the demo organisation and creates
a demo drive if none is upcoming. The app's "Sign in with a password
instead" path is for this account.

## 5. Test users (dev only)

Add two or three users the same way (Auto Confirm) so device round trips do
not depend on email delivery. Sign in with the password path.

## 6. Keys for the app

Project Settings → API: copy the **publishable** key and the project URL into
`.env` (`SUPABASE_PUBLISHABLE_KEY`, `SUPABASE_URL`). Never the secret key.
