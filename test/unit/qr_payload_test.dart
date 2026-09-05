import 'package:flutter_test/flutter_test.dart';
import 'package:soi/core/utils/qr_payload.dart';

void main() {
  const drive = '0f7a2b9e-4c5d-4e6f-8a9b-0c1d2e3f4a5b';
  const code = '11111111-2222-3333-4444-555555555555';

  group('QrPayload.parse', () {
    test('accepts a check-in payload with exactly four parts', () {
      final p = QrPayload.parse('soi:checkin:$drive:$code');
      expect(p, isA<CheckInPayload>());
      final c = p! as CheckInPayload;
      expect(c.driveId, drive);
      expect(c.code, code);
    });

    test('accepts a pledge payload and upper-cases the code', () {
      final p = QrPayload.parse('soi:pledge:ab12cd');
      expect(p, isA<PledgePayload>());
      expect((p! as PledgePayload).shareCode, 'AB12CD');
    });

    test('rejects other prefixes, wrong arity and malformed ids', () {
      expect(QrPayload.parse('https://example.com'), isNull);
      expect(QrPayload.parse('soi:checkin:$drive'), isNull);
      expect(QrPayload.parse('soi:checkin:$drive:$code:extra'), isNull);
      expect(QrPayload.parse('soi:checkin:not-a-uuid:$code'), isNull);
      expect(QrPayload.parse('soi:pledge:ZZZZZZ'), isNull);
      expect(QrPayload.parse(''), isNull);
    });

    test('round-trips through the generators', () {
      expect(QrPayload.parse(QrPayload.checkIn(drive, code)), isA<CheckInPayload>());
      expect(QrPayload.parse(QrPayload.pledge('A1B2C3')), isA<PledgePayload>());
    });
  });
}
