import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group('SoiError.from', () {
    test('extracts a bare key from a Postgrest message', () {
      final e = SoiError.from(const PostgrestException(message: 'DRIVE_FULL'));
      expect(e.key, 'DRIVE_FULL');
      expect(e.kind, SoiErrorKind.rule);
    });

    test('extracts a key embedded in a longer message', () {
      final e = SoiError.from(const PostgrestException(message: 'P0001: NOT_AUTHORISED (context)'));
      expect(e.key, 'NOT_AUTHORISED');
      expect(e.kind, SoiErrorKind.notAuthorised);
    });

    test('classifies not-found keys', () {
      expect(SoiError.from(const PostgrestException(message: 'PLEDGE_NOT_FOUND')).isNotFound, isTrue);
      expect(SoiError.from(const PostgrestException(message: 'INVALID_CLAIM_CODE')).isNotFound, isTrue);
    });

    test('permission denied from an anonymous call reads as not signed in', () {
      final e = SoiError.from(const PostgrestException(message: 'permission denied for function my_passport'));
      expect(e.kind, SoiErrorKind.notSignedIn);
    });

    test('socket and timeout failures are offline', () {
      expect(SoiError.from(const SocketException('no route')).isOffline, isTrue);
      expect(SoiError.from(Exception('ClientException: Failed host lookup')).isOffline, isTrue);
    });

    test('auth failures map to a stable key', () {
      expect(SoiError.from(const AuthException('Invalid login credentials')).key, 'BAD_CREDENTIALS');
      expect(SoiError.from(const AuthException('Token has expired or is invalid')).key, 'BAD_CREDENTIALS');
      expect(SoiError.from(const AuthException('rate limit', statusCode: '429')).key, 'TOO_MANY_ATTEMPTS');
    });

    test('unknown errors never leak raw text as the key', () {
      final e = SoiError.from(StateError('something odd with lowercase words'));
      expect(e.key, 'UNKNOWN');
      expect(e.kind, SoiErrorKind.unknown);
    });

    test('an existing SoiError passes through unchanged', () {
      const original = SoiError('X_Y', SoiErrorKind.rule);
      expect(identical(SoiError.from(original), original), isTrue);
    });
  });
}
