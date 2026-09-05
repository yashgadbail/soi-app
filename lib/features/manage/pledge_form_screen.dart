import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/models.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/features/manage/manage_providers.dart';
import 'package:soi/features/pledge/pledge_screen.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/states.dart';
import 'package:soi/ui/widgets.dart';

/// Create or edit a pledge. Once signed, the wording is locked (the title
/// can still change); the form says so instead of failing on save.
class PledgeFormScreen extends ConsumerStatefulWidget {
  const PledgeFormScreen({super.key, this.orgId, this.shareCode});
  final String? orgId;
  final String? shareCode;
  bool get isEdit => shareCode != null;

  @override
  ConsumerState<PledgeFormScreen> createState() => _PledgeFormScreenState();
}

class _PledgeFormScreenState extends ConsumerState<PledgeFormScreen> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _campaign = TextEditingController();
  final _body = TextEditingController();
  PledgeDetail? _existing;
  bool _busy = false;
  bool _dirty = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    for (final c in [_title, _campaign, _body]) {
      c.addListener(() => setState(() => _dirty = true));
    }
    if (widget.isEdit) _load();
  }

  Future<void> _load() async {
    try {
      final p = await ref.read(pledgesRepoProvider).detail(widget.shareCode!);
      if (!mounted) return;
      setState(() {
        _existing = p;
        _title.text = p.title;
        _campaign.text = p.campaign ?? '';
        _body.text = p.body;
        _dirty = false;
      });
    } catch (e) {
      if (mounted) setState(() => _error = SoiError.from(e).message(AppLocalizations.of(context)));
    }
  }

  @override
  void dispose() {
    for (final c in [_title, _campaign, _body]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context);
    setState(() => _error = null);
    if (!_form.currentState!.validate()) return;
    setState(() => _busy = true);
    final campaign = _campaign.text.trim().isEmpty ? null : _campaign.text.trim();
    try {
      final repo = ref.read(pledgesRepoProvider);
      if (widget.isEdit) {
        await repo.update(id: _existing!.id, title: _title.text.trim(), body: _body.text.trim(), campaign: campaign);
        ref.invalidate(orgPledgesProvider(_existing!.orgId));
        ref.invalidate(pledgeDetailProvider(_existing!.shareCode));
        if (!mounted) return;
        _dirty = false;
        showSnack(context, l.pledgeFormSaved);
        Navigator.of(context).pop();
      } else {
        final r = await repo.create(orgId: widget.orgId!, title: _title.text.trim(), body: _body.text.trim(), campaign: campaign);
        ref.invalidate(orgPledgesProvider(widget.orgId!));
        if (!mounted) return;
        _dirty = false;
        showSnack(context, l.pledgeFormPublished);
        PledgeRoute(code: r.shareCode).pushReplacement(context);
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
    final locked = (_existing?.signatures ?? 0) > 0;

    if (widget.isEdit && _existing == null) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(title: Text(l.pledgeFormEditTitle)),
        body: _error == null ? const LoadingView() : ErrorView(error: SoiError(_error!, SoiErrorKind.unknown), onRetry: _load),
      );
    }

    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final ok = await confirmDialog(context, title: l.driveFormUnsavedTitle, body: l.driveFormUnsavedBody, confirmLabel: l.driveFormDiscard, cancelLabel: l.dialogKeepEditing, destructive: true);
        if (ok && context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: GlassAppBar(title: Text(widget.isEdit ? l.pledgeFormEditTitle : l.pledgeFormNewTitle)),
        body: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: PageListView(
            children: [
              TextFormField(
                controller: _title,
                enabled: !_busy,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 120,
                validator: (v) => fieldError(context, Validators.pledgeTitle(v ?? '')),
                decoration: InputDecoration(labelText: l.pledgeFormTitleLabel),
              ),
              const SizedBox(height: Space.md),
              TextFormField(
                controller: _campaign,
                enabled: !_busy,
                textCapitalization: TextCapitalization.words,
                maxLength: 60,
                validator: (v) => fieldError(context, Validators.campaign(v ?? '')),
                decoration: InputDecoration(labelText: '${l.pledgeFormCampaign} (${l.commonOptional})', hintText: l.pledgeFormCampaignHint),
              ),
              const SizedBox(height: Space.md),
              if (locked) ...[
                Notice(l.pledgeFormLocked, tone: TagTone.saffron, icon: Icons.lock_outline),
                const SizedBox(height: Space.md),
              ],
              TextFormField(
                controller: _body,
                enabled: !_busy && !locked,
                textCapitalization: TextCapitalization.sentences,
                minLines: 6,
                maxLines: 12,
                maxLength: 2000,
                validator: (v) => fieldError(context, Validators.pledgeBody(v ?? '')),
                decoration: InputDecoration(labelText: l.pledgeFormBody, hintText: l.pledgeFormBodyHint, alignLabelWithHint: true),
              ),
              const SizedBox(height: Space.sm),
              Text(l.pledgeFormNotHours, style: context.text.bodySmall),
              if (_error != null) ...[
                const SizedBox(height: Space.md),
                Notice(_error!, tone: TagTone.danger, icon: Icons.error_outline),
              ],
              const SizedBox(height: Space.xl),
              FilledButton(
                onPressed: _busy ? null : _submit,
                child: Text(widget.isEdit ? l.commonSave : l.pledgeFormPublish),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
