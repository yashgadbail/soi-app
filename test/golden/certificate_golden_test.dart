import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:soi/core/theme/theme.dart';
import 'package:soi/data/models.dart';
import 'package:soi/features/certificate/certificate_card.dart';
import 'package:soi/l10n/generated/app_localizations.dart';

/// The certificate's identity is fixed: it must look identical in light and
/// dark themes and at any text scale, because the holder shares the image
/// and a verifier compares it. These goldens pin that.
void main() {
  setUpAll(() async => initializeDateFormatting('en_IN'));

  final volunteering = Certificate(
    found: true,
    valid: true,
    code: 'SOI-5A0E-5F73',
    kind: 'volunteering',
    subjectName: 'Priya Sharma',
    orgName: 'Aarambh Foundation',
    title: 'Godavari ghat clean-up',
    hours: 4,
    issuedAt: DateTime(2026, 8, 9),
  );

  Widget host(Widget child, {ThemeData? theme, double scale = 1}) => MaterialApp(
        theme: theme ?? SoiTheme.light(),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: MediaQuery(
          data: MediaQueryData(size: const Size(400, 900), textScaler: TextScaler.linear(scale)),
          child: Scaffold(body: SingleChildScrollView(child: Center(child: SizedBox(width: 360, child: child)))),
        ),
      );

  testWidgets('volunteering certificate, light', (tester) async {
    await tester.pumpWidget(host(CertificateCard(certificate: volunteering, width: 360)));
    await tester.pumpAndSettle();
    await expectLater(find.byType(CertificateCard), matchesGoldenFile('goldens/certificate_volunteering.png'));
  });

  testWidgets('identical in dark theme and at 1.3x text scale', (tester) async {
    await tester.pumpWidget(host(CertificateCard(certificate: volunteering, width: 360), theme: SoiTheme.dark(), scale: 1.3));
    await tester.pumpAndSettle();
    await expectLater(find.byType(CertificateCard), matchesGoldenFile('goldens/certificate_volunteering.png'));
  });

  testWidgets('pledge certificate and withdrawn state', (tester) async {
    final pledge = volunteering.copyWith(
      kind: 'pledge',
      hours: null,
      title: 'I pledge to refuse single-use plastic for one year.',
      valid: false,
      revokedReason: 'Issued in error',
    );
    await tester.pumpWidget(host(CertificateCard(certificate: pledge, width: 360)));
    await tester.pumpAndSettle();
    await expectLater(find.byType(CertificateCard), matchesGoldenFile('goldens/certificate_pledge_withdrawn.png'));
  });

  testWidgets('long name and title do not overflow', (tester) async {
    final long = volunteering.copyWith(
      subjectName: 'Venkatanarasimharajuvaripeta Subrahmanyam Ramakrishnan Iyer',
      title: 'A' * 120,
    );
    await tester.pumpWidget(host(CertificateCard(certificate: long, width: 360)));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
