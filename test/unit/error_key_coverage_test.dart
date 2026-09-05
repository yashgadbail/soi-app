import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every error key a server function can raise must have a sentence in the
/// app. Parses `raise exception 'KEY'` across db/migrations and checks each
/// key appears as a `case 'KEY':` in the error-message mapper.
void main() {
  test('every server error key has a user-facing message', () {
    final keys = <String>{};
    final raise = RegExp(r"raise exception '([A-Z][A-Z0-9_]+)'");
    for (final f in Directory('db/migrations').listSync().whereType<File>()) {
      if (!f.path.endsWith('.sql')) continue;
      for (final m in raise.allMatches(f.readAsStringSync())) {
        keys.add(m.group(1)!);
      }
    }
    expect(keys, isNotEmpty, reason: 'no keys found; is the test running from the repo root?');

    final mapper = File('lib/core/errors/error_messages.dart').readAsStringSync();
    final mapped = RegExp(r"case '([A-Z][A-Z0-9_]+)':").allMatches(mapper).map((m) => m.group(1)!).toSet();

    final missing = keys.difference(mapped).toList()..sort();
    expect(missing, isEmpty, reason: 'keys raised by SQL but not mapped: $missing');
  });
}
