import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/data/session.dart';
import 'package:soi/features/passport/passport_screen.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/routes.dart';
import 'package:soi/ui/widgets.dart';

/// Attach school-held records to this account with the teacher's claim code.
class ClaimScreen extends ConsumerStatefulWidget {
  const ClaimScreen({super.key});

  @override
  ConsumerState<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends ConsumerState<ClaimScreen> {
  final _code = TextEditingController();
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l = AppLocalizations.of(context);
    final err = Validators.claimCode(_code.text);
    setState(() => _error = err);
    if (err != null) return;
    setState(() => _busy = true);
    try {
      final r = await ref.read(accountRepoProvider).claim(_code.text.trim().toUpperCase());
      ref.invalidate(passportProvider);
      await ref.read(sessionControllerProvider.notifier).refresh();
      if (!mounted) return;
      showSnack(context, l.claimSuccess(r.recordsClaimed, r.studentName));
      const PassportRoute().go(context);
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
      appBar: AppBar(title: Text(l.claimTitle)),
      body: ListView(
        padding: pagePadding,
        children: [
          Text(l.claimLead, style: context.text.bodyLarge),
          const SizedBox(height: Space.xl),
          TextField(
            controller: _code,
            autofocus: true,
            enabled: !_busy,
            textCapitalization: TextCapitalization.characters,
            autocorrect: false,
            maxLength: 8,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9A-Fa-f]'))],
            style: context.text.headlineSmall!.copyWith(letterSpacing: 4),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            onChanged: (_) => _error == null ? null : setState(() => _error = null),
            decoration: InputDecoration(
              labelText: l.claimLabel,
              hintText: 'A1B2C3D4',
              counterText: '',
              errorText: _error == null ? null : errorMessage(l, _error!),
            ),
          ),
          const SizedBox(height: Space.lg),
          FilledButton(onPressed: _busy ? null : _submit, child: Text(l.claimSubmit)),
        ],
      ),
    );
  }
}
