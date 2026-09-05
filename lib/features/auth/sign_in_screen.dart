import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/errors/error_messages.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/core/utils/validators.dart';
import 'package:soi/data/repositories.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/ui/widgets.dart';

enum _Step { email, code, password }

/// Email one-time code, with a password path kept for the store-review
/// account. On success the router's redirect takes over (name → intent →
/// the original `from` target), so this screen never navigates itself.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key, this.from});
  final String? from;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _email = TextEditingController();
  final _code = TextEditingController();
  final _password = TextEditingController();
  final _emailFocus = FocusNode();
  final _codeFocus = FocusNode();

  _Step _step = _Step.email;
  bool _busy = false;
  String? _emailError;
  String? _codeError;
  String? _formError;
  int _resendIn = 0;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _email.dispose();
    _code.dispose();
    _password.dispose();
    _emailFocus.dispose();
    _codeFocus.dispose();
    super.dispose();
  }

  String get _cleanEmail => _email.text.trim().toLowerCase();

  void _startResendTimer() {
    _timer?.cancel();
    setState(() => _resendIn = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return t.cancel();
      setState(() => _resendIn--);
      if (_resendIn <= 0) t.cancel();
    });
  }

  Future<void> _sendCode() async {
    final err = Validators.email(_email.text);
    setState(() {
      _emailError = err;
      _formError = null;
    });
    if (err != null) return;
    setState(() => _busy = true);
    try {
      await ref.read(authRepoProvider).sendCode(_cleanEmail);
      if (!mounted) return;
      setState(() => _step = _Step.code);
      _startResendTimer();
      _codeFocus.requestFocus();
    } on SoiError catch (e) {
      if (mounted) setState(() => _formError = e.message(AppLocalizations.of(context)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _verify() async {
    final err = Validators.otp(_code.text);
    setState(() {
      _codeError = err;
      _formError = null;
    });
    if (err != null) return;
    setState(() => _busy = true);
    try {
      await ref.read(authRepoProvider).verifyCode(_cleanEmail, _code.text.trim());
      // The session listener + router redirect handle what comes next.
    } on SoiError catch (e) {
      if (mounted) setState(() => _formError = e.message(AppLocalizations.of(context)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signInWithPassword() async {
    final err = Validators.email(_email.text);
    setState(() {
      _emailError = err;
      _formError = null;
    });
    if (err != null) return;
    if (_password.text.isEmpty) return setState(() => _formError = fieldError(context, 'REQUIRED'));
    setState(() => _busy = true);
    try {
      await ref.read(authRepoProvider).signInWithPassword(_cleanEmail, _password.text);
    } on SoiError catch (e) {
      if (mounted) setState(() => _formError = e.message(AppLocalizations.of(context)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final c = context.soi;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: pagePadding,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l.brandShort,
                    style: context.text.labelLarge!.copyWith(color: c.green, letterSpacing: 3)),
                const SizedBox(height: Space.sm),
                Text(
                  _step == _Step.code ? l.signInCodeTitle : l.signInTitle,
                  style: context.text.headlineMedium,
                ),
                const SizedBox(height: Space.sm),
                Text(
                  switch (_step) {
                    _Step.email => l.signInLead,
                    _Step.code => l.signInCodeLead(_cleanEmail),
                    _Step.password => l.signInPasswordLead,
                  },
                  style: context.text.bodyLarge,
                ),
                const SizedBox(height: Space.xxl),
                if (_step != _Step.code) ...[
                  TextField(
                    controller: _email,
                    focusNode: _emailFocus,
                    autofocus: true,
                    enabled: !_busy,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autofillHints: const [AutofillHints.email],
                    textInputAction: _step == _Step.email ? TextInputAction.send : TextInputAction.next,
                    onSubmitted: (_) => _step == _Step.email ? _sendCode() : null,
                    onChanged: (_) => _emailError == null ? null : setState(() => _emailError = null),
                    decoration: InputDecoration(
                      labelText: l.signInEmailLabel,
                      errorText: fieldError(context, _emailError),
                      prefixIcon: const Icon(Icons.alternate_email),
                    ),
                  ),
                ],
                if (_step == _Step.password) ...[
                  const SizedBox(height: Space.md),
                  TextField(
                    controller: _password,
                    enabled: !_busy,
                    obscureText: true,
                    autofillHints: const [AutofillHints.password],
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _signInWithPassword(),
                    decoration: InputDecoration(labelText: l.signInPasswordLabel, prefixIcon: const Icon(Icons.lock_outline)),
                  ),
                ],
                if (_step == _Step.code) ...[
                  TextField(
                    controller: _code,
                    focusNode: _codeFocus,
                    enabled: !_busy,
                    keyboardType: TextInputType.number,
                    autofillHints: const [AutofillHints.oneTimeCode],
                    textInputAction: TextInputAction.done,
                    maxLength: 10,
                    style: context.text.headlineSmall!.copyWith(letterSpacing: 6),
                    onSubmitted: (_) => _verify(),
                    onChanged: (v) {
                      if (_codeError != null) setState(() => _codeError = null);
                      if (v.trim().length >= 6 && !_busy) _verify();
                    },
                    decoration: InputDecoration(
                      labelText: l.signInCodeLabel,
                      counterText: '',
                      errorText: fieldError(context, _codeError),
                    ),
                  ),
                  const SizedBox(height: Space.sm),
                  Text(l.signInSpamHint, style: context.text.bodySmall),
                ],
                if (_formError != null) ...[
                  const SizedBox(height: Space.md),
                  Notice(_formError!, tone: TagTone.danger, icon: Icons.error_outline),
                ],
                const SizedBox(height: Space.xxl),
                FilledButton(
                  onPressed: _busy
                      ? null
                      : switch (_step) {
                          _Step.email => _sendCode,
                          _Step.code => _verify,
                          _Step.password => _signInWithPassword,
                        },
                  child: _busy
                      ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                      : Text(switch (_step) {
                          _Step.email => l.signInSendCode,
                          _Step.code => l.signInVerify,
                          _Step.password => l.commonSignIn,
                        }),
                ),
                const SizedBox(height: Space.md),
                if (_step == _Step.code) ...[
                  TextButton(
                    onPressed: _resendIn > 0 || _busy ? null : _sendCode,
                    child: Text(_resendIn > 0 ? l.signInResendIn(_resendIn) : l.signInResend),
                  ),
                  TextButton(
                    onPressed: _busy
                        ? null
                        : () => setState(() {
                              _step = _Step.email;
                              _code.clear();
                              _formError = null;
                            }),
                    child: Text(l.signInDifferentEmail),
                  ),
                ] else
                  TextButton(
                    onPressed: _busy
                        ? null
                        : () => setState(() {
                              _step = _step == _Step.password ? _Step.email : _Step.password;
                              _formError = null;
                            }),
                    child: Text(_step == _Step.password ? l.signInUseCode : l.signInUsePassword),
                  ),
                const SizedBox(height: Space.lg),
                Text(l.signInLegal, style: context.text.bodySmall, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
