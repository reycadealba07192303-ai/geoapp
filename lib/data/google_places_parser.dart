import 'dart:convert';

import '../domain/place.dart';

/// Builds Places API (New) Nearby Search requests and parses responses.
///
/// Pure Dart — no Flutter imports.
abstract final class GooglePlacesParser {
  static const endpoint =
      'https://places.googleapis.com/v1/places:searchNearby';

  /// Pro fields + regularOpeningHours (Enterprise) for accurate "closed".
  static const fieldMask =
      'places.id,places.displayName,places.location,places.primaryType,'
      'places.types,places.shortFormattedAddress,places.photos,'
      'places.regularOpeningHours,places.businessStatus';

  /// Table A types searched per category (one request each).
  static const typesFor = <PlaceCategory, List<String>>{
    PlaceCategory.fastFood: ['fast_food_restaurant', 'hamburger_restaurant'],
    PlaceCategory.kainan: ['restaurant', 'filipino_restaurant', 'food_court'],
    PlaceCategory.coffee: ['cafe', 'coffee_shop', 'tea_house'],
    PlaceCategory.palengke: ['market'],
    PlaceCategory.mall: ['shopping_mall'],
    PlaceCategory.supermarket: ['supermarket', 'grocery_store'],
    PlaceCategory.services: [],
  };

  /// Nearest places first, up to the API maximum of 20.
  static Map<String, Object> requestBody({
    required PlaceCategory category,
    required double lat,
    required double lng,
    required double radiusMeters,
  }) {
    return {
      'includedTypes': typesFor[category]!,
      'maxResultCount': 20,
      'rankPreference': 'DISTANCE',
      'locationRestriction': {
        'circle': {
          'center': {'latitude': lat, 'longitude': lng},
          'radius': radiusMeters.clamp(1, 50000),
        },
      },
    };
  }

  static List<Place> parseResponse(String body, PlaceCategory requested) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    final places = (json['places'] as List?) ?? const [];
    return [
      for (final p in places)
        ?parsePlace((p as Map).cast<String, dynamic>(), requested),
    ];
  }

  static Place? parsePlace(Map<String, dynamic> json, PlaceCategory requested) {
    final id = json['id'] as String?;
    final name = ((json['displayName'] as Map?)?['text'] as String?)?.trim();
    final location = (json['location'] as Map?)?.cast<String, dynamic>();
    final lat = location?['latitude'] as num?;
    final lng = location?['longitude'] as num?;
    if (id == null ||
        name == null ||
        name.isEmpty ||
        lat == null ||
        lng == null) {
      return null;
    }

    final status = json['businessStatus'] as String?;
    if (status == 'CLOSED_PERMANENTLY' || status == 'CLOSED_TEMPORARILY') {
      return null;
    }

    final photo = ((json['photos'] as List?)?.firstOrNull as Map?)
        ?.cast<String, dynamic>();
    final author =
        ((photo?['authorAttributions'] as List?)?.firstOrNull
                as Map?)?['displayName']
            as String?;

    return Place(
      id: 'g-$id',
      name: name,
      area: (json['shortFormattedAddress'] as String?) ?? '',
      category: categoryFor(
        primaryType: json['primaryType'] as String?,
        types: [...?(json['types'] as List?)?.cast<String>()],
        requested: requested,
      ),
      lat: lat.toDouble(),
      lng: lng.toDouble(),
      hours: hoursFrom(
        (json['regularOpeningHours'] as Map?)?.cast<String, dynamic>(),
      ),
      source: PlaceSource.google,
      photoName: photo?['name'] as String?,
      photoAuthor: author,
    );
  }

  /// Google's own primary type wins (Jollibee also shows up in "restaurant").
  static PlaceCategory categoryFor({
    required String? primaryType,
    required List<String> types,
    required PlaceCategory requested,
  }) {
    PlaceCategory? match(String? type) {
      for (final entry in typesFor.entries) {
        if (entry.value.contains(type)) return entry.key;
      }
      return null;
    }

    return match(primaryType) ??
        (types.contains('fast_food_restaurant')
            ? PlaceCategory.fastFood
            : null) ??
        requested;
  }

  /// Most common daily open–close range, or 24/7.
  static Hours? hoursFrom(Map<String, dynamic>? regularOpeningHours) {
    final periods = (regularOpeningHours?['periods'] as List?)
        ?.cast<Map>()
        .map((p) => p.cast<String, dynamic>())
        .toList();
    if (periods == null || periods.isEmpty) return null;

    // A single period that opens and never closes = open 24 hours.
    if (periods.length == 1 && periods.first['close'] == null) {
      return (open: 0, close: 24);
    }

    final counts = <Hours, int>{};
    for (final period in periods) {
      final open = (period['open'] as Map?)?.cast<String, dynamic>();
      final close = (period['close'] as Map?)?.cast<String, dynamic>();
      if (open == null || close == null) continue;
      final openHour = (open['hour'] as num? ?? 0).toInt();
      final closeMinute = (close['minute'] as num? ?? 0).toInt();
      var closeHour = (close['hour'] as num? ?? 0).toInt();
      if (closeMinute > 0) closeHour += 1;
      if (closeHour == 0 || (closeHour == 24)) closeHour = 24;
      if (closeHour > 24) closeHour -= 24;
      final hours = (open: openHour, close: closeHour);
      counts[hours] = (counts[hours] ?? 0) + 1;
    }
    if (counts.isEmpty) return null;
    return counts.entries.reduce((a, b) => b.value > a.value ? b : a).key;
  }
}
