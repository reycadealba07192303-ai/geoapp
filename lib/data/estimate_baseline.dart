import 'dart:math' as math;

import '../domain/place.dart';

/// Typical crowd curve for a category × ISO weekday × hour, 0–1.
///
/// An ESTIMATE, not a measurement: every place of the same category gets the
/// same curve. Field data (Forecasts table) and live reports replace it.
double estimateBaseline(Place place, int dayOfWeek, int hour) {
  double bump(double peakHour, double spread, double height) =>
      height * math.exp(-math.pow(hour - peakHour, 2) / (2 * spread * spread));

  final isSunday = dayOfWeek == DateTime.sunday;
  final isWeekend = dayOfWeek >= DateTime.saturday;

  final raw = switch (place.category) {
    // Breakfast, lunch and dinner rushes.
    PlaceCategory.fastFood =>
      (bump(7.5, 1.2, 0.25) +
              bump(12.3, 1.1, 0.75) +
              bump(19, 1.5, 0.6) +
              0.08) *
          (isWeekend ? 1.2 : 1),
    PlaceCategory.kainan =>
      (bump(12.5, 1.2, 0.6) + bump(19.5, 1.6, 0.75) + 0.05) *
          (isWeekend ? 1.3 : 1),
    // Morning coffee, merienda, after-dinner.
    PlaceCategory.coffee =>
      (bump(9, 1.5, 0.4) + bump(15.5, 2, 0.55) + bump(20, 1.5, 0.35) + 0.08) *
          (isWeekend ? 1.2 : 1),
    // Palengke is busiest at dawn.
    PlaceCategory.palengke =>
      (bump(6, 1.6, 0.8) + bump(16.5, 1.5, 0.4) + 0.1) * (isSunday ? 1.2 : 1),
    PlaceCategory.mall =>
      (bump(14, 2.2, 0.4) + bump(18.5, 1.8, 0.55) + 0.1) *
          (isWeekend ? 1.4 : 1),
    PlaceCategory.supermarket =>
      (bump(11, 2, 0.3) + bump(18, 1.6, 0.6) + 0.1) * (isWeekend ? 1.25 : 1),
    PlaceCategory.services =>
      (bump(10.5, 1.8, 0.35) + bump(15.5, 2.2, 0.35) + 0.08) *
          (isWeekend ? 0.8 : 1),
  };

  return raw.clamp(0.0, 1.0);
}
