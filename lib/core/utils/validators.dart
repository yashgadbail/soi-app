/// Client-side field validation.
///
/// These rules deliberately mirror the server's checks (see
/// docs/CONTRACT.md). The server is the real boundary; this exists so a
/// teacher enrolling thirty students is told immediately, not after a
/// round trip. Every function returns an error KEY (never a sentence) so
/// the l10n layer owns the wording.
abstract final class Validators {
  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]{2,}$');
  static final _roll = RegExp(r'^[A-Za-z0-9/-]{1,12}$');
  static final _hasLetter = RegExp('[A-Za-zऀ-ॿ]');

  static String? email(String value) {
    final v = value.trim();
    if (v.isEmpty) return 'REQUIRED';
    if (!_email.hasMatch(v) || v.length > 120) return 'BAD_EMAIL';
    return null;
  }

  static String? personName(String value, {bool required = true}) {
    final v = value.trim();
    if (v.isEmpty) return required ? 'REQUIRED' : null;
    if (v.length < 2) return 'NAME_TOO_SHORT';
    if (v.length > 80) return 'NAME_TOO_LONG';
    if (v.contains('@')) return 'NAME_LOOKS_LIKE_EMAIL';
    if (!_hasLetter.hasMatch(v)) return 'NAME_TOO_SHORT';
    return null;
  }

  static String? orgName(String value) {
    final v = value.trim();
    if (v.isEmpty) return 'REQUIRED';
    if (v.length < 3) return 'NAME_TOO_SHORT';
    if (v.length > 80) return 'NAME_TOO_LONG';
    return null;
  }

  static String? classSection(String value) =>
      value.trim().length > 20 ? 'CLASS_TOO_LONG' : null;

  static String? rollNo(String value) {
    final v = value.trim();
    if (v.isEmpty) return null;
    return _roll.hasMatch(v) ? null : 'BAD_ROLL';
  }

  /// Strips +91 / leading 0 / spacing and returns bare digits.
  static String normalisePhone(String raw) {
    var d = raw.replaceAll(RegExp(r'\D'), '');
    if (d.length == 12 && d.startsWith('91')) d = d.substring(2);
    if (d.length == 11 && d.startsWith('0')) d = d.substring(1);
    return d;
  }

  static String? phone(String value, {bool required = false}) {
    if (value.trim().isEmpty) return required ? 'REQUIRED' : null;
    final d = normalisePhone(value);
    if (d.length != 10 || !RegExp('^[6-9]').hasMatch(d)) return 'BAD_PHONE';
    return null;
  }

  static String? driveTitle(String value) {
    final v = value.trim();
    if (v.isEmpty) return 'REQUIRED';
    if (v.length < 5) return 'TITLE_TOO_SHORT';
    if (v.length > 120) return 'TITLE_TOO_LONG';
    return null;
  }

  static String? pledgeTitle(String value) => driveTitle(value);

  static String? pledgeBody(String value) {
    final v = value.trim();
    if (v.isEmpty) return 'REQUIRED';
    if (v.length < 20) return 'BODY_TOO_SHORT';
    if (v.length > 2000) return 'BODY_TOO_LONG';
    return null;
  }

  static String? campaign(String value) =>
      value.trim().length > 60 ? 'CAMPAIGN_TOO_LONG' : null;

  static String? capacity(String value) {
    final n = int.tryParse(value.trim());
    if (n == null || n < 1 || n > 5000) return 'BAD_CAPACITY';
    return null;
  }

  static String? hours(String value) {
    final n = num.tryParse(value.trim());
    if (n == null || n <= 0 || n > 12) return 'BAD_HOURS';
    return null;
  }

  static String? otp(String value) {
    final v = value.trim();
    if (v.length < 6 || v.length > 10 || !RegExp(r'^\d+$').hasMatch(v)) {
      return 'BAD_CODE';
    }
    return null;
  }

  static String? claimCode(String value) {
    final v = value.trim().toUpperCase();
    if (!RegExp(r'^[0-9A-F]{8}$').hasMatch(v)) return 'BAD_CODE';
    return null;
  }

  static String? shareCode(String value) {
    final v = value.trim().toUpperCase();
    if (!RegExp(r'^[0-9A-F]{6}$').hasMatch(v)) return 'BAD_CODE';
    return null;
  }

  static String? certificateCode(String value) {
    final v = value.trim().toUpperCase();
    if (!RegExp(r'^SOI-[0-9A-F]{4}-[0-9A-F]{4}$').hasMatch(v)) return 'BAD_CODE';
    return null;
  }
}
