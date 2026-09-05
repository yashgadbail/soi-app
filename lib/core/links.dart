import 'package:soi/core/env.dart';

/// Outward-facing URLs and contacts.
///
/// The privacy policy URL is declared in Google Play and must never 404;
/// moving hosts is a one-line change in `.env` (`SOI_WEB_ORIGIN`) plus the
/// Play Console update.
abstract final class Links {
  static String get origin => Env.webOrigin;
  static String get privacy => '$origin/privacy.html';
  static String get deleteAccount => '$origin/delete-account.html';
  static String get childSafety => '$origin/child-safety.html';
  static String get verifyPage => '$origin/verify.html';

  static const supportEmail = 'support@swagofindia.org';

  /// Public URL that verifies one certificate. Printed on the certificate
  /// and encoded in its QR.
  static String verifyUrl(String code) =>
      '$verifyPage?code=${Uri.encodeQueryComponent(code)}';

  /// Deep links use the `open` host so the path matches the in-app route:
  ///   soi://open/pledge/ABC123  ->  /pledge/ABC123
  static Uri pledgeDeepLink(String shareCode) =>
      Uri(scheme: 'soi', host: 'open', path: '/pledge/$shareCode');

  static Uri certificateDeepLink(String code) =>
      Uri(scheme: 'soi', host: 'open', path: '/certificate/$code');

  static Uri driveDeepLink(String id) =>
      Uri(scheme: 'soi', host: 'open', path: '/drive/$id');

  /// Opens the venue in the user's maps app (a query, never a stored
  /// location: the app records no coordinates).
  static Uri mapsSearch(String query) => Uri(
        scheme: 'geo',
        path: '0,0',
        queryParameters: {'q': query},
      );

  static Uri mailto(String address, {String? subject}) => Uri(
        scheme: 'mailto',
        path: address,
        queryParameters: subject == null ? null : {'subject': subject},
      );
}
