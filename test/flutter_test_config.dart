import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Loads the bundled Inter faces so widget and golden tests render real
/// glyphs instead of the Ahem placeholder boxes. Goldens are captured on
/// this project's Windows toolchain; regenerate with
/// `flutter test --update-goldens` when the design changes on purpose.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final loader = FontLoader('Inter');
  for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold', 'ExtraBold']) {
    final file = File('assets/fonts/Inter-$weight.ttf');
    if (file.existsSync()) {
      loader.addFont(Future.value(ByteData.view(Uint8List.fromList(file.readAsBytesSync()).buffer)));
    }
  }
  await loader.load();
  await testMain();
}
