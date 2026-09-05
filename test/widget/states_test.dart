import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soi/core/errors/soi_error.dart';
import 'package:soi/core/theme/theme.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/ui/states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Widget host(Widget child, {double scale = 1}) => MaterialApp(
      theme: SoiTheme.light(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MediaQuery(
        data: MediaQueryData(size: const Size(360, 800), textScaler: TextScaler.linear(scale)),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('an offline error is never rendered as an empty state', (tester) async {
    var retried = false;
    await tester.pumpWidget(host(ErrorView(error: const SocketException('x'), onRetry: () => retried = true)));
    expect(find.text("You're offline"), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    await tester.tap(find.text('Try again'));
    expect(retried, isTrue);
  });

  testWidgets('a rule error shows the mapped sentence, not raw text', (tester) async {
    await tester.pumpWidget(host(ErrorView(error: const PostgrestException(message: 'P0001: DRIVE_FULL'))));
    expect(find.text('This drive is full.'), findsOneWidget);
    expect(find.textContaining('P0001'), findsNothing);
  });

  testWidgets('a not-found error is distinct from a generic failure', (tester) async {
    await tester.pumpWidget(host(const ErrorView(error: SoiError('CERTIFICATE_NOT_FOUND', SoiErrorKind.notFound))));
    expect(find.text('Not found'), findsOneWidget);
  });

  testWidgets('empty and signed-out states render their actions', (tester) async {
    await tester.pumpWidget(host(const EmptyView(title: 'Nothing', body: 'Body')));
    expect(find.text('Nothing'), findsOneWidget);
    await tester.pumpWidget(host(SignedOutView(onSignIn: () {})));
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('state views survive 1.3x text scale without overflow', (tester) async {
    await tester.pumpWidget(host(ErrorView(error: const SocketException('x'), onRetry: () {}), scale: 1.3));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(host(EmptyView(title: 'A long title that wraps onto more than one line', body: 'B' * 300), scale: 1.3));
    expect(tester.takeException(), isNull);
  });
}
