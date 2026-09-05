import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/data/session.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/widgets.dart';

/// First-run step 2: what the person is here to do. Both paths stay open
/// forever; this only chooses where they land first.
class OnboardingIntentScreen extends ConsumerWidget {
  const OnboardingIntentScreen({super.key, this.from});
  final String? from;

  Future<void> _choose(BuildContext context, WidgetRef ref, {required bool organisation}) async {
    await ref.read(sessionControllerProvider.notifier).markIntentSeen();
    if (!context.mounted) return;
    if (organisation) {
      const OrgNewRoute().go(context);
    } else if (from != null) {
      context.go(from!);
    } else {
      const DiscoverRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final hasOrg = ref.watch(sessionControllerProvider.select((s) => s.memberships.isNotEmpty));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: pageInsets(context).copyWith(top: Space.xxxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l.onboardIntentTitle, style: context.text.headlineMedium),
              const SizedBox(height: Space.sm),
              Text(l.onboardIntentLead, style: context.text.bodyLarge),
              const SizedBox(height: Space.xxl),
              _Choice(
                icon: Icons.volunteer_activism_outlined,
                title: l.onboardIntentVolunteerTitle,
                body: l.onboardIntentVolunteerBody,
                onTap: () => _choose(context, ref, organisation: false),
              ),
              const SizedBox(height: Space.md),
              _Choice(
                icon: Icons.corporate_fare_outlined,
                title: l.onboardIntentOrgTitle,
                body: l.onboardIntentOrgBody,
                tone: TagTone.saffron,
                onTap: () => _choose(context, ref, organisation: true),
              ),
              const SizedBox(height: Space.xl),
              if (!hasOrg)
                Text(l.onboardIntentInviteHint, style: context.text.bodySmall!.copyWith(color: c.muted)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.icon,
    required this.title,
    required this.body,
    required this.onTap,
    this.tone = TagTone.green,
  });
  final IconData icon;
  final String title;
  final String body;
  final VoidCallback onTap;
  final TagTone tone;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    final (bg, fg) = tone == TagTone.saffron ? (c.saffronSoft, c.saffronInk) : (c.greenSoft, c.greenDark);
    return SoiCard(
      onTap: onTap,
      semanticsLabel: '$title. $body',
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(Radii.md)),
            child: Icon(icon, color: fg),
          ),
          const SizedBox(width: Space.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.text.titleMedium),
                const SizedBox(height: 2),
                Text(body, style: context.text.bodySmall),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: c.muted),
        ],
      ),
    );
  }
}
