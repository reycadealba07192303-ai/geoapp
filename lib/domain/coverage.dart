import 'dart:math' as math;

import 'geo.dart';
import 'place.dart';

/// Study area: only places within [radiusMeters] of the center are forecast.
///
/// Pure Dart — no Flutter imports.
class Coverage {
  const Coverage({
    required this.name,
    required this.centerLat,
    required this.centerLng,
    this.radiusMeters = 10000,
    this.followsUser = false,
  });

  final String name;

  /// True when centered on the user's GPS fix, false for the default area.
  final bool followsUser;
  final double centerLat;
  final double centerLng;
  final double radiusMeters;

  double distanceFromCenter(double lat, double lng) =>
      distanceMeters(centerLat, centerLng, lat, lng);

  bool contains(double lat, double lng) =>
      distanceFromCenter(lat, lng) <= radiusMeters;

  /// Places inside the circle, nearest to the center first.
  List<Place> filter(Iterable<Place> places) =>
      [
        for (final p in places)
          if (contains(p.lat, p.lng)) p,
      ]..sort(
        (a, b) => distanceFromCenter(
          a.lat,
          a.lng,
        ).compareTo(distanceFromCenter(b.lat, b.lng)),
      );

  /// Lat/lng box that encloses the circle (for map camera limits).
  ({double south, double west, double north, double east}) get box {
    const metersPerDegree = 111320.0;
    final dLat = radiusMeters / metersPerDegree;
    final dLng =
        radiusMeters / (metersPerDegree * math.cos(centerLat * math.pi / 180));
    return (
      south: centerLat - dLat,
      west: centerLng - dLng,
      north: centerLat + dLat,
      east: centerLng + dLng,
    );
  }
}
