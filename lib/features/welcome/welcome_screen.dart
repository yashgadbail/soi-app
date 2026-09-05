import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soi/core/theme/theme.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/effects.dart';
import 'package:soi/ui/how_it_works.dart';
import 'package:soi/ui/motion.dart';
import 'package:soi/ui/widgets.dart';

part 'welcome_screen.g.dart';

@riverpod
Future<Stats> welcomeStats(Ref ref) => ref.watch(accountRepoProvider).stats();

@riverpod
Future<List<DriveSummary>> welcomeDrives(Ref ref) async {
  final rows = await ref.watch(drivesRepoProvider).discover();
  return rows.take(3).toList();
}

/// Public landing. Shown once per device before the tabs; always reachable
/// from sign-in. No account needed to browse.
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _code = TextEditingController();

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _browse() async {
    await ref.read(sessionControllerProvider.notifier).markWelcomeSeen();
    if (mounted) const DiscoverRoute().go(context);
  }

  Future<void> _signIn() async {
    await ref.read(sessionControllerProvider.notifier).markWelcomeSeen();
    if (mounted) unawaited(const SignInRoute().push<void>(context));
  }

  void _openPledge() {
    final code = _code.text.trim().toUpperCase();
    if (Validators.shareCode(code) != null) {
      showSnack(context, fieldError(context, 'BAD_CODE')!);
      return;
    }
    PledgeRoute(code: code).push<void>(context);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final stats = ref.watch(welcomeStatsProvider);
    final drives = ref.watch(welcomeDrivesProvider);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SoiTheme.systemBarsOnDark,
        child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _Hero(stats: stats.value, onBrowse: _browse, onSignIn: _signIn)),
          SliverPadding(
            padding: pageInsets(context).copyWith(top: Space.section),
            sliver: SliverList.list(
              children: [
                const FadeInUp(child: HowItWorks()),
                const SizedBox(height: Space.section),
                FadeInUp(
                  index: 1,
                  child: SectionLabel(
                    l.welcomeHappeningSoon,
                    trailing: TextButton(onPressed: _browse, child: Text(l.commonSeeAll)),
                  ),
                ),
                ...drives.when(
                  loading: () => [
                    const Shimmer(child: Column(children: [SkeletonCard(lines: 2), SkeletonCard(lines: 2)])),
                  ],
                  error: (_, _) => const [SizedBox.shrink()],
                  data: (rows) => [
                    for (final (i, d) in rows.indexed)
                      FadeInUp(
                        index: i + 2,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: Space.md),
                          child: PressScale(
                            child: SoiCard(
                              onTap: () => DriveRoute(id: d.id).push<void>(context),
                              padding: const EdgeInsets.all(Space.lg),
                              child: Row(
                                children: [
                                  _DateBadge(d.startsAt),
                                  const SizedBox(width: Space.lg),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(d.title, style: context.text.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                                        const SizedBox(height: 2),
                                        Text(
                                          [d.orgName, if (d.city != null) d.city!].join(' · '),
                                          style: context.text.bodySmall,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: Space.sm),
                                  Text(l.commonHoursShort(Fmt.hours(d.defaultHours)),
                                      style: context.text.labelLarge!.copyWith(color: c.green)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (rows.isEmpty) Text(l.discoverEmptyTitle, style: context.text.bodyMedium),
                  ],
                ),
                const SizedBox(height: Space.section),
                FadeInUp(
                  index: 5,
                  child: SoiCard(
                    color: c.saffronSoft,
                    borderColor: c.saffronSoft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l.welcomeHavePledgeCode, style: context.text.titleMedium!.copyWith(color: c.saffronInk)),
                        const SizedBox(height: Space.md),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _code,
                                textCapitalization: TextCapitalization.characters,
                                maxLength: 6,
                                textInputAction: TextInputAction.go,
                                onSubmitted: (_) => _openPledge(),
                                decoration: InputDecoration(hintText: l.welcomePledgeCodeHint, counterText: ''),
                              ),
                            ),
                            const SizedBox(width: Space.sm),
                            SizedBox(
                              height: 52,
                              child: FilledButton(
                                style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
                                onPressed: _openPledge,
                                child: Text(l.commonOpen),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge(this.when);
  final DateTime when;

  @override
  Widget build(BuildContext context) {
    final c = context.soi;
    final parts = Fmt.day(when).split(', ').last.split(' ');
    return Container(
      width: 56,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: c.greenSoft, borderRadius: BorderRadius.circular(Radii.md)),
      child: Column(
        children: [
          Text(parts.first, style: context.text.titleLarge!.copyWith(color: c.greenDark)),
          Text(parts.last.toUpperCase(), style: context.text.labelSmall!.copyWith(color: c.greenDark)),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.stats, required this.onBrowse, required this.onSignIn});
  final Stats? stats;
  final VoidCallback onBrowse;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final top = MediaQuery.paddingOf(context).top;
    return Container(
      padding: EdgeInsets.fromLTRB(Space.page, top + Space.xxl, Space.page, Space.xxxl),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A5C43), SoiColors.deep],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(Radii.xl + 8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                l.brandShort,
                style: context.text.titleLarge!.copyWith(color: SoiColors.certSaffron, letterSpacing: 3, fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: Space.sm),
              Text(l.appName, style: context.text.labelMedium!.copyWith(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: Space.section),
          Text(l.welcomeTagline, style: context.text.displaySmall!.copyWith(color: Colors.white)),
          const SizedBox(height: Space.md),
          Text(l.welcomeLead, style: context.text.bodyLarge!.copyWith(color: Colors.white.withValues(alpha: 0.8))),
          const SizedBox(height: Space.section),
          GradientGlassTile(
            child: Row(
              children: [
                Expanded(child: StatTile(value: _n(stats?.organisations), label: l.welcomeStatOrganisations, onDark: true)),
                Expanded(child: StatTile(value: _n(stats?.drives), label: l.welcomeStatDrives, onDark: true)),
                Expanded(child: StatTile(value: _n(stats?.certifiedHours), label: l.welcomeStatHours, onDark: true)),
              ],
            ),
          ),
          const SizedBox(height: Space.section),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: SoiColors.certSaffron, foregroundColor: const Color(0xFF3A2000)),
            onPressed: onBrowse,
            child: Text(l.welcomeCtaBrowse),
          ),
          const SizedBox(height: Space.md),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.4), width: 1.5),
            ),
            onPressed: onSignIn,
            child: Text(l.welcomeCtaSignIn),
          ),
          const SizedBox(height: Space.lg),
          Text(l.welcomeFree, style: context.text.bodySmall!.copyWith(color: Colors.white60)),
        ],
      ),
    );
  }

  String _n(num? v) => v == null ? '—' : Fmt.hours(v);
}
