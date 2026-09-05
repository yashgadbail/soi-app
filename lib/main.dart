import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soi/app.dart';
import 'package:soi/core/env.dart';
import 'package:soi/core/theme/theme.dart';
import 'package:soi/data/session.dart';
import 'package:soi/data/snapshots.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SoiTheme.systemBars(dark: false));

  if (!Env.isConfigured) {
    runApp(const _ConfigError());
    return;
  }

  await initializeDateFormatting('en_IN');
  await Supabase.initialize(
    url: Env.supabaseUrl,
    publishableKey: Env.supabasePublishableKey,
    authOptions: const FlutterAuthClientOptions(
      // The app owns its deep links (soi://); the SDK must not intercept them.
      detectSessionInUri: false,
    ),
  );

  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );

  final container = ProviderContainer(
    // Errors are surfaced as retry states by the screens themselves; the
    // framework must not silently retry in the background and make error
    // states flicker.
    retry: (_, _) => null,
    overrides: [snapshotsProvider.overrideWithValue(Snapshots(prefs))],
  );

  // The router reads session state synchronously; have it ready before the
  // first frame, falling back to the last snapshot when offline.
  await container.read(sessionControllerProvider.notifier).bootstrap();

  runApp(UncontrolledProviderScope(container: container, child: const SoiApp()));
}

/// Shown only when the build was made without `--dart-define-from-file=.env`.
class _ConfigError extends StatelessWidget {
  const _ConfigError();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'Missing configuration.\n\nCopy .env.example to .env, fill in SUPABASE_URL and '
              'SUPABASE_PUBLISHABLE_KEY, then run with --dart-define-from-file=.env',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
