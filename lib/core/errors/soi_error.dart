import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Broad classification used by screens to choose a state widget.
enum SoiErrorKind {
  /// No network, DNS failure, timeout. Show "You're offline" + retry.
  offline,

  /// The server said NOT_SIGNED_IN or the role was denied. Show sign-in.
  notSignedIn,

  /// The caller lacks the required organisation role.
  notAuthorised,

  /// The thing does not exist (or is not visible to this caller).
  notFound,

  /// A validation or business-rule key raised by a server function.
  rule,

  /// Anything else: bug, outage, unexpected shape.
  unknown,
}

/// One error type for the whole app.
///
/// Server functions raise bare, stable keys (`DRIVE_FULL`, `NOT_AUTHORISED`,
/// …). [SoiError.from] extracts the key from whatever the SDK threw so that
/// screens only ever switch on [key] / [kind] and the l10n layer turns the
/// key into a sentence. Nothing user-facing is ever built from [raw].
class SoiError implements Exception {
  const SoiError(this.key, this.kind, {this.raw});

  /// UPPER_SNAKE key from the server, or a synthetic one (`OFFLINE`,
  /// `UNKNOWN`, `NOT_FOUND`).
  final String key;
  final SoiErrorKind kind;

  /// The original message, for logs only.
  final String? raw;

  static final _keyPattern = RegExp(r'\b([A-Z][A-Z0-9]*(?:_[A-Z0-9]+)+)\b');

  static const _notFoundKeys = {
    'DRIVE_NOT_FOUND',
    'ORG_NOT_FOUND',
    'PLEDGE_NOT_FOUND',
    'CERTIFICATE_NOT_FOUND',
    'STUDENT_NOT_FOUND',
    'MEMBER_NOT_FOUND',
    'INVITE_NOT_FOUND',
    'INVALID_CLAIM_CODE',
  };

  /// Normalises anything thrown by the data layer.
  factory SoiError.from(Object error) {
    if (error is SoiError) return error;

    if (error is SocketException ||
        error is TimeoutException ||
        error is HttpException ||
        error is HandshakeException) {
      return SoiError('OFFLINE', SoiErrorKind.offline, raw: '$error');
    }

    if (error is AuthException) {
      final msg = error.message;
      if (error.statusCode == '429') {
        return SoiError('TOO_MANY_ATTEMPTS', SoiErrorKind.rule, raw: msg);
      }
      if (msg.toLowerCase().contains('invalid login credentials') ||
          msg.toLowerCase().contains('token has expired') ||
          msg.toLowerCase().contains('otp')) {
        return SoiError('BAD_CREDENTIALS', SoiErrorKind.rule, raw: msg);
      }
      if (msg.toLowerCase().contains('network') ||
          msg.toLowerCase().contains('socket')) {
        return SoiError('OFFLINE', SoiErrorKind.offline, raw: msg);
      }
      return SoiError('AUTH_FAILED', SoiErrorKind.unknown, raw: msg);
    }

    if (error is PostgrestException) {
      final msg = error.message;
      final key = _keyPattern.firstMatch(msg)?.group(1);
      if (key != null) return SoiError(key, _kindFor(key), raw: msg);
      if (msg.contains('permission denied')) {
        return SoiError('NOT_SIGNED_IN', SoiErrorKind.notSignedIn, raw: msg);
      }
      if (msg.contains('row-level security')) {
        return SoiError('NOT_AUTHORISED', SoiErrorKind.notAuthorised, raw: msg);
      }
      return SoiError('SERVER_ERROR', SoiErrorKind.unknown, raw: msg);
    }

    final text = '$error';
    if (text.contains('SocketException') ||
        text.contains('Failed host lookup') ||
        text.contains('Connection refused') ||
        text.contains('ClientException')) {
      return SoiError('OFFLINE', SoiErrorKind.offline, raw: text);
    }
    final key = _keyPattern.firstMatch(text)?.group(1);
    if (key != null && key != 'UNKNOWN') {
      return SoiError(key, _kindFor(key), raw: text);
    }
    return SoiError('UNKNOWN', SoiErrorKind.unknown, raw: text);
  }

  static SoiErrorKind _kindFor(String key) {
    if (key == 'NOT_SIGNED_IN') return SoiErrorKind.notSignedIn;
    if (key == 'NOT_AUTHORISED') return SoiErrorKind.notAuthorised;
    if (_notFoundKeys.contains(key)) return SoiErrorKind.notFound;
    return SoiErrorKind.rule;
  }

  bool get isOffline => kind == SoiErrorKind.offline;
  bool get isNotFound => kind == SoiErrorKind.notFound;

  @override
  String toString() => 'SoiError($key${raw == null ? '' : ': $raw'})';
}

/// Wraps a data-layer call so callers always receive a [SoiError].
Future<T> guard<T>(Future<T> Function() run) async {
  try {
    return await run();
  } catch (e) {
    throw SoiError.from(e);
  }
}
