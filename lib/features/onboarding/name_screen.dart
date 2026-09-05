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

/// First-run step 1: the name printed on certificates. Required.
class OnboardingNameScreen extends ConsumerStatefulWidget {
  const OnboardingNameScreen({super.key, this.from});
  final String? from;

  @override
  ConsumerState<OnboardingNameScreen> createState() => _OnboardingNameScreenState();
}

class _OnboardingNameScreenState extends ConsumerState<OnboardingNameScreen> {
  final _name = TextEditingController();
  String? _error;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _name.text = ref.read(sessionControllerProvider).profile?.fullName ?? '';
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final err = Validators.personName(_name.text);
    setState(() => _error = err);
    if (err != null) return;
    setState(() => _busy = true);
    try {
      await ref.read(accountRepoProvider).setMyName(_name.text.trim());
      ref.read(sessionControllerProvider.notifier).setProfileName(_name.text.trim());
      // The router redirect moves on to the intent step (or `from`).
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: pagePadding.copyWith(top: Space.xxxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l.onboardNameTitle, style: context.text.headlineMedium),
              const SizedBox(height: Space.sm),
              Text(l.onboardNameLead, style: context.text.bodyLarge),
              const SizedBox(height: Space.xxl),
              TextField(
                controller: _name,
                autofocus: true,
                enabled: !_busy,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                maxLength: 80,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _save(),
                onChanged: (_) => _error == null ? null : setState(() => _error = null),
                decoration: InputDecoration(
                  labelText: l.onboardNameLabel,
                  errorText: _error == null ? null : errorMessage(l, _error!),
                ),
              ),
              const SizedBox(height: Space.xl),
              FilledButton(onPressed: _busy ? null : _save, child: Text(l.commonContinue)),
            ],
          ),
        ),
      ),
    );
  }
}
