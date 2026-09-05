import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soi/core/theme/theme.dart';
import 'package:soi/core/theme/tokens.dart';
import 'package:soi/l10n/generated/app_localizations.dart';
import 'package:soi/router/app_router.dart';
import 'package:soi/ui/widgets.dart';

class SoiApp extends ConsumerWidget {
  const SoiApp({super.key});

  /// Above this window width the whole app is centred in a column so text
  /// lines and cards keep a readable measure on tablets and desktop.
  static const _frameMaxWidth = 960.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: SoiTheme.light(),
      darkTheme: SoiTheme.dark(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      builder: (context, child) {
        // Cap text scaling so the certificate and dense rows stay legible;
        // 1.3x is tested, above that layouts are not.
        final mq = MediaQuery.of(context);
        final capped = MediaQuery(
          data: mq.copyWith(textScaler: mq.textScaler.clamp(maxScaleFactor: 1.3)),
          child: Stack(children: [const Positioned.fill(child: BrandBackdrop()), child!]),
        );
        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth <= _frameMaxWidth) return capped;
            final c = Theme.of(context).extension<SoiColors>()!;
            return ColoredBox(
              color: c.bgAlt,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _frameMaxWidth),
                  child: capped,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
