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
        appBar: AppBar(title: Text(l.passportTitle)),
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
      appBar: AppBar(title: Text(l.passportTitle)),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(passportProvider);
          ref.invalidate(myUpcomingProvider);
          await ref.read(passportProvider.future);
        },
        child: async.when(
          loading: () => cached == null ? const LoadingView() : _content(cached, upcoming, stale: true),
          error: (e, _) => cached == null
              ? ErrorView(error: e, onRetry: () => ref.invalidate(passportProvider))
              : _content(cached, upcoming, error: e),
          data: (p) => _content(p, upcoming),
        ),
      ),
    );
  }

  Widget _content(Passport p, List<UpcomingDrive> upcoming, {bool stale = false, Object? error}) {
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

    return ListView(
      padding: pagePadding,
      children: [
        if (error != null) ...[
          ErrorView(error: error, onRetry: () => ref.invalidate(passportProvider), compact: true),
          const SizedBox(height: Space.md),
        ],
        _Hero(passport: p),
        const SizedBox(height: Space.md),
        Text(l.passportLead, style: context.text.bodySmall),
        if (upcoming.isNotEmpty) ...[
          const SizedBox(height: Space.xl),
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
        const SizedBox(height: Space.xl),
        if (empty)
          EmptyView(
            icon: Icons.workspace_premium_outlined,
            title: l.passportEmptyTitle,
            body: l.passportEmptyBody,
            action: FilledButton.tonal(onPressed: () => const DiscoverRoute().go(context), child: Text(l.navDiscover)),
          )
        else ...[
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
          const SizedBox(height: Space.md),
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
            for (final s in p.pledges)
              Padding(padding: const EdgeInsets.only(bottom: Space.sm), child: _PledgeRow(row: s)),
            const SizedBox(height: Space.sm),
            Text(l.passportPledgesNote, style: context.text.bodySmall),
          ],
        ],
        const SizedBox(height: Space.xl),
        TextButton.icon(
          onPressed: () => const ClaimRoute().push<void>(context),
          icon: const Icon(Icons.school_outlined, size: 18),
          label: Text(l.passportLinkSchool),
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
          Text(l.passportCertifiedHours.toUpperCase(),
              style: context.text.labelSmall!.copyWith(color: SoiColors.certSaffron)),
          const SizedBox(height: Space.xs),
          Semantics(
            label: l.commonHours(p.certifiedHours),
            child: ExcludeSemantics(
              child: CountUp(p.certifiedHours, style: hoursStyle, decimals: p.certifiedHours % 1 == 0 ? 0 : 1),
            ),
          ),
          const SizedBox(height: Space.lg),
          Row(
            children: [
              Expanded(child: StatTile(value: Fmt.hours(p.pendingHours), label: l.passportPending, onDark: true)),
              Expanded(child: StatTile(value: '${p.certifiedDrives}', label: l.passportDrives, onDark: true)),
              Expanded(child: StatTile(value: '${p.pledges.length}', label: l.passportPledges, onDark: true)),
            ],
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
