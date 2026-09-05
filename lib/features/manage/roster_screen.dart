import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/features/manage/manage_providers.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

/// School-held roster: people without accounts. Search, class groups,
/// enrol one or paste many, edit, remove (only while they have no records),
/// and hand out claim codes.
class RosterScreen extends ConsumerStatefulWidget {
  const RosterScreen({required this.orgId, super.key});
  final String orgId;

  @override
  ConsumerState<RosterScreen> createState() => _RosterScreenState();
}

class _RosterScreenState extends ConsumerState<RosterScreen> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _add() async {
    final result = await showSoiSheet<EnrolResult>(
      context,
      scrollable: true,
      builder: (ctx) => _PersonForm(orgId: widget.orgId),
    );
    if (result == null || !mounted) return;
    ref.invalidate(orgRosterProvider(widget.orgId));
  }

  Future<void> _bulk() async {
    final done = await showSoiSheet<bool>(context, scrollable: true, builder: (ctx) => _BulkSheet(orgId: widget.orgId));
    if (done == true && mounted) ref.invalidate(orgRosterProvider(widget.orgId));
  }

  Future<void> _open(Student s) async {
    final changed = await showSoiSheet<bool>(context, scrollable: true, builder: (ctx) => _StudentSheet(student: s, orgId: widget.orgId));
    if (changed == true && mounted) ref.invalidate(orgRosterProvider(widget.orgId));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final roster = ref.watch(orgRosterProvider(widget.orgId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(l.rosterTitle),
        actions: [IconButton(tooltip: l.rosterBulk, icon: const Icon(Icons.playlist_add), onPressed: _bulk)],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: _add, icon: const Icon(Icons.person_add_alt_1), label: Text(l.rosterAdd)),
      body: roster.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(orgRosterProvider(widget.orgId))),
        data: (rows) {
          if (rows.isEmpty) {
            return EmptyView(icon: Icons.groups_outlined, title: l.rosterEmptyTitle, body: l.rosterEmptyBody);
          }
          final q = _query.toLowerCase();
          final visible = q.isEmpty
              ? rows
              : rows.where((s) => s.fullName.toLowerCase().contains(q) || (s.rollNo?.toLowerCase().contains(q) ?? false) || (s.classSection?.toLowerCase().contains(q) ?? false)).toList();
          final groups = <String, List<Student>>{};
          for (final s in visible) {
            (groups[s.classSection ?? ''] ??= []).add(s);
          }
          final keys = groups.keys.toList()..sort((a, b) => a.isEmpty ? 1 : b.isEmpty ? -1 : a.compareTo(b));

          return PageInsets(builder: (context, insets) => CustomScrollView(
            slivers: [
              SliverPadding(
                padding: insets.copyWith(bottom: 0),
                sliver: SliverList.list(
                  children: [
                    Text(l.rosterLead, style: context.text.bodyMedium),
                    const SizedBox(height: Space.md),
                    TextField(
                      controller: _search,
                      onChanged: (v) => setState(() => _query = v.trim()),
                      decoration: InputDecoration(
                        hintText: l.rosterSearch,
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
                ),
              ),
              for (final k in keys)
                SliverMainAxisGroup(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(Space.page, Space.md, Space.page, 0),
                      sliver: SliverToBoxAdapter(child: SectionLabel(k.isEmpty ? l.rosterGroupUngrouped : k)),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: Space.page),
                      sliver: SliverList.builder(
                        itemCount: groups[k]!.length,
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.only(bottom: Space.sm),
                          child: _StudentTile(s: groups[k]![i], onTap: () => _open(groups[k]![i])),
                        ),
                      ),
                    ),
                  ],
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 96)),
            ],
          ));
        },
      ),
    );
  }
}

class _StudentTile extends StatelessWidget {
  const _StudentTile({required this.s, required this.onTap});
  final Student s;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    return SoiCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.md),
      child: Row(
        children: [
          InitialsAvatar(s.fullName, tone: s.kind == 'student' ? TagTone.saffron : TagTone.green),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(child: Text(s.fullName, style: context.text.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                    if (s.claimed) ...[
                      const SizedBox(width: 6),
                      Icon(Icons.link, size: 14, color: c.greenMid, semanticLabel: l.rosterClaimed),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  [
                    if (s.rollNo != null) '#${s.rollNo}',
                    l.rosterHours(Fmt.hours(s.certifiedHours), Fmt.hours(s.pendingHours)),
                  ].join(' · '),
                  style: context.text.bodySmall,
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: c.muted),
        ],
      ),
    );
  }
}

/// Enrol or edit one person. Validation on interaction, mirroring the server.
class _PersonForm extends ConsumerStatefulWidget {
  const _PersonForm({required this.orgId, this.existing});
  final String orgId;
  final Student? existing;

  @override
  ConsumerState<_PersonForm> createState() => _PersonFormState();
}

class _PersonFormState extends ConsumerState<_PersonForm> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.existing?.fullName ?? '');
  late final _class = TextEditingController(text: widget.existing?.classSection ?? '');
  late final _roll = TextEditingController(text: widget.existing?.rollNo ?? '');
  late final _email = TextEditingController(text: widget.existing?.email ?? '');
  late final _phone = TextEditingController(text: widget.existing?.phone ?? '');
  late String _kind = widget.existing?.kind ?? 'student';
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    for (final c in [_name, _class, _roll, _email, _phone]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context);
    setState(() => _error = null);
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    String? nz(String s) => s.trim().isEmpty ? null : s.trim();
    try {
      final repo = ref.read(orgsRepoProvider);
      if (widget.existing == null) {
        final r = await repo.enrol(orgId: widget.orgId, name: _name.text, kind: _kind, classSection: nz(_class.text),
            rollNo: nz(_roll.text), email: nz(_email.text), phone: nz(_phone.text));
        if (!mounted) return;
        showSnack(context, l.rosterEnrolled(_name.text.trim(), r.claimCode));
        Navigator.of(context).pop(r);
      } else {
        await repo.updateStudent(studentId: widget.existing!.studentId, name: _name.text, classSection: nz(_class.text),
            rollNo: nz(_roll.text), email: nz(_email.text), phone: nz(_phone.text));
        if (!mounted) return;
        Navigator.of(context).pop(true);
      }
    } on SoiError catch (e) {
      if (mounted) setState(() => _error = e.message(l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Form(
      key: _form,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.existing == null ? l.rosterAdd : l.commonEdit, style: context.text.titleLarge),
          const SizedBox(height: Space.md),
          if (widget.existing == null)
            SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'student', label: Text(l.rosterKindStudent), icon: const Icon(Icons.school_outlined)),
                ButtonSegment(value: 'volunteer', label: Text(l.rosterKindVolunteer), icon: const Icon(Icons.volunteer_activism_outlined)),
              ],
              selected: {_kind},
              onSelectionChanged: (s) => setState(() => _kind = s.first),
            ),
          const SizedBox(height: Space.md),
          TextFormField(
            controller: _name,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            maxLength: 80,
            validator: (v) => fieldError(context, Validators.personName(v ?? '')),
            decoration: InputDecoration(labelText: l.rosterName, counterText: ''),
          ),
          const SizedBox(height: Space.md),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _class,
                  textCapitalization: TextCapitalization.characters,
                  maxLength: 20,
                  validator: (v) => fieldError(context, Validators.classSection(v ?? '')),
                  decoration: InputDecoration(labelText: l.rosterClass, counterText: ''),
                ),
              ),
              const SizedBox(width: Space.md),
              Expanded(
                child: TextFormField(
                  controller: _roll,
                  maxLength: 12,
                  validator: (v) => fieldError(context, Validators.rollNo(v ?? '')),
                  decoration: InputDecoration(labelText: l.rosterRoll, counterText: ''),
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.md),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            validator: (v) => (v ?? '').trim().isEmpty ? null : fieldError(context, Validators.email(v!)),
            decoration: InputDecoration(labelText: '${l.rosterEmail} (${l.commonOptional})'),
          ),
          const SizedBox(height: Space.md),
          TextFormField(
            controller: _phone,
            keyboardType: TextInputType.phone,
            validator: (v) => fieldError(context, Validators.phone(v ?? '')),
            decoration: InputDecoration(labelText: '${l.rosterPhone} (${l.commonOptional})'),
          ),
          const SizedBox(height: Space.md),
          Text(l.rosterPrivacyNote, style: context.text.bodySmall),
          if (_error != null) ...[
            const SizedBox(height: Space.md),
            Notice(_error!, tone: TagTone.danger, icon: Icons.error_outline),
          ],
          const SizedBox(height: Space.lg),
          FilledButton(onPressed: _busy ? null : _submit, child: Text(widget.existing == null ? l.rosterAdd : l.commonSave)),
        ],
      ),
    );
  }
}

class _StudentSheet extends ConsumerStatefulWidget {
  const _StudentSheet({required this.student, required this.orgId});
  final Student student;
  final String orgId;

  @override
  ConsumerState<_StudentSheet> createState() => _StudentSheetState();
}

class _StudentSheetState extends ConsumerState<_StudentSheet> {
  Future<void> _remove() async {
    final l = AppLocalizations.of(context);
    final ok = await confirmDialog(context, title: l.rosterRemoveConfirmTitle(widget.student.fullName), body: l.rosterRemoveConfirmBody, confirmLabel: l.commonRemove, cancelLabel: l.dialogKeepMember, destructive: true);
    if (!ok || !mounted) return;
    try {
      await ref.read(orgsRepoProvider).removeStudent(widget.student.studentId);
      if (!mounted) return;
      showSnack(context, l.rosterRemoved);
      Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    }
  }

  Future<void> _edit() async {
    final changed = await showSoiSheet<bool>(context, scrollable: true, builder: (ctx) => _PersonForm(orgId: widget.orgId, existing: widget.student));
    if (changed == true && mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final s = widget.student;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            InitialsAvatar(s.fullName, size: 48, tone: s.kind == 'student' ? TagTone.saffron : TagTone.green),
            const SizedBox(width: Space.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.fullName, style: context.text.titleLarge),
                  Text([if (s.kind == 'student') l.rosterKindStudent else l.rosterKindVolunteer, s.classSection, if (s.rollNo != null) '#${s.rollNo}'].whereType<String>().join(' · '), style: context.text.bodySmall),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: Space.lg),
        SoiCard(
          child: Row(
            children: [
              Expanded(child: StatTile(value: Fmt.hours(s.certifiedHours), label: l.passportCertifiedHours)),
              Expanded(child: StatTile(value: Fmt.hours(s.pendingHours), label: l.passportPending)),
            ],
          ),
        ),
        const SizedBox(height: Space.lg),
        SectionLabel(l.rosterClaimCode),
        if (s.claimed)
          Notice(l.rosterClaimed, icon: Icons.link)
        else
          Container(
            padding: const EdgeInsets.all(Space.lg),
            decoration: BoxDecoration(color: c.saffronSoft, borderRadius: BorderRadius.circular(Radii.lg)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: SelectableText(s.claimCode, style: context.text.headlineSmall!.copyWith(letterSpacing: 4, color: c.saffronInk))),
                    IconButton(tooltip: l.commonCopy, icon: const Icon(Icons.copy_outlined), onPressed: () => copyToClipboard(context, s.claimCode)),
                    IconButton(tooltip: l.commonShare, icon: const Icon(Icons.share_outlined), onPressed: () => SharePlus.instance.share(ShareParams(text: '${l.appName}: ${l.rosterClaimCode} ${s.claimCode}'))),
                  ],
                ),
                Text(l.rosterClaimHint, style: context.text.bodySmall!.copyWith(color: c.saffronInk)),
              ],
            ),
          ),
        const SizedBox(height: Space.lg),
        Row(
          children: [
            Expanded(child: OutlinedButton.icon(onPressed: _edit, icon: const Icon(Icons.edit_outlined), label: Text(l.commonEdit))),
            const SizedBox(width: Space.sm),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(foregroundColor: c.danger),
                onPressed: s.claimed || s.certifiedHours > 0 || s.pendingHours > 0 ? null : _remove,
                icon: const Icon(Icons.person_remove_outlined),
                label: Text(l.commonRemove),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Paste "name, class, roll" lines and enrol them all.
class _BulkSheet extends ConsumerStatefulWidget {
  const _BulkSheet({required this.orgId});
  final String orgId;

  @override
  ConsumerState<_BulkSheet> createState() => _BulkSheetState();
}

class _BulkSheetState extends ConsumerState<_BulkSheet> {
  final _text = TextEditingController();
  bool _busy = false;
  int _done = 0;

  List<(String, String?, String?)> get _rows {
    final out = <(String, String?, String?)>[];
    for (final line in _text.text.split('\n')) {
      final parts = line.split(RegExp(r'[,\t]')).map((p) => p.trim()).toList();
      if (parts.isEmpty || parts.first.isEmpty) continue;
      out.add((parts.first, parts.length > 1 && parts[1].isNotEmpty ? parts[1] : null, parts.length > 2 && parts[2].isNotEmpty ? parts[2] : null));
    }
    return out;
  }

  Future<void> _enrol() async {
    final l = AppLocalizations.of(context);
    final rows = _rows;
    if (rows.isEmpty) return;
    setState(() {
      _busy = true;
      _done = 0;
    });
    var ok = 0;
    var failed = 0;
    final repo = ref.read(orgsRepoProvider);
    for (final (name, cls, roll) in rows) {
      try {
        await repo.enrol(orgId: widget.orgId, name: name, kind: 'student', classSection: cls, rollNo: roll);
        ok++;
      } catch (_) {
        failed++;
      }
      if (mounted) setState(() => _done++);
    }
    if (!mounted) return;
    showSnack(context, l.rosterBulkDone(ok, failed));
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final n = _rows.length;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l.rosterBulkTitle, style: context.text.titleLarge),
        const SizedBox(height: Space.xs),
        Text(l.rosterBulkLead, style: context.text.bodyMedium),
        const SizedBox(height: Space.md),
        TextField(
          controller: _text,
          autofocus: true,
          maxLines: 8,
          minLines: 5,
          enabled: !_busy,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(hintText: 'Rahul Verma, 9A, 12\nSneha Iyer, 9B, 4'),
        ),
        const SizedBox(height: Space.md),
        Text(_busy ? '$_done / $n' : l.rosterBulkPreview(n), style: context.text.bodySmall),
        const SizedBox(height: Space.md),
        FilledButton(onPressed: _busy || n == 0 ? null : _enrol, child: Text(l.rosterBulkEnrol)),
      ],
    );
  }
}
