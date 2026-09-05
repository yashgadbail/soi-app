/// QR payload formats shared with the printed posters and the coordinator
/// screen. These strings are a contract: changing them breaks every poster
/// already on a wall.
///
///   `soi:checkin:<driveId>:<code>`   exactly 4 colon-separated parts
///   `soi:pledge:<shareCode>`         exactly 3 parts
///   https://.../verify.html?code=  a certificate (opened, not scanned in-app)
sealed class QrPayload {
  const QrPayload();

  static const _prefix = 'soi';

  static QrPayload? parse(String raw) {
    final s = raw.trim();
    final parts = s.split(':');
    if (parts.isEmpty || parts.first != _prefix) return null;
    if (parts.length == 4 && parts[1] == 'checkin') {
      final id = parts[2];
      final code = parts[3];
      if (_uuid.hasMatch(id) && _uuid.hasMatch(code)) {
        return CheckInPayload(driveId: id, code: code);
      }
      return null;
    }
    if (parts.length == 3 && parts[1] == 'pledge') {
      final code = parts[2].toUpperCase();
      if (RegExp(r'^[0-9A-F]{6}$').hasMatch(code)) {
        return PledgePayload(shareCode: code);
      }
    }
    return null;
  }

  static final _uuid = RegExp(
    r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
  );

  static String checkIn(String driveId, String code) => '$_prefix:checkin:$driveId:$code';
  static String pledge(String shareCode) => '$_prefix:pledge:$shareCode';
}

class CheckInPayload extends QrPayload {
  const CheckInPayload({required this.driveId, required this.code});
  final String driveId;
  final String code;
}

class PledgePayload extends QrPayload {
  const PledgePayload({required this.shareCode});
  final String shareCode;
}
