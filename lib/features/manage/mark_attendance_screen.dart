import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/drive/drive_screen.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

part 'mark_attendance_screen.g.dart';

typedef _Candidate = ({Student student, String orgName});

@riverpod
Future<({List<_Candidate> students, Set<String> marked})> markCandidates(Ref ref, String driveId) async {
  final schools = ref.watch(sessionControllerProvider.select((s) => s.coordinated.where((m) => m.orgType == 'school').toList()));
  final orgs = ref.watch(orgsRepoProvider);
  final results = await Future.wait([
    for (final m in schools) orgs.roster(m.orgId).then((rows) => [for (final s in rows) (student: s, orgName: m.orgName)]),
  ]);
  final marked = await ref.watch(drivesRepoProvider).markedStudents(driveId);
  return (students: results.expand((x) => x).toList(), marked: marked);
}

/// A teacher marks pupils present at a drive. The drive's organisation
/// still certifies; this records pending hours only.
class MarkAttendanceScreen extends ConsumerStatefulWidget {
  const MarkAttendanceScreen({required this.driveId, super.key});
  final String driveId;

  @override
  ConsumerState<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends ConsumerState<MarkAttendanceScreen> {
  final _picked = <String>{};
  final _search = TextEditingController();
  String _query = '';
  bool _busy = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _submit(String driveTitle) async {
    final l = AppLocalizations.of(context);
    final ok = await confirmDialog(context, title: l.markConfirmTitle(_picked.length), body: l.markConfirmBody(driveTitle), confirmLabel: l.commonContinue, cancelLabel: l.dialogGoBack, icon: Icons.checklist);
    if (!ok) return;
    setState(() => _busy = true);
    try {
      final n = await ref.read(drivesRepoProvider).markStudents(widget.driveId, _picked.toList());
      ref.invalidate(markCandidatesProvider(widget.driveId));
      ref.invalidate(driveDetailProvider(widget.driveId));
      if (!mounted) return;
      _picked.clear();
      showSnack(context, l.markDone(n));
      Navigator.of(context).pop();
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final drive = ref.watch(driveDetailProvider(widget.driveId));
    final data = ref.watch(markCandidatesProvider(widget.driveId));
    final title = drive.value?.title ?? '';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: Text(l.markTitle)),
      floatingActionButton: _picked.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: _busy ? null : () => _submit(title),
              icon: const Icon(Icons.check),
              label: Text(l.markSelected(_picked.length)),
            ),
      body: data.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(markCandidatesProvider(widget.driveId))),
        data: (d) {
          final q = _query.toLowerCase();
          final all = d.students.where((x) => q.isEmpty || x.student.fullName.toLowerCase().contains(q) || (x.student.classSection?.toLowerCase().contains(q) ?? false)).toList();
          final selectable = all.where((x) => !d.marked.contains(x.student.studentId)).map((x) => x.student.studentId).toSet();
          final multiOrg = d.students.map((x) => x.orgName).toSet().length > 1;
          if (d.students.isEmpty) {
            return EmptyView(icon: Icons.groups_outlined, title: l.rosterEmptyTitle, body: l.rosterEmptyBody);
          }
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: pageInsets(context).copyWith(bottom: 0),
                sliver: SliverList.list(
                  children: [
                    Text(title, style: context.text.titleLarge),
                    const SizedBox(height: 4),
                    Text(l.markLead, style: context.text.bodyMedium),
                    const SizedBox(height: Space.md),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _search,
                            onChanged: (v) => setState(() => _query = v.trim()),
                            decoration: InputDecoration(hintText: l.rosterSearch, prefixIcon: const Icon(Icons.search), isDense: true),
                          ),
                        ),
                        const SizedBox(width: Space.sm),
                        TextButton(
                          onPressed: () => setState(() => _picked.containsAll(selectable) ? _picked.removeAll(selectable) : _picked.addAll(selectable)),
                          child: Text(l.markSelectAll),
                        ),
                      ],
                    ),
                    const SizedBox(height: Space.sm),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(Space.page, 0, Space.page, 96),
                sliver: SliverList.builder(
                  itemCount: all.length,
                  itemBuilder: (context, i) {
                    final s = all[i].student;
                    final already = d.marked.contains(s.studentId);
                    final on = _picked.contains(s.studentId);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: Space.sm),
                      child: SoiCard(
                        padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: Space.sm),
                        color: on ? c.greenSoft : null,
                        borderColor: on ? c.greenTint : null,
                        onTap: already ? null : () => setState(() => on ? _picked.remove(s.studentId) : _picked.add(s.studentId)),
                        child: Row(
                          children: [
                            Checkbox(
                              value: already || on,
                              onChanged: already ? null : (_) => setState(() => on ? _picked.remove(s.studentId) : _picked.add(s.studentId)),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(s.fullName, style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                                  Text(
                                    [if (multiOrg) all[i].orgName, s.classSection, if (s.rollNo != null) '#${s.rollNo}'].whereType<String>().join(' · '),
                                    style: context.text.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            if (already) SoiTag(l.markAlready, tone: TagTone.green, icon: Icons.check),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
