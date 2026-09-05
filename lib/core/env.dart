/// Build-time configuration.
///
/// Values are injected with `--dart-define-from-file=.env` (see
/// `.env.example`). They are compile-time constants: nothing is read from
/// disk at runtime and nothing secret is ever bundled, because the
/// publishable key is designed to be public.
abstract final class Env {
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabasePublishableKey =
      String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
  static const webOrigin = String.fromEnvironment(
    'SOI_WEB_ORIGIN',
    defaultValue: 'https://soi.yashgb.com',
  );

  static bool get isConfigured =>
      supabaseUrl.isNotEmpty && supabasePublishableKey.isNotEmpty;
}
