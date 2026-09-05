import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soi/core/links.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/discover/discover_controller.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

part 'drive_screen.g.dart';

@riverpod
Future<DriveDetail> driveDetail(Ref ref, String id) =>
    ref.watch(drivesRepoProvider).detail(id);

/// Public drive page. Register / un-register, directions, share, report;
/// coordinators get Edit and Coordinator Mode.
class DriveScreen extends ConsumerStatefulWidget {
  const DriveScreen({required this.id, super.key});
  final String id;

  @override
  ConsumerState<DriveScreen> createState() => _DriveScreenState();
}

class _DriveScreenState extends ConsumerState<DriveScreen> {
  bool _busy = false;

  Future<void> _toggleRegistration(DriveDetail d) async {
    final l = AppLocalizations.of(context);
    final session = ref.read(sessionControllerProvider);
    if (!session.isSignedIn) {
      unawaited(
        SignInRoute(from: DriveRoute(id: d.id).location).push<void>(context),
      );
      return;
    }
    if (d.registered) {
      final ok = await confirmDialog(
        context,
        title: l.driveCancelConfirmTitle,
        body: l.driveCancelConfirmBody,
        confirmLabel: l.driveCancelRegistration,
        cancelLabel: l.dialogKeepSpot,
        destructive: true,
        icon: Icons.event_busy_outlined,
      );
      if (!ok) return;
    }
    setState(() => _busy = true);
    try {
      final repo = ref.read(drivesRepoProvider);
      final spots = d.registered
          ? await repo.cancelRegistration(d.id)
          : await repo.register(d.id);
      ref
          .read(discoverControllerProvider.notifier)
          .patchRegistration(d.id, registered: !d.registered, spotsLeft: spots);
      ref.invalidate(driveDetailProvider(d.id));
      if (mounted) {
        showSnack(
          context,
          d.registered ? l.driveCancelledSnack : l.driveRegisteredSnack,
        );
      }
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _share(DriveDetail d) async {
    final l = AppLocalizations.of(context);
    final when = '${Fmt.day(d.startsAt)}, ${Fmt.time(d.startsAt)}';
    await SharePlus.instance.share(
      ShareParams(
        text: l.driveShareText(
          d.title,
          d.org.name,
          when,
          Links.driveDeepLink(d.id).toString(),
        ),
      ),
    );
  }

  Future<void> _directions(DriveDetail d) async {
    final q = [d.venue, d.city].whereType<String>().join(', ');
    if (q.isEmpty) return;
    final uri = Links.mapsSearch(q);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      await launchUrl(
        Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': q}),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _report(DriveDetail d) async {
    final l = AppLocalizations.of(context);
    if (!ref.read(sessionControllerProvider).isSignedIn) {
      unawaited(
        SignInRoute(from: DriveRoute(id: d.id).location).push<void>(context),
      );
      return;
    }
    final reason = await showSoiSheet<String>(
      context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.driveReportTitle, style: ctx.text.titleLarge),
          const SizedBox(height: Space.md),
          for (final r in [
            l.driveReportReason1,
            l.driveReportReason2,
            l.driveReportReason3,
          ])
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(r),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(ctx).pop(r),
            ),
        ],
      ),
    );
    if (reason == null || !mounted) return;
    try {
      await ref
          .read(accountRepoProvider)
          .report(targetType: 'drive', targetId: d.id, reason: reason);
      if (mounted) showSnack(context, l.driveReportThanks);
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    }
  }

  /// Register / registered, frosted, floating over the end of the list.
  Widget? _actionBar(DriveDetail d) {
    final l = AppLocalizations.of(context);
    if (d.canManage && d.registered) return null;
    return GlassActionBar(
      child: d.registered
          ? OutlinedButton.icon(
              onPressed: _busy ? null : () => _toggleRegistration(d),
              icon: const Icon(Icons.check_circle, size: 20),
              label: Text(l.driveRegistered),
            )
          : FilledButton(
              onPressed: _busy || !d.canRegister || d.isFull
                  ? null
                  : () => _toggleRegistration(d),
              child: _busy
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(l.driveRegister),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final detail = ref.watch(driveDetailProvider(widget.id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(l.driveTitle),
        actions: [
          detail.maybeWhen(
            data: (d) => IconButton(
              tooltip: l.commonShare,
              icon: const Icon(Icons.share_outlined),
              onPressed: () => _share(d),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: detail.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(
          error: e,
          onRetry: () => ref.invalidate(driveDetailProvider(widget.id)),
        ),
        data: (d) => _Body(
          drive: d,
          onDirections: () => _directions(d),
          onReport: () => _report(d),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: detail.maybeWhen(
        data: _actionBar,
        orElse: () => null,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.drive,
    required this.onDirections,
    required this.onReport,
  });
  final DriveDetail drive;
  final VoidCallback onDirections;
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final d = drive;
    final where = [d.venue, d.city].whereType<String>().join(', ');
    final att = d.myAttendance;

    final String? banner;
    final TagTone bannerTone;
    if (d.isCancelled) {
      banner = l.driveCancelledBanner;
      bannerTone = TagTone.danger;
    } else if (d.hasEnded) {
      banner = l.driveEndedBanner;
      bannerTone = TagTone.neutral;
    } else if (d.isFull && !d.registered) {
      banner = l.driveFullBanner;
      bannerTone = TagTone.saffron;
    } else {
      banner = null;
      bannerTone = TagTone.neutral;
    }

    return PageListView(
      children: [
        if (banner != null) ...[
          Notice(banner, tone: bannerTone, icon: Icons.info_outline),
          const SizedBox(height: Space.lg),
        ],
        if (att != null) ...[
          Notice(
            att.status == 'certified'
                ? l.driveCheckedInCertified
                : l.driveCheckedInPending(d.org.name),
            tone: att.status == 'certified' ? TagTone.green : TagTone.saffron,
            icon: att.status == 'certified'
                ? Icons.verified_outlined
                : Icons.hourglass_top_rounded,
          ),
          const SizedBox(height: Space.lg),
        ],
        Row(
          children: [
            SoiTag(Fmt.dayOrRelative(d.startsAt), tone: TagTone.green),
            const SizedBox(width: Space.sm),
            if (d.cause != null) SoiTag(d.cause!, tone: TagTone.saffron),
          ],
        ),
        const SizedBox(height: Space.md),
        Text(d.title, style: context.text.headlineMedium),
        const SizedBox(height: Space.md),
        InkWell(
          borderRadius: BorderRadius.circular(Radii.md),
          onTap: () => OrgRoute(id: d.org.id).push<void>(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                InitialsAvatar(d.org.name, size: 34),
                const SizedBox(width: Space.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.driveOrganiser, style: context.text.labelSmall),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              d.org.name,
                              style: context.text.titleSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (d.org.isVerified) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: c.greenMid,
                              semanticLabel: l.discoverVerified,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: c.muted),
              ],
            ),
          ),
        ),
        const SizedBox(height: Space.lg),
        SoiCard(
          padding: const EdgeInsets.symmetric(
            horizontal: Space.lg,
            vertical: Space.xs,
          ),
          child: Column(
            children: [
              FactRow(
                icon: Icons.calendar_today_outlined,
                label: l.driveWhen,
                value:
                    '${Fmt.day(d.startsAt)} · ${Fmt.timeRange(d.startsAt, d.endsAt)}',
              ),
              const Divider(),
              FactRow(
                icon: Icons.place_outlined,
                label: l.driveWhere,
                value: where.isEmpty ? '—' : where,
                onTap: where.isEmpty ? null : onDirections,
              ),
              const Divider(),
              FactRow(
                icon: Icons.timer_outlined,
                label: l.driveHoursCredited,
                value: l.commonHours(d.defaultHours),
              ),
              const Divider(),
              FactRow(
                icon: Icons.people_outline,
                label: l.driveSpots,
                value: '${l.discoverSpotsLeft(d.spotsLeft)} · ${d.capacity}',
              ),
            ],
          ),
        ),
        if (d.description != null && d.description!.trim().isNotEmpty) ...[
          const SizedBox(height: Space.xl),
          SectionLabel(l.driveAbout),
          Text(d.description!, style: context.text.bodyLarge),
        ],
        const SizedBox(height: Space.xl),
        Notice(
          l.driveNothingCertifiedAuto,
          tone: TagTone.neutral,
          icon: Icons.verified_user_outlined,
        ),
        const SizedBox(height: Space.lg),
        if (d.canManage) ...[
          SectionLabel(l.driveManage),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => DriveEditRoute(id: d.id).push<void>(context),
                  icon: const Icon(Icons.edit_outlined),
                  label: Text(l.commonEdit),
                ),
              ),
              const SizedBox(width: Space.sm),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () =>
                      CoordinatorRoute(id: d.id).push<void>(context),
                  icon: const Icon(Icons.qr_code_2),
                  label: Text(l.driveCoordinatorMode),
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.lg),
        ],
        Center(
          child: TextButton.icon(
            onPressed: onReport,
            style: TextButton.styleFrom(foregroundColor: c.muted),
            icon: const Icon(Icons.flag_outlined, size: 18),
            label: Text(l.driveReport),
          ),
        ),
      ],
    );
  }
}
