import 'package:flutter/material.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/ui/widgets.dart';

/// The three-step explanation of the product. Shared by Welcome and the
/// Discover empty state so the story is told the same way everywhere.
class HowItWorks extends StatelessWidget {
  const HowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final steps = [
      (Icons.event_available_outlined, l.welcomeStep1Title, l.welcomeStep1Body),
      (Icons.qr_code_scanner, l.welcomeStep2Title, l.welcomeStep2Body),
      (Icons.verified_outlined, l.welcomeStep3Title, l.welcomeStep3Body),
    ];
    return SoiCard(
      child: Column(
        children: [
          for (final (i, s) in steps.indexed) ...[
            if (i > 0) const Divider(height: Space.xxl),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: c.greenSoft, borderRadius: BorderRadius.circular(Radii.md)),
                  child: Icon(s.$1, color: c.greenDark, size: 22),
                ),
                const SizedBox(width: Space.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.$2, style: context.text.titleSmall),
                      const SizedBox(height: 4),
                      Text(s.$3, style: context.text.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
