import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/core/utils/qr_payload.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/features/drive/drive_screen.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/qr_view.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'coordinator_mode_screen.g.dart';

@riverpod
Future<String> checkinCode(Ref ref, String driveId) => ref.watch(drivesRepoProvider).checkinCode(driveId);

/// Live roster for one drive.
///
/// Realtime payloads carry attendance columns only (no names), so:
///   UPDATE  -> patch status/certified_at in place, no fetch
///   INSERT  -> coalesce for 300 ms, then one roster() fetch
///   DELETE  -> drop the row
///   (re)subscribed -> full fetch, in case events were missed
/// Everything is idempotent by row id because our own certify response
/// races the realtime event.
@riverpod
class DriveRoster extends _$DriveRoster {
  RealtimeChannel? _channel;
  Timer? _coalesce;

  @override
  Future<List<RosterRow>> build(String driveId) async {
    final repo = ref.watch(drivesRepoProvider);
    _channel = repo.subscribeAttendance(
      driveId,
      onChange: _onChange,
      onStatus: (status) {
        if (status == RealtimeSubscribeStatus.subscribed) _refetch();
      },
    );
    ref.onDispose(() {
      _coalesce?.cancel();
      final ch = _channel;
      if (ch != null) repo.unsubscribe(ch);
    });
    return await repo.roster(driveId);
  }

  void _onChange(PostgresChangePayload p) {
    switch (p.eventType) {
      case PostgresChangeEvent.update:
        final rec = p.newRecord;
        final id = rec['id'] as String?;
        if (id == null) return;
        final rows = state.value;
        if (rows == null) {
          _refetch();
          return;
        }
        state = AsyncData([
          for (final r in rows)
            if (r.attendanceId == id)
              r.copyWith(
                status: rec['status'] as String? ?? r.status,
                hours: rec['hours'] as num? ?? r.hours,
                certifiedAt: rec['certified_at'] == null ? r.certifiedAt : DateTime.tryParse(rec['certified_at'] as String),
              )
            else
              r,
        ]);
      case PostgresChangeEvent.delete:
        final id = p.oldRecord['id'] as String?;
        final rows = state.value;
        if (id == null || rows == null) return;
        state = AsyncData(rows.where((r) => r.attendanceId != id).toList());
      case PostgresChangeEvent.insert:
      case PostgresChangeEvent.all:
        _coalesce?.cancel();
        _coalesce = Timer(const Duration(milliseconds: 300), _refetch);
    }
  }

  Future<void> _refetch() async {
    try {
      final rows = await ref.read(drivesRepoProvider).roster(driveId);
      state = AsyncData(rows);
    } catch (e, st) {
      if (state.value == null) state = AsyncError(e, st);
    }
  }

  Future<void> refresh() => _refetch();

  Future<int> certify(List<String> ids) async {
    final n = await ref.read(drivesRepoProvider).certify(ids);
    await _refetch();
    return n;
  }

  Future<int> reject(List<String> ids) async {
    final n = await ref.read(drivesRepoProvider).reject(ids);
    await _refetch();
    return n;
  }
}

/// The screen a coordinator keeps open for the duration of a drive.
class CoordinatorModeScreen extends ConsumerStatefulWidget {
  const CoordinatorModeScreen({required this.driveId, super.key});
  final String driveId;

  @override
  ConsumerState<CoordinatorModeScreen> createState() => _CoordinatorModeScreenState();
}

class _CoordinatorModeScreenState extends ConsumerState<CoordinatorModeScreen> {
  final _search = TextEditingController();
  String _query = '';
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _boostBrightness();
  }

  Future<void> _boostBrightness() async {
    try {
      final sb = ScreenBrightness.instance;
      await sb.setApplicationScreenBrightness(1);
    } catch (_) {
      // Not supported on this device; the QR still scans fine.
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    ScreenBrightness.instance.resetApplicationScreenBrightness().catchError((_) {});
    _search.dispose();
    super.dispose();
  }

  Future<void> _rotate() async {
    final l = AppLocalizations.of(context);
    try {
      await ref.read(drivesRepoProvider).rotateCode(widget.driveId);
      ref.invalidate(checkinCodeProvider(widget.driveId));
      await HapticFeedback.selectionClick();
      if (mounted) showSnack(context, l.coordRotated);
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    }
  }

  Future<void> _certify(List<String> ids) async {
    final l = AppLocalizations.of(context);
    if (ids.isEmpty) return;
    final ok = await confirmDialog(context,
        title: l.coordCertifyConfirmTitle(ids.length), body: l.coordCertifyConfirmBody, confirmLabel: l.coordCertify, cancelLabel: l.dialogNotYet, icon: Icons.verified_outlined);
    if (!ok) return;
    setState(() => _busy = true);
    try {
      final n = await ref.read(driveRosterProvider(widget.driveId).notifier).certify(ids);
      ref.invalidate(driveDetailProvider(widget.driveId));
      await HapticFeedback.mediumImpact();
      if (mounted) showSnack(context, l.coordCertified(n));
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _reject(RosterRow r) async {
    final l = AppLocalizations.of(context);
    final ok = await confirmDialog(context,
        title: l.coordRejectConfirmTitle, body: l.coordRejectConfirmBody(r.displayName), confirmLabel: l.coordReject, cancelLabel: l.dialogKeepIt, destructive: true);
    if (!ok) return;
    try {
      await ref.read(driveRosterProvider(widget.driveId).notifier).reject([r.attendanceId]);
      if (mounted) showSnack(context, l.coordRejected);
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final drive = ref.watch(driveDetailProvider(widget.driveId));
    final code = ref.watch(checkinCodeProvider(widget.driveId));
    final roster = ref.watch(driveRosterProvider(widget.driveId));

    final rows = roster.value ?? const <RosterRow>[];
    final q = _query.toLowerCase();
    final visible = q.isEmpty
        ? rows
        : rows.where((r) => r.displayName.toLowerCase().contains(q) || (r.rollNo?.toLowerCase().contains(q) ?? false)).toList();
    final pendingIds = rows.where((r) => r.isPending).map((r) => r.attendanceId).toList();
    final certified = rows.where((r) => r.isCertified).length;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(l.coordTitle),
        actions: [
          drive.maybeWhen(
            data: (d) => d.org.type == 'school'
                ? IconButton(tooltip: l.coordMarkStudents, icon: const Icon(Icons.checklist), onPressed: () => MarkRoute(id: widget.driveId).push<void>(context))
                : const SizedBox.shrink(),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      floatingActionButton: pendingIds.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: _busy ? null : () => _certify(pendingIds),
              icon: const Icon(Icons.verified_outlined),
              label: Text(l.coordCertifyAll(pendingIds.length)),
            ),
      body: PageInsets(builder: (context, insets) => CustomScrollView(
        slivers: [
          SliverPadding(
            padding: insets,
            sliver: SliverList.list(
              children: [
                drive.when(
                  loading: () => const SizedBox.shrink(),
                  error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(driveDetailProvider(widget.driveId)), compact: true),
                  data: (d) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(d.title, style: context.text.headlineSmall),
                      Text('${Fmt.day(d.startsAt)} · ${Fmt.timeRange(d.startsAt, d.endsAt)}', style: context.text.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(height: Space.lg),
                Container(
                  padding: const EdgeInsets.all(Space.xl),
                  decoration: BoxDecoration(color: SoiColors.deep, borderRadius: BorderRadius.circular(Radii.xl)),
                  child: Column(
                    children: [
                      Text(l.coordShowThis.toUpperCase(), style: context.text.labelSmall!.copyWith(color: SoiColors.certSaffron)),
                      const SizedBox(height: Space.lg),
                      code.when(
                        loading: () => const SizedBox(height: 274, child: LoadingView()),
                        error: (e, _) => SizedBox(
                          height: 274,
                          child: Center(
                            child: ErrorView(error: e, onRetry: () => ref.invalidate(checkinCodeProvider(widget.driveId)), compact: true),
                          ),
                        ),
                        data: (value) => QrView(QrPayload.checkIn(widget.driveId, value), size: 250, semanticsLabel: l.coordShowThis),
                      ),
                      const SizedBox(height: Space.lg),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.white.withValues(alpha: 0.4), width: 1.5),
                                minimumSize: const Size.fromHeight(48),
                              ),
                              onPressed: _rotate,
                              icon: const Icon(Icons.refresh),
                              label: Text(l.coordRotate),
                            ),
                          ),
                          const SizedBox(width: Space.sm),
                          IconButton(
                            tooltip: l.commonCopy,
                            style: IconButton.styleFrom(foregroundColor: Colors.white),
                            icon: const Icon(Icons.copy_outlined),
                            onPressed: code.value == null ? null : () => copyToClipboard(context, QrPayload.checkIn(widget.driveId, code.value!)),
                          ),
                        ],
                      ),
                      const SizedBox(height: Space.sm),
                      Text(l.coordRotateHint, style: context.text.bodySmall!.copyWith(color: Colors.white60), textAlign: TextAlign.center),
                    ],
                  ),
                ),
                const SizedBox(height: Space.xl),
                SectionLabel(
                  l.coordRosterTitle,
                  trailing: Text(l.coordStats(rows.length, pendingIds.length, certified), style: context.text.labelSmall),
                ),
                if (rows.length > 6) ...[
                  TextField(
                    controller: _search,
                    onChanged: (v) => setState(() => _query = v.trim()),
                    decoration: InputDecoration(
                      hintText: l.coordRosterSearch,
                      prefixIcon: const Icon(Icons.search),
                      isDense: true,
                      suffixIcon: _query.isEmpty ? null : IconButton(icon: const Icon(Icons.close), onPressed: () {
                        _search.clear();
                        setState(() => _query = '');
                      }),
                    ),
                  ),
                  const SizedBox(height: Space.md),
                ],
                if (roster.hasError)
                  ErrorView(
                    error: SoiError(SoiError.from(roster.error!).isOffline ? 'OFFLINE' : 'ROSTER', SoiErrorKind.unknown),
                    onRetry: () => ref.read(driveRosterProvider(widget.driveId).notifier).refresh(),
                    compact: true,
                  ),
                if (roster.hasError) Padding(padding: const EdgeInsets.only(top: Space.sm), child: Text(l.coordRosterError, style: context.text.bodySmall)),
              ],
            ),
          ),
          if (roster.isLoading && rows.isEmpty)
            const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Space.xxl), child: LoadingView()))
          else if (rows.isEmpty && !roster.hasError)
            SliverToBoxAdapter(child: EmptyView(icon: Icons.qr_code_scanner, title: l.coordRosterEmpty, body: l.coordRosterEmptyBody))
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(Space.page, 0, Space.page, 96),
              sliver: SliverList.builder(
                itemCount: visible.length,
                itemBuilder: (context, i) {
                  final r = visible[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: Space.sm),
                    child: _RosterTile(
                      row: r,
                      onCertify: _busy ? null : () => _certify([r.attendanceId]),
                      onReject: _busy ? null : () => _reject(r),
                    ),
                  );
                },
              ),
            ),
          if (rows.isNotEmpty && visible.isEmpty)
            SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Space.xl), child: Text(l.discoverNoMatchTitle, style: context.text.bodyMedium, textAlign: TextAlign.center))),
        ],
      )),
    );
  }
}

class _RosterTile extends StatelessWidget {
  const _RosterTile({required this.row, required this.onCertify, required this.onReject});
  final RosterRow row;
  final VoidCallback? onCertify;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final r = row;
    final (label, tone) = switch (r.status) {
      'certified' => (l.coordStatusCertified, TagTone.green),
      'rejected' => (l.coordStatusRejected, TagTone.danger),
      _ => (l.coordStatusPending, TagTone.saffron),
    };
    return SoiCard(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.md),
      child: Row(
        children: [
          InitialsAvatar(r.displayName, tone: r.isStudent ? TagTone.saffron : TagTone.green),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.displayName, style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(
                  [
                    if (r.isStudent) [r.schoolName, r.classSection, r.rollNo].whereType<String>().join(' · '),
                    if (r.method == 'teacher') l.coordMethodTeacher else Fmt.ago(r.checkInAt),
                    l.commonHoursShort(Fmt.hours(r.hours)),
                  ].where((s) => s.isNotEmpty).join(' · '),
                  style: context.text.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: Space.sm),
          SoiTag(label, tone: tone),
          if (r.isPending)
            PopupMenuButton<String>(
              tooltip: l.commonEdit,
              icon: Icon(Icons.more_vert, color: c.muted),
              onSelected: (v) => v == 'certify' ? onCertify?.call() : onReject?.call(),
              itemBuilder: (_) => [
                PopupMenuItem(value: 'certify', child: Text(l.coordCertify)),
                PopupMenuItem(value: 'reject', child: Text(l.coordReject)),
              ],
            ),
        ],
      ),
    );
  }
}
