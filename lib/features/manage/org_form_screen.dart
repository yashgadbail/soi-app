import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/manage/manage_providers.dart';
import 'package:soi/features/org/org_screen.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

/// Register a new organisation (the caller becomes owner) or edit one.
class OrgFormScreen extends ConsumerStatefulWidget {
  const OrgFormScreen({super.key, this.orgId});
  final String? orgId;
  bool get isEdit => orgId != null;

  @override
  ConsumerState<OrgFormScreen> createState() => _OrgFormScreenState();
}

class _OrgFormScreenState extends ConsumerState<OrgFormScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _city = TextEditingController();
  final _about = TextEditingController();
  String _type = 'ngo';
  bool _busy = false;
  bool _loaded = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) _load();
  }

  Future<void> _load() async {
    try {
      final o = await ref.read(orgsRepoProvider).publicProfile(widget.orgId!);
      if (!mounted) return;
      setState(() {
        _name.text = o.name;
        _city.text = o.city ?? '';
        _about.text = o.about ?? '';
        _type = o.type;
        _loaded = true;
      });
    } catch (e) {
      if (mounted) setState(() => _error = SoiError.from(e).message(AppLocalizations.of(context)));
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _city.dispose();
    _about.dispose();
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
      if (widget.isEdit) {
        await repo.update(orgId: widget.orgId!, name: _name.text.trim(), about: nz(_about.text), city: nz(_city.text));
        await ref.read(sessionControllerProvider.notifier).refreshMemberships();
        ref.invalidate(orgPublicProvider(widget.orgId!));
        if (!mounted) return;
        showSnack(context, l.orgFormSaved);
        Navigator.of(context).pop();
      } else {
        final id = await repo.create(name: _name.text.trim(), type: _type, about: nz(_about.text), city: nz(_city.text));
        await ref.read(sessionControllerProvider.notifier).refreshMemberships();
        ref.read(selectedOrgProvider.notifier).choose(id);
        if (!mounted) return;
        showSnack(context, l.orgFormRegistered);
        const ManageRoute().go(context);
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

    if (widget.isEdit && !_loaded) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(title: Text(l.orgFormEditTitle)),
        body: _error == null ? const LoadingView() : ErrorView(error: SoiError(_error!, SoiErrorKind.unknown), onRetry: _load),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: Text(widget.isEdit ? l.orgFormEditTitle : l.orgFormNewTitle)),
      body: Form(
        key: _form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: PageListView(
          children: [
            if (!widget.isEdit) ...[
              SectionLabel(l.orgFormType),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(value: 'ngo', label: Text(l.orgTypeNgo)),
                  ButtonSegment(value: 'school', label: Text(l.orgTypeSchool)),
                  ButtonSegment(value: 'corporate', label: Text(l.orgTypeCorporate)),
                ],
                selected: {_type},
                onSelectionChanged: (s) => setState(() => _type = s.first),
              ),
              const SizedBox(height: Space.xl),
            ],
            TextFormField(
              controller: _name,
              autofocus: !widget.isEdit,
              enabled: !_busy,
              textCapitalization: TextCapitalization.words,
              maxLength: 80,
              validator: (v) => fieldError(context, Validators.orgName(v ?? '')),
              decoration: InputDecoration(labelText: l.orgFormName),
            ),
            const SizedBox(height: Space.md),
            TextFormField(
              controller: _city,
              enabled: !_busy,
              textCapitalization: TextCapitalization.words,
              maxLength: 60,
              decoration: InputDecoration(labelText: l.orgFormCity, counterText: ''),
            ),
            const SizedBox(height: Space.md),
            TextFormField(
              controller: _about,
              enabled: !_busy,
              textCapitalization: TextCapitalization.sentences,
              minLines: 3,
              maxLines: 6,
              maxLength: 1000,
              decoration: InputDecoration(labelText: '${l.orgFormAbout} (${l.commonOptional})', hintText: l.orgFormAboutHint, alignLabelWithHint: true),
            ),
            const SizedBox(height: Space.md),
            Notice(l.orgFormVerifyNote, tone: TagTone.neutral, icon: Icons.verified_outlined),
            if (_error != null) ...[
              const SizedBox(height: Space.md),
              Notice(_error!, tone: TagTone.danger, icon: Icons.error_outline),
            ],
            const SizedBox(height: Space.xl),
            FilledButton(onPressed: _busy ? null : _submit, child: Text(widget.isEdit ? l.commonSave : l.orgFormRegister)),
          ],
        ),
      ),
    );
  }
}
