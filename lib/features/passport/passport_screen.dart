import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/data/snapshots.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/effects.dart';
import 'package:soi/ui/motion.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

part 'passport_screen.g.dart';

@riverpod
Future<Passport> passport(Ref ref) async {
  final uid = ref.watch(sessionControllerProvider.select((s) => s.userId));
  if (uid == null) return const Passport();
  final p = await ref.watch(accountRepoProvider).passport();
  await ref.read(snapshotsProvider).savePassport(uid, p);
  return p;
}

@riverpod
Future<List<UpcomingDrive>> myUpcoming(Ref ref) {
  final uid = ref.watch(sessionControllerProvider.select((s) => s.userId));
  if (uid == null) return Future.value(const []);
  return ref.watch(drivesRepoProvider).myUpcoming();
}

enum _Filter { all, certified, pending, rejected, pledges }

/// Milestones are the only "engagement" mechanic, and they are honest: they
/// count certified hours only, and the next target is always visible.
const _milestones = [1, 5, 10, 25, 50, 100, 250];

/// The Impact Passport: certified hours, what's pending and with whom,
/// certificates, and pledges (listed separately, on purpose).
class PassportScreen extends ConsumerStatefulWidget {
  const PassportScreen({super.key});

  @override
  ConsumerState<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends ConsumerState<PassportScreen> {
  _Filter _filter = _Filter.all;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final session = ref.watch(sessionControllerProvider);

    if (!session.isSignedIn) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(title: Text(l.passportTitle)),
        body: SignedOutView(
          icon: Icons.workspace_premium_outlined,
          body: l.passportEmptyBody,
          onSignIn: () => const SignInRoute(from: '/passport').push<void>(context),
        ),
      );
    }

    final async = ref.watch(passportProvider);
    final cached = ref.read(snapshotsProvider).passport(session.userId!);
    final upcoming = ref.watch(myUpcomingProvider).value ?? const <UpcomingDrive>[];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: Text(l.passportTitle)),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(passportProvider);
          ref.invalidate(myUpcomingProvider);
          await ref.read(passportProvider.future);
        },
        child: async.when(
          loading: () => cached == null ? const _PassportSkeleton() : _content(cached, upcoming),
          error: (e, _) => cached == null
              ? ErrorView(error: e, onRetry: () => ref.invalidate(passportProvider))
              : _content(cached, upcoming, error: e),
          data: (p) => _content(p, upcoming),
        ),
      ),
    );
  }

  Widget _content(Passport p, List<UpcomingDrive> upcoming, {Object? error}) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final rows = switch (_filter) {
      _Filter.all => p.attendance,
      _Filter.certified => p.attendance.where((r) => r.isCertified).toList(),
      _Filter.pending => p.attendance.where((r) => r.isPending).toList(),
      _Filter.rejected => p.attendance.where((r) => r.isRejected).toList(),
      _Filter.pledges => const <PassportRow>[],
    };
    final showPledges = _filter == _Filter.all || _filter == _Filter.pledges;
    final empty = p.attendance.isEmpty && p.pledges.isEmpty;
    if (empty) {
      // No numbers when there is nothing to count: one card that says what
      // to do next, and the drive they already registered for, if any.
      return PageListView(
        children: [
          if (error != null) ...[
            ErrorView(error: error, onRetry: () => ref.invalidate(passportProvider), compact: true),
            const SizedBox(height: Space.lg),
          ],
          const FadeInUp(child: _StartCard()),
          if (upcoming.isNotEmpty) ...[
            const SizedBox(height: Space.section),
            SectionLabel(l.passportNextDrive),
            for (final d in upcoming.take(3))
              Padding(
                padding: const EdgeInsets.only(bottom: Space.sm),
                child: SoiCard(
                  padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.md),
                  onTap: () => DriveRoute(id: d.id).push<void>(context),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d.title, style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                            Text('${Fmt.dayOrRelative(d.startsAt)} · ${Fmt.time(d.startsAt)} · ${d.orgName}',
                                style: context.text.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded, color: c.muted),
                    ],
                  ),
                ),
              ),
          ],
          const SizedBox(height: Space.section),
          Center(
            child: TextButton.icon(
              onPressed: () => const ClaimRoute().push<void>(context),
              icon: const Icon(Icons.school_outlined, size: 18),
              label: Text(l.passportLinkSchool),
            ),
          ),
        ],
      );
    }

    return PageListView(
      children: [
        if (error != null) ...[
          ErrorView(error: error, onRetry: () => ref.invalidate(passportProvider), compact: true),
          const SizedBox(height: Space.lg),
        ],
        _Hero(passport: p),
        const SizedBox(height: Space.md),
        _Milestone(certified: p.certifiedHours),
        if (upcoming.isNotEmpty) ...[
          const SizedBox(height: Space.section),
          SectionLabel(l.passportUpcoming),
          for (final d in upcoming.take(3))
            Padding(
              padding: const EdgeInsets.only(bottom: Space.sm),
              child: SoiCard(
                padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.md),
                onTap: () => DriveRoute(id: d.id).push<void>(context),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.title, style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text('${Fmt.dayOrRelative(d.startsAt)} · ${Fmt.time(d.startsAt)} · ${d.orgName}',
                              style: context.text.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: c.muted),
                  ],
                ),
              ),
            ),
        ],
        const SizedBox(height: Space.section),
        ...[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final f in _Filter.values) ...[
                  SoiFilterChip(
                    label: switch (f) {
                      _Filter.all => l.passportFilterAll,
                      _Filter.certified => l.passportFilterCertified,
                      _Filter.pending => l.passportFilterPending,
                      _Filter.rejected => l.passportFilterRejected,
                      _Filter.pledges => l.passportFilterPledges,
                    },
                    selected: _filter == f,
                    onSelected: (_) => setState(() => _filter = f),
                  ),
                  const SizedBox(width: Space.sm),
                ],
              ],
            ),
          ),
          const SizedBox(height: Space.lg),
          for (final (i, r) in rows.indexed)
            FadeInUp(index: i, child: Padding(padding: const EdgeInsets.only(bottom: Space.sm), child: _AttendanceRow(row: r))),
          if (rows.isEmpty && _filter != _Filter.pledges && _filter != _Filter.all)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Space.xl),
              child: Text(l.discoverNoMatchTitle, style: context.text.bodyMedium, textAlign: TextAlign.center),
            ),
          if (showPledges && p.pledges.isNotEmpty) ...[
            const SizedBox(height: Space.lg),
            SectionLabel(l.passportPledges),
            for (final s in p.pledges) Padding(padding: const EdgeInsets.only(bottom: Space.sm), child: _PledgeRow(row: s)),
            const SizedBox(height: Space.sm),
            Text(l.passportPledgesNote, style: context.text.bodySmall),
          ],
        ],
        const SizedBox(height: Space.section),
        TextButton.icon(
          onPressed: () => const ClaimRoute().push<void>(context),
          icon: const Icon(Icons.school_outlined, size: 18),
          label: Text(l.passportLinkSchool),
        ),
      ],
    );
  }
}

/// The zero state. No counters, one message, one action.
class _StartCard extends StatelessWidget {
  const _StartCard();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(Space.xxl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0E7C5A), SoiColors.deep],
        ),
        borderRadius: BorderRadius.circular(Radii.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PopIn(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(Radii.lg),
                border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
              ),
              child: const Icon(Icons.workspace_premium_outlined, color: SoiColors.certSaffron, size: 30),
            ),
          ),
          const SizedBox(height: Space.xl),
          Text(l.passportStartTitle, style: context.text.headlineSmall!.copyWith(color: Colors.white)),
          const SizedBox(height: Space.sm),
          Text(l.passportStartBody, style: context.text.bodyMedium!.copyWith(color: Colors.white.withValues(alpha: 0.8))),
          const SizedBox(height: Space.xl),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: SoiColors.certSaffron, foregroundColor: const Color(0xFF3A2000)),
            onPressed: () => const DiscoverRoute().go(context),
            child: Text(l.passportStartCta),
          ),
        ],
      ),
    );
  }
}

class _PassportSkeleton extends StatelessWidget {
  const _PassportSkeleton();
  @override
  Widget build(BuildContext context) {
    return const PageListView(
      children: [
        Shimmer(
          child: Column(
            children: [
              SkeletonBox(height: 190, radius: Radii.xl),
              SizedBox(height: Space.md),
              SkeletonBox(height: 72, radius: Radii.xl),
              SizedBox(height: Space.section),
              SkeletonCard(lines: 2),
              SkeletonCard(lines: 2),
            ],
          ),
        ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.passport});
  final Passport passport;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = passport;
    final hoursStyle = context.text.displayLarge!.copyWith(
      color: Colors.white,
      fontSize: 56,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    return Container(
      padding: const EdgeInsets.all(Space.xxl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0E7C5A), SoiColors.deep],
        ),
        borderRadius: BorderRadius.circular(Radii.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.passportCertifiedHours.toUpperCase(), style: context.text.labelSmall!.copyWith(color: SoiColors.certSaffron)),
          const SizedBox(height: Space.xs),
          Semantics(
            label: l.commonHours(p.certifiedHours),
            child: ExcludeSemantics(
              child: CountUp(p.certifiedHours, style: hoursStyle, decimals: p.certifiedHours % 1 == 0 ? 0 : 1),
            ),
          ),
          const SizedBox(height: Space.lg),
          GradientGlassTile(
            padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.md),
            child: Row(
              children: [
                Expanded(child: StatTile(value: Fmt.hours(p.pendingHours), label: l.passportPending, onDark: true)),
                Expanded(child: StatTile(value: '${p.certifiedDrives}', label: l.passportDrives, onDark: true)),
                Expanded(child: StatTile(value: '${p.pledges.length}', label: l.passportPledges, onDark: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Progress to the next certified-hours milestone.
class _Milestone extends StatelessWidget {
  const _Milestone({required this.certified});
  final num certified;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final next = _milestones.where((m) => m > certified).firstOrNull;
    final prev = _milestones.lastWhere((m) => m <= certified, orElse: () => 0);
    final progress = next == null ? 1.0 : ((certified - prev) / (next - prev)).clamp(0.0, 1.0);
    final String text;
    if (certified <= 0) {
      text = l.passportMilestoneFirst;
    } else if (next == null) {
      text = l.passportMilestoneReached(prev);
    } else {
      text = l.passportMilestoneBody(next - certified, next);
    }
    return SoiCard(
      padding: const EdgeInsets.symmetric(horizontal: Space.xl, vertical: Space.lg),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: c.saffronSoft, borderRadius: BorderRadius.circular(Radii.md)),
            child: Icon(Icons.flag_outlined, color: c.saffronInk),
          ),
          const SizedBox(width: Space.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(l.passportMilestoneTitle, style: context.text.titleSmall)),
                    if (next != null) Text('${Fmt.hours(certified)} / $next', style: context.text.labelMedium),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(Radii.pill),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: Motion.count,
                    curve: Motion.out,
                    builder: (context, v, _) => LinearProgressIndicator(
                      value: v,
                      minHeight: 8,
                      backgroundColor: c.bgAlt,
                      color: c.saffron,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(text, style: context.text.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceRow extends StatelessWidget {
  const _AttendanceRow({required this.row});
  final PassportRow row;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final r = row;
    final (icon, bg, fg, sub) = switch (r.status) {
      'certified' => (Icons.verified_rounded, c.greenSoft, c.greenDark, l.passportCertifiedRow(r.orgName)),
      'rejected' => (Icons.remove_circle_outline, c.dangerSoft, c.danger, l.passportRejectedRow(r.orgName)),
      _ => (Icons.hourglass_top_rounded, c.saffronSoft, c.saffronInk, l.passportPendingRow(r.orgName)),
    };
    final code = r.certificateCode;
    return SoiCard(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.md),
      onTap: code == null ? () => DriveRoute(id: r.driveId).push<void>(context) : () => CertificateRoute(code: code).push<void>(context),
      semanticsLabel: '${r.driveTitle}, ${l.commonHours(r.hours)}, $sub',
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Icon(icon, size: 20, color: fg),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.driveTitle, style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text('${Fmt.dayYear(r.startsAt)} · $sub', style: context.text.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: Space.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                l.commonHoursShort(Fmt.hours(r.hours)),
                style: context.text.labelLarge!.copyWith(color: r.isRejected ? c.muted : fg, decoration: r.isRejected ? TextDecoration.lineThrough : null),
              ),
              if (code != null) Icon(Icons.chevron_right_rounded, color: c.muted, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

class _PledgeRow extends StatelessWidget {
  const _PledgeRow({required this.row});
  final PassportPledge row;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final s = row;
    return SoiCard(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.md),
      onTap: () => s.certificateCode != null
          ? CertificateRoute(code: s.certificateCode!).push<void>(context)
          : PledgeRoute(code: s.shareCode).push<void>(context),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: c.saffronSoft, shape: BoxShape.circle),
            child: Icon(Icons.handshake_outlined, size: 20, color: c.saffronInk),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.title, style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text('${s.orgName} · ${l.passportPledgeSigned(Fmt.dayYear(s.signedAt), s.signatureNo)}',
                    style: context.text.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: c.muted, size: 18),
        ],
      ),
    );
  }
}
