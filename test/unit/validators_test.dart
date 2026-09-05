import 'package:flutter_test/flutter_test.dart';
import 'package:soi/core/utils/format.dart';
import 'package:soi/core/utils/validators.dart';

void main() {
  group('Validators mirror the server bounds', () {
    test('email', () {
      expect(Validators.email(''), 'REQUIRED');
      expect(Validators.email('not-an-email'), 'BAD_EMAIL');
      expect(Validators.email('a@b.c'), 'BAD_EMAIL');
      expect(Validators.email('priya@example.in'), isNull);
    });

    test('person name', () {
      expect(Validators.personName('A'), 'NAME_TOO_SHORT');
      expect(Validators.personName('a' * 81), 'NAME_TOO_LONG');
      expect(Validators.personName('x@y.zz'), 'NAME_LOOKS_LIKE_EMAIL');
      expect(Validators.personName('123'), 'NAME_TOO_SHORT');
      expect(Validators.personName('प्रिया शर्मा'), isNull);
      expect(Validators.personName('Priya Sharma'), isNull);
    });

    test('phone normalisation and rule', () {
      expect(Validators.normalisePhone('+91 98765 43210'), '9876543210');
      expect(Validators.normalisePhone('09876543210'), '9876543210');
      expect(Validators.phone('12345'), 'BAD_PHONE');
      expect(Validators.phone('5876543210'), 'BAD_PHONE');
      expect(Validators.phone('+91 98765 43210'), isNull);
      expect(Validators.phone(''), isNull);
      expect(Validators.phone('', required: true), 'REQUIRED');
    });

    test('roll numbers', () {
      expect(Validators.rollNo('12/A-3'), isNull);
      expect(Validators.rollNo('bad roll!'), 'BAD_ROLL');
      expect(Validators.rollNo('1234567890123'), 'BAD_ROLL');
    });

    test('drive and pledge bounds', () {
      expect(Validators.driveTitle('abc'), 'TITLE_TOO_SHORT');
      expect(Validators.driveTitle('a' * 121), 'TITLE_TOO_LONG');
      expect(Validators.pledgeBody('short'), 'BODY_TOO_SHORT');
      expect(Validators.pledgeBody('a' * 2001), 'BODY_TOO_LONG');
      expect(Validators.capacity('0'), 'BAD_CAPACITY');
      expect(Validators.capacity('5001'), 'BAD_CAPACITY');
      expect(Validators.capacity('40'), isNull);
      expect(Validators.hours('13'), 'BAD_HOURS');
      expect(Validators.hours('0'), 'BAD_HOURS');
      expect(Validators.hours('2.5'), isNull);
    });

    test('codes', () {
      expect(Validators.claimCode('a1b2c3d4'), isNull);
      expect(Validators.claimCode('A1B2C3'), 'BAD_CODE');
      expect(Validators.shareCode('ab12cd'), isNull);
      expect(Validators.certificateCode('soi-ab12-cd34'), isNull);
      expect(Validators.certificateCode('SOI-AB12'), 'BAD_CODE');
      expect(Validators.otp('123456'), isNull);
      expect(Validators.otp('12'), 'BAD_CODE');
    });
  });

  group('Fmt', () {
    test('relative day', () {
      final now = DateTime(2026, 9, 5, 14);
      expect(Fmt.relativeDay(DateTime(2026, 9, 5, 9), now: now), 'Today');
      expect(Fmt.relativeDay(DateTime(2026, 9, 6, 23), now: now), 'Tomorrow');
      expect(Fmt.relativeDay(DateTime(2026, 9, 8), now: now), 'In 3 days');
      expect(Fmt.relativeDay(DateTime(2026, 9, 20), now: now), isNull);
      expect(Fmt.relativeDay(DateTime(2026, 9, 1), now: now), isNull);
    });

    test('hours drop trailing zeros', () {
      expect(Fmt.hours(4), '4');
      expect(Fmt.hours(2.5), '2.5');
      expect(Fmt.hours(4.0), '4');
    });
  });
}
