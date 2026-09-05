# Design system

## Principles

1. **Every screen answers "what do I do now?"** before anything else. The
   primary action sits at the bottom, full width, one per screen.
2. **Ledger, not feed.** Pending and certified are visually different
   everywhere (saffron hourglass vs green tick). Pledges are never mixed with
   hours.
3. **Nothing looks generated.** One type family, one radius scale, tokens for
   every colour, no emoji, no placeholder copy. Restraint in motion.
4. **Cheap phones, bright sun, students.** 48 dp targets, AA contrast, large
   tap areas, text scaling honoured to 1.3×.

## Tokens (`lib/core/theme/tokens.dart`)

| Token | Light | Dark | Use |
|---|---|---|---|
| green | `#0E7C5A` | `#3DBF92` | primary actions, tab selection, positive tags |
| greenDark | `#0A5C43` | `#2AA079` | pressed, on-container text |
| greenSoft / greenTint | `#E4F5EE` / `#C9EADD` | `#12362A` / `#1B4A39` | containers, chips |
| saffron | `#FF9933` | `#FFA64D` | pending, pledges, the welcome CTA |
| saffronSoft / saffronInk | `#FFF2E3` / `#8A4B0F` | `#3A2A14` / `#FFC38A` | containers and their text |
| gold | `#C9A227` | `#D9B44A` | certificate rules and numbers |
| ink / body / muted | `#101820` / `#495563` / `#8794A3` | `#F2F5F3` / `#B8C4BE` / `#7F8C86` | text hierarchy |
| line | `#DDE5EC` | `#253129` | card borders, dividers |
| bg / bgAlt | `#FFFFFF` / `#EEF3F6` | `#16211C` / `#0F1714` | card / page |
| danger / dangerSoft | `#C0392B` / `#FDEDEC` | `#E5675A` / `#3B1D1A` | destructive, rejected |

Fixed (both themes): `deep #083D2D`, `certGold #C9A227`, `certSaffron #FF9933`
for the certificate and hero panels.

Spacing: 4 / 8 / 12 / 16 / 20 / 24 / 32; page gutter 18; tap floor 48.
Radii: 10 / 14 (inputs) / 18 (buttons, notices) / 24 (cards) / pill.
Motion: 160 ms fast, 240 ms base, 380 ms entrance with `Cubic(0.22, 1, 0.36, 1)`;
count-up 900 ms. Entrance only on first paint of the first six items; nothing
replays on scroll; all animation respects the OS reduce-motion setting.

## Typography

Inter, static instances 400/500/600/700/800 bundled (OFL).

| Style | Size / weight | Use |
|---|---|---|
| displayLarge | 40 / 800 | Passport hours (56 on the hero) |
| displaySmall | 28 / 800 | Welcome tagline |
| headlineMedium | 24 / 800 | Screen leads, drive titles on detail |
| headlineSmall | 20 / 700 | Section heroes, org names |
| titleLarge / Medium / Small | 18 / 16 / 14 | card titles, tiles, rows |
| bodyLarge / Medium / Small | 16 / 15 / 13 | copy; small is muted |
| labelLarge / Medium / Small | 14 / 12 / 11 caps 0.8 | buttons, tags, section labels |

## Components (`lib/ui/`)

- `SoiCard`: surface + hairline border + 24 radius; optional tap with ripple;
  wrapped in a `RepaintBoundary`.
- `SoiTag`: status pill (neutral / green / saffron / danger).
- `SoiFilterChip`: Material chip in a 48 dp hit area.
- `Notice`: inline fact or warning; replaces dialogs for non-blocking info.
- `FactRow`: icon + label + value, optional chevron.
- `StatTile`: big tabular number + caption (light or on-dark).
- `InitialsAvatar`: the app stores no photos; everyone gets initials.
- `SectionLabel`: micro caps with optional trailing action.
- `LoadingView`, `ErrorView` (offline / not-found / rule / unknown, with
  retry, full or compact), `EmptyView`, `SignedOutView`.
- `QrView`: white tile, dark modules, fixed regardless of theme.
- `FadeInUp`, `CountUp`, `PressScale` in `motion.dart`.
- `showSnack` (+ optional action), `confirmDialog` (destructive style),
  `showSoiSheet`, `copyToClipboard`.

## Feedback rules

- Success → snackbar. Reversible success → snackbar with Undo.
- Irreversible action → `confirmDialog` first (certify, reject, cancel drive,
  delete pledge, leave org, remove member, sign out, delete account).
- Field errors inline, on interaction (`AutovalidateMode.onUserInteraction`),
  worded from the same key map as server errors.
- Network failure → `ErrorView` with retry, never a blank list.

## Vocabulary

Drive (never event/opportunity). Pledge (a campaign is only a pledge's label).
Organisation. Coordinator Mode. Impact Passport. British spelling. Brand
"SWAG of India", short form "SOI".

## The certificate

Deep green ground `#083D2D`, outer radius 20 with 10 padding, inner 1.5 px gold
frame radius 14. Top to bottom: saffron `SOI` 21/800 tracking 3 → organisation
name white 72% → gold rule 45% → kicker `CERTIFICATE OF VOLUNTEERING` gold
10/700 tracking 1.2 → "This is to certify that" white 55% → name 26/800 white
→ "has completed and had certified" → hours 44/800 saffron + "hours" 16/700 →
"of volunteering at" → title 17/700 white → gold rule → footer: ISSUED
long date (en-IN), CERTIFICATE NO. in gold 14 tracking 1; bottom-right white QR
tile 92 px encoding the verify URL with "Scan to verify" beneath → optional
red WITHDRAWN bar. Pledge variant swaps the middle for "has taken the pledge"
+ title and has no numeral. Pinned by `test/golden`.
