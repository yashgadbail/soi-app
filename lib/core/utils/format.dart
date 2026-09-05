import 'package:intl/intl.dart';

/// Date and number formatting, India-first (`en_IN`).
abstract final class Fmt {
  static const locale = 'en_IN';

  static final _day = DateFormat('EEE, d MMM', locale);
  static final _dayYear = DateFormat('d MMM y', locale);
  static final _long = DateFormat('d MMMM y', locale);
  static final _time = DateFormat('h:mm a', locale);
  static final _hours = NumberFormat('#.##', locale);

  /// "Sat, 12 Oct"
  static String day(DateTime t) => _day.format(t.toLocal());

  /// "12 Oct 2026"
  static String dayYear(DateTime t) => _dayYear.format(t.toLocal());

  /// "12 October 2026" (certificates)
  static String longDate(DateTime t) => _long.format(t.toLocal());

  /// "9:30 am"
  static String time(DateTime t) => _time.format(t.toLocal()).toLowerCase();

  /// "9:30 am – 1:00 pm"
  static String timeRange(DateTime a, DateTime b) => '${time(a)} – ${time(b)}';

  /// "4" / "2.5"
  static String hours(num h) => _hours.format(h);

  /// "In 3 days" reads better than a date for anyone scanning a list.
  /// Returns null when the date is not within the next week (or is past),
  /// so the caller can fall back to [day].
  static String? relativeDay(DateTime t, {DateTime? now}) {
    final n = now ?? DateTime.now();
    final a = DateTime(t.year, t.month, t.day);
    final b = DateTime(n.year, n.month, n.day);
    final days = a.difference(b).inDays;
    if (days == 0) return 'Today';
    if (days == 1) return 'Tomorrow';
    if (days > 1 && days < 7) return 'In $days days';
    return null;
  }

  static String dayOrRelative(DateTime t) => relativeDay(t) ?? day(t);

  /// "2h ago", "just now"
  static String ago(DateTime t, {DateTime? now}) {
    final d = (now ?? DateTime.now()).difference(t.toLocal());
    if (d.inSeconds < 45) return 'just now';
    if (d.inMinutes < 60) return '${d.inMinutes}m ago';
    if (d.inHours < 24) return '${d.inHours}h ago';
    return day(t);
  }
}
