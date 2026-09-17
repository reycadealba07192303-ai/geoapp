import 'place.dart';

/// Best-effort reader for OpenStreetMap `opening_hours`.
///
/// Handles `24/7` and the first `HH:MM-HH:MM` range (day rules are ignored).
/// Anything else returns null so the category defaults are used.
///
/// Pure Dart — no Flutter imports.
abstract final class OpeningHours {
  static final _range = RegExp(r'(\d{1,2}):(\d{2})\s*-\s*(\d{1,2}):(\d{2})');

  static Hours? parse(String? raw) {
    if (raw == null) return null;
    final value = raw.trim();
    if (value == '24/7') return (open: 0, close: 24);

    final match = _range.firstMatch(value);
    if (match == null) return null;

    final open = int.parse(match[1]!);
    final endHour = int.parse(match[3]!);
    final endMinute = int.parse(match[4]!);
    if (open > 23 || endHour > 24) return null;

    // Round the closing time up to the next whole hour.
    var close = endMinute > 0 ? endHour + 1 : endHour;
    if (close == 0) close = 24;
    if (close > 24) close -= 24;

    return (open: open, close: close);
  }
}
