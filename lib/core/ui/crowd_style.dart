import 'package:flutter/material.dart';

import '../../domain/crowd_level.dart';
import '../../domain/place.dart';
import '../i18n/tr.dart';

/// Icons and number formatting shared by the screens.
/// Colors live in ClayPalette, words in Tr.
class CrowdStyle {
  const CrowdStyle._();

  static IconData icon(CrowdLevel level) => switch (level) {
    CrowdLevel.maluwag => Icons.person_outline_rounded,
    CrowdLevel.kaunti => Icons.people_outline_rounded,
    CrowdLevel.katamtaman => Icons.groups_outlined,
    CrowdLevel.mataong => Icons.groups_rounded,
    CrowdLevel.siksikan => Icons.groups_3_rounded,
  };

  static IconData categoryIcon(PlaceCategory category) => switch (category) {
    PlaceCategory.fastFood => Icons.fastfood_rounded,
    PlaceCategory.kainan => Icons.restaurant_rounded,
    PlaceCategory.coffee => Icons.local_cafe_rounded,
    PlaceCategory.palengke => Icons.storefront_rounded,
    PlaceCategory.mall => Icons.local_mall_rounded,
    PlaceCategory.supermarket => Icons.shopping_cart_rounded,
    PlaceCategory.services => Icons.place_rounded,
  };

  /// Illustration gradient per category (used when there is no photo).
  static List<Color> categoryGradient(PlaceCategory category) =>
      switch (category) {
        PlaceCategory.fastFood => const [Color(0xFFFF9A62), Color(0xFFFF5C7A)],
        PlaceCategory.kainan => const [Color(0xFFFFC857), Color(0xFFFF8A50)],
        PlaceCategory.coffee => const [Color(0xFFC89B7B), Color(0xFF8A5A44)],
        PlaceCategory.palengke => const [Color(0xFF6EDC9A), Color(0xFF2FA86E)],
        PlaceCategory.mall => const [Color(0xFFA99BFF), Color(0xFF6D5DFC)],
        PlaceCategory.supermarket => const [
          Color(0xFF7CC2FF),
          Color(0xFF3F7FE0),
        ],
        PlaceCategory.services => const [Color(0xFF7AD7C4), Color(0xFF2D8D9A)],
      };

  static String percent(double crowdIndex) => '${(crowdIndex * 100).round()}%';

  /// 0 → 12AM, 13 → 1PM, 24 → 12AM.
  static String hour(int hour) {
    final h = hour % 24;
    final twelve = h % 12 == 0 ? 12 : h % 12;
    return '$twelve${h < 12 ? 'AM' : 'PM'}';
  }

  static String day(Tr tr, DateTime date, DateTime today) {
    final diff = DateTime(
      date.year,
      date.month,
      date.day,
    ).difference(DateTime(today.year, today.month, today.day)).inDays;
    if (diff == 0) return tr.today;
    if (diff == 1) return tr.tomorrow;
    return tr.weekday(date.weekday);
  }

  static String distance(double meters) => meters < 1000
      ? '${(meters / 10).round() * 10} m'
      : '${(meters / 1000).toStringAsFixed(1)} km';

  static const tabular = [FontFeature.tabularFigures()];
}
