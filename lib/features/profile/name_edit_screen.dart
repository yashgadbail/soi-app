import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/ui/widgets.dart';

class NameEditScreen extends ConsumerStatefulWidget {
  const NameEditScreen({super.key});

  @override
  ConsumerState<NameEditScreen> createState() => _NameEditScreenState();
}

class _NameEditScreenState extends ConsumerState<NameEditScreen> {
  late final _name = TextEditingController(text: ref.read(sessionControllerProvider).profile?.fullName ?? '');
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final err = Validators.personName(_name.text);
    setState(() => _error = err);
    if (err != null) return;
    setState(() => _busy = true);
    try {
      final name = _name.text.trim();
      final updated = await ref.read(accountRepoProvider).setMyName(name);
      ref.read(sessionControllerProvider.notifier).setProfileName(name);
      if (!mounted) return;
      showSnack(context, updated == 0 ? l.profileNameSaved : l.profileNameUpdatedCerts(updated));
      Navigator.of(context).pop();
    } on SoiError catch (e) {
      if (mounted) setState(() => _error = e.key);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.profileEditName)),
      body: ListView(
        padding: pagePadding,
        children: [
          Text(l.onboardNameLead, style: context.text.bodyMedium),
          const SizedBox(height: Space.xl),
          TextField(
            controller: _name,
            autofocus: true,
            enabled: !_busy,
            textCapitalization: TextCapitalization.words,
            maxLength: 80,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _save(),
            onChanged: (_) => _error == null ? null : setState(() => _error = null),
            decoration: InputDecoration(
              labelText: l.onboardNameLabel,
              errorText: _error == null ? null : errorMessage(l, _error!),
            ),
          ),
          const SizedBox(height: Space.lg),
          FilledButton(onPressed: _busy ? null : _save, child: Text(l.commonSave)),
        ],
      ),
    );
  }
}
