import 'package:flutter/material.dart';
import 'package:soi/core/links.dart';
import 'package:soi/core/theme/theme.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/data/models.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/ui/qr_view.dart';

/// The certificate itself. Its identity is fixed and theme-independent:
/// deep green ground, gold double frame, saffron wordmark and hours, white
/// name, bottom-right white QR tile. Rendered from the public verifier's
/// facts so the holder and a verifier see the same bytes.
///
/// Wrapped in its own [Theme] and a no-scaling [MediaQuery] so dark mode
/// and large text never change the shared image.
class CertificateCard extends StatelessWidget {
  const CertificateCard({required this.certificate, super.key, this.width});
  final Certificate certificate;
  final double? width;

  static const Color ground = SoiColors.deep;
  static const Color gold = SoiColors.certGold;
  static const Color saffron = SoiColors.certSaffron;
  static const Color white = Colors.white;
  static final Color white72 = white.withValues(alpha: 0.72);
  static final Color white55 = white.withValues(alpha: 0.55);
  static final Color white45 = white.withValues(alpha: 0.45);
  static final Color rule = gold.withValues(alpha: 0.45);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = certificate;
    final mq = MediaQuery.of(context);
    final w = width ?? mq.size.width - Space.page * 2;
    final code = c.code ?? '';

    return MediaQuery(
      data: mq.copyWith(textScaler: TextScaler.noScaling, boldText: false),
      child: Theme(
        data: SoiTheme.light(),
        child: Builder(
          builder: (context) {
            final t = Theme.of(context).textTheme;
            final micro = t.labelSmall!.copyWith(color: gold, fontSize: 10, letterSpacing: 1.2);
            final connective = t.bodySmall!.copyWith(color: white55, fontSize: 12, fontWeight: FontWeight.w500);
            return Semantics(
              label: c.isPledge
                  ? '${l.certificateKickerPledge}. ${c.subjectName} ${l.certificateTakenPledge} ${c.title}. ${c.orgName}. $code'
                  : '${l.certificateKicker}. ${c.subjectName}, ${l.commonHours(c.hours ?? 0)}, ${c.title}, ${c.orgName}. $code',
              child: ExcludeSemantics(
                child: Container(
                  width: w,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: ground, borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 22),
                    decoration: BoxDecoration(
                      border: Border.all(color: gold, width: 1.5),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(l.brandShort,
                            textAlign: TextAlign.center,
                            style: t.titleLarge!.copyWith(color: saffron, fontSize: 21, fontWeight: FontWeight.w800, letterSpacing: 3)),
                        const SizedBox(height: 5),
                        Text(c.orgName ?? '',
                            textAlign: TextAlign.center,
                            style: t.bodySmall!.copyWith(color: white72, fontWeight: FontWeight.w600)),
                        _Rule(color: rule),
                        Text(
                          (c.isPledge ? l.certificateKickerPledge : l.certificateKicker).toUpperCase(),
                          textAlign: TextAlign.center,
                          style: micro,
                        ),
                        const SizedBox(height: 20),
                        Text(l.certificateCertify, textAlign: TextAlign.center, style: connective),
                        const SizedBox(height: 6),
                        Text(
                          c.subjectName ?? '',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: t.headlineMedium!.copyWith(color: white, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.3, height: 1.2),
                        ),
                        const SizedBox(height: 16),
                        if (c.isPledge) ...[
                          Text(l.certificateTakenPledge, textAlign: TextAlign.center, style: connective),
                          const SizedBox(height: 8),
                          Text(c.title ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: t.titleMedium!.copyWith(color: white, fontSize: 17, height: 1.4)),
                        ] else ...[
                          Text(l.certificateCompleted, textAlign: TextAlign.center, style: connective),
                          const SizedBox(height: 4),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: Fmt.hours(c.hours ?? 0),
                                  style: t.displayLarge!.copyWith(color: saffron, fontSize: 44, fontWeight: FontWeight.w800, height: 1.1),
                                ),
                                TextSpan(
                                  text: '  ${l.certificateHoursUnit}',
                                  style: t.titleMedium!.copyWith(color: white.withValues(alpha: 0.75), fontSize: 16, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(l.certificateOfVolunteering, textAlign: TextAlign.center, style: connective),
                          const SizedBox(height: 8),
                          Text(c.title ?? '',
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: t.titleMedium!.copyWith(color: white, fontSize: 17, height: 1.4)),
                        ],
                        _Rule(color: rule),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(l.certificateIssued.toUpperCase(), style: micro.copyWith(color: white45, fontSize: 8)),
                                  const SizedBox(height: 2),
                                  Text(c.issuedAt == null ? '' : Fmt.longDate(c.issuedAt!),
                                      style: t.bodySmall!.copyWith(color: white, fontWeight: FontWeight.w600, fontSize: 13)),
                                  const SizedBox(height: 12),
                                  Text(l.certificateNumber.toUpperCase(), style: micro.copyWith(color: white45, fontSize: 8)),
                                  const SizedBox(height: 2),
                                  Text(code, style: t.labelLarge!.copyWith(color: gold, fontSize: 14, letterSpacing: 1)),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                QrView(Links.verifyUrl(code), size: 92, padding: 7),
                                const SizedBox(height: 4),
                                Text(l.certificateScanToVerify,
                                    style: t.labelSmall!.copyWith(color: white72, fontSize: 8, letterSpacing: 0.4)),
                              ],
                            ),
                          ],
                        ),
                        if (!c.valid && c.found) ...[
                          const SizedBox(height: 18),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(color: const Color(0xFFC0392B), borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              l.certificateWithdrawn(c.revokedReason ?? '').toUpperCase(),
                              textAlign: TextAlign.center,
                              style: t.labelSmall!.copyWith(color: white, fontSize: 11, letterSpacing: 0.8),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) => Container(height: 1, color: color, margin: const EdgeInsets.symmetric(vertical: 20));
}
