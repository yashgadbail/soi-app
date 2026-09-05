import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/discover/discover_controller.dart';
import 'package:soi/features/drive/drive_screen.dart';
import 'package:soi/features/manage/manage_providers.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

/// Publish or edit a drive. Inline validation mirrors the server; an
/// unsaved-changes guard protects the form; cancelling a drive is a
/// confirmed, separate action.
class DriveFormScreen extends ConsumerStatefulWidget {
  const DriveFormScreen({super.key, this.orgId, this.driveId});
  final String? orgId;
  final String? driveId;

  bool get isEdit => driveId != null;

  @override
  ConsumerState<DriveFormScreen> createState() => _DriveFormScreenState();
}

class _DriveFormScreenState extends ConsumerState<DriveFormScreen> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _venue = TextEditingController();
  final _city = TextEditingController();
  final _capacity = TextEditingController(text: '50');
  final _hours = TextEditingController(text: '4');
  String? _cause;
  String? _orgId;
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _start = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _end = const TimeOfDay(hour: 13, minute: 0);
  bool _busy = false;
  bool _loaded = false;
  bool _dirty = false;
  String? _formError;

  @override
  void initState() {
    super.initState();
    _orgId = widget.orgId ?? ref.read(currentOrgProvider)?.orgId;
    for (final c in [_title, _description, _venue, _city, _capacity, _hours]) {
      c.addListener(() => _dirty = true);
    }
    if (widget.isEdit) _load();
  }

  Future<void> _load() async {
    try {
      final d = await ref.read(drivesRepoProvider).detail(widget.driveId!);
      if (!mounted) return;
      setState(() {
        _orgId = d.org.id;
        _title.text = d.title;
        _description.text = d.description ?? '';
        _venue.text = d.venue ?? '';
        _city.text = d.city ?? '';
        _capacity.text = '${d.capacity}';
        _hours.text = Fmt.hours(d.defaultHours);
        _cause = d.cause;
        final s = d.startsAt.toLocal();
        final e = d.endsAt.toLocal();
        _date = DateTime(s.year, s.month, s.day);
        _start = TimeOfDay.fromDateTime(s);
        _end = TimeOfDay.fromDateTime(e);
        _loaded = true;
        _dirty = false;
      });
    } catch (e) {
      if (mounted) setState(() => _formError = SoiError.from(e).message(AppLocalizations.of(context)));
    }
  }

  @override
  void dispose() {
    for (final c in [_title, _description, _venue, _city, _capacity, _hours]) {
      c.dispose();
    }
    super.dispose();
  }

  DateTime get _startsAt => DateTime(_date.year, _date.month, _date.day, _start.hour, _start.minute);
  DateTime get _endsAt {
    final e = DateTime(_date.year, _date.month, _date.day, _end.hour, _end.minute);
    // An end time earlier than the start means it runs past midnight.
    return e.isAfter(_startsAt) ? e : e.add(const Duration(days: 1));
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (d != null) {
      setState(() {
      _date = d;
      _dirty = true;
    });
    }
  }

  Future<void> _pickTime({required bool start}) async {
    final t = await showTimePicker(context: context, initialTime: start ? _start : _end);
    if (t != null) {
      setState(() {
      if (start) {
        _start = t;
      } else {
        _end = t;
      }
      _dirty = true;
    });
    }
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context);
    setState(() => _formError = null);
    if (!_form.currentState!.validate()) return;
    if (_orgId == null) return;
    setState(() => _busy = true);
    try {
      final repo = ref.read(drivesRepoProvider);
      final desc = _description.text.trim().isEmpty ? null : _description.text.trim();
      final venue = _venue.text.trim().isEmpty ? null : _venue.text.trim();
      final city = _city.text.trim().isEmpty ? null : _city.text.trim();
      final cap = int.parse(_capacity.text.trim());
      final hours = num.parse(_hours.text.trim());
      String id;
      if (widget.isEdit) {
        id = widget.driveId!;
        await repo.update(id: id, title: _title.text.trim(), starts: _startsAt, ends: _endsAt,
            description: desc, cause: _cause, venue: venue, city: city, capacity: cap, hours: hours);
      } else {
        id = await repo.create(orgId: _orgId!, title: _title.text.trim(), starts: _startsAt, ends: _endsAt,
            description: desc, cause: _cause, venue: venue, city: city, capacity: cap, hours: hours);
      }
      ref.invalidate(orgDrivesProvider(_orgId!));
      ref.invalidate(driveDetailProvider(id));
      ref.invalidate(discoverControllerProvider);
      ref.invalidate(discoverFacetsProvider);
      if (!mounted) return;
      _dirty = false;
      showSnack(context, widget.isEdit ? l.driveFormSaved : l.driveFormPublished);
      if (widget.isEdit) {
        Navigator.of(context).pop();
      } else {
        DriveRoute(id: id).pushReplacement(context);
      }
    } on SoiError catch (e) {
      if (mounted) setState(() => _formError = e.message(l));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _cancelDrive() async {
    final l = AppLocalizations.of(context);
    final ok = await confirmDialog(context,
        title: l.driveFormCancelConfirmTitle, body: l.driveFormCancelConfirmBody, confirmLabel: l.driveFormCancelDrive, cancelLabel: l.dialogKeepDrive, destructive: true);
    if (!ok) return;
    setState(() => _busy = true);
    try {
      await ref.read(drivesRepoProvider).cancel(widget.driveId!);
      if (_orgId != null) ref.invalidate(orgDrivesProvider(_orgId!));
      ref.invalidate(driveDetailProvider(widget.driveId!));
      ref.invalidate(discoverControllerProvider);
      if (!mounted) return;
      _dirty = false;
      showSnack(context, l.driveFormCancelled);
      Navigator.of(context).pop();
    } catch (e) {
      if (mounted) showErrorSnack(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<bool> _confirmDiscard() async {
    if (!_dirty) return true;
    final l = AppLocalizations.of(context);
    return await confirmDialog(context, title: l.driveFormUnsavedTitle, body: l.driveFormUnsavedBody, confirmLabel: l.driveFormDiscard, cancelLabel: l.dialogKeepEditing, destructive: true);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;
    final orgs = ref.watch(sessionControllerProvider.select((s) => s.coordinated));

    if (widget.isEdit && !_loaded) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(title: Text(l.driveFormEditTitle)),
        body: _formError == null ? const LoadingView() : ErrorView(error: SoiError(_formError!, SoiErrorKind.unknown), onRetry: _load),
      );
    }

    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final discard = await _confirmDiscard();
        if (discard && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(title: Text(widget.isEdit ? l.driveFormEditTitle : l.driveFormNewTitle)),
        body: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: pageInsets(context),
            children: [
              if (!widget.isEdit && orgs.length > 1) ...[
                SectionLabel(l.driveFormOrg),
                Wrap(
                  spacing: Space.sm,
                  children: [
                    for (final m in orgs)
                      SoiFilterChip(label: m.orgName, selected: m.orgId == _orgId, onSelected: (_) => setState(() => _orgId = m.orgId)),
                  ],
                ),
                const SizedBox(height: Space.xl),
              ],
              TextFormField(
                controller: _title,
                enabled: !_busy,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 120,
                validator: (v) => fieldError(context, Validators.driveTitle(v ?? '')),
                decoration: InputDecoration(labelText: l.driveFormTitleLabel, hintText: l.driveFormTitleHint),
              ),
              const SizedBox(height: Space.md),
              SectionLabel(l.driveFormCause),
              Wrap(
                spacing: Space.sm,
                children: [
                  for (final cause in kCauses)
                    SoiFilterChip(
                      label: cause,
                      selected: _cause == cause,
                      onSelected: (sel) => setState(() {
                        _cause = sel ? cause : null;
                        _dirty = true;
                      }),
                    ),
                ],
              ),
              const SizedBox(height: Space.lg),
              TextFormField(
                controller: _description,
                enabled: !_busy,
                textCapitalization: TextCapitalization.sentences,
                maxLines: 5,
                minLines: 3,
                maxLength: 4000,
                decoration: InputDecoration(labelText: l.driveFormDescription, hintText: l.driveFormDescriptionHint, alignLabelWithHint: true),
              ),
              const SizedBox(height: Space.md),
              SoiCard(
                padding: const EdgeInsets.symmetric(horizontal: Space.lg, vertical: Space.xs),
                child: Column(
                  children: [
                    FactRow(icon: Icons.calendar_today_outlined, label: l.driveFormDate, value: Fmt.dayYear(_date), onTap: _busy ? null : _pickDate),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(child: FactRow(icon: Icons.schedule, label: l.driveFormStart, value: _start.format(context), onTap: _busy ? null : () => _pickTime(start: true))),
                        Expanded(child: FactRow(icon: Icons.schedule_outlined, label: l.driveFormEnd, value: _end.format(context), onTap: _busy ? null : () => _pickTime(start: false))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Space.lg),
              TextFormField(
                controller: _venue,
                enabled: !_busy,
                textCapitalization: TextCapitalization.words,
                maxLength: 160,
                decoration: InputDecoration(labelText: l.driveFormVenue, counterText: ''),
              ),
              const SizedBox(height: Space.md),
              TextFormField(
                controller: _city,
                enabled: !_busy,
                textCapitalization: TextCapitalization.words,
                maxLength: 60,
                decoration: InputDecoration(labelText: l.driveFormCity, counterText: ''),
              ),
              const SizedBox(height: Space.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _capacity,
                      enabled: !_busy,
                      keyboardType: TextInputType.number,
                      validator: (v) => fieldError(context, Validators.capacity(v ?? '')),
                      decoration: InputDecoration(labelText: l.driveFormCapacity),
                    ),
                  ),
                  const SizedBox(width: Space.md),
                  Expanded(
                    child: TextFormField(
                      controller: _hours,
                      enabled: !_busy,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) => fieldError(context, Validators.hours(v ?? '')),
                      decoration: InputDecoration(labelText: l.driveFormHours),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Space.sm),
              Text(l.driveFormHoursHelp, style: context.text.bodySmall),
              if (_formError != null) ...[
                const SizedBox(height: Space.md),
                Notice(_formError!, tone: TagTone.danger, icon: Icons.error_outline),
              ],
              const SizedBox(height: Space.xl),
              FilledButton(
                onPressed: _busy ? null : _submit,
                child: _busy
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                    : Text(widget.isEdit ? l.driveFormSave : l.driveFormPublish),
              ),
              if (widget.isEdit) ...[
                const SizedBox(height: Space.xl),
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: c.danger),
                  onPressed: _busy ? null : _cancelDrive,
                  icon: const Icon(Icons.cancel_outlined),
                  label: Text(l.driveFormCancelDrive),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
