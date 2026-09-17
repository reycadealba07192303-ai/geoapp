import 'dart:convert';

import '../domain/opening_hours.dart';
import '../domain/place.dart';

/// Turns OpenStreetMap (Overpass API) elements into [Place]s.
///
/// Pure Dart — no Flutter imports.
abstract final class OsmPlaceParser {
  /// Named establishments around the user.
  static String query({
    required double lat,
    required double lng,
    required double radiusMeters,
  }) {
    final around = 'around:${radiusMeters.round()},$lat,$lng';
    // Keep the payload small: these are the categories shown by the app.
    // Querying every named office/healthcare/transport feature makes a 10 km
    // request unnecessarily large and delays the useful food results.
    return '[out:json][timeout:35];\n'
        '(\n'
        '  nwr["amenity"~"cafe|fast_food|restaurant|food_court|marketplace"]["name"]($around);\n'
        '  nwr["shop"~"coffee|tea|mall|department_store|supermarket|convenience|grocery|greengrocer|general|variety_store"]["name"]($around);\n'
        '  nwr["tourism"]["name"]["tourism"~"hotel|guest_house"]($around);\n'
        ');\n'
        'out center tags;';
  }

  static List<Place> parseResponse(String body) {
    final json = jsonDecode(body) as Map<String, dynamic>;
    final elements = (json['elements'] as List?) ?? const [];
    return [
      for (final e in elements)
        ?parseElement((e as Map).cast<String, dynamic>()),
    ];
  }

  static Place? parseElement(Map<String, dynamic> element) {
    final tags = (element['tags'] as Map?)?.cast<String, dynamic>() ?? const {};
    final name = (tags['name'] as String?)?.trim();
    if (name == null || name.isEmpty) return null;

    final category = categoryFor(tags);
    if (category == null) return null;

    // Nodes have lat/lon; ways and relations have a computed center.
    final center = (element['center'] as Map?)?.cast<String, dynamic>();
    final lat = (element['lat'] ?? center?['lat']) as num?;
    final lng = (element['lon'] ?? center?['lon']) as num?;
    if (lat == null || lng == null) return null;

    final openingHours = tags['opening_hours'] as String?;
    return Place(
      id: 'osm-${element['type']}-${element['id']}',
      name: name,
      area: areaFor(tags),
      category: category,
      lat: lat.toDouble(),
      lng: lng.toDouble(),
      brand: tags['brand'] as String?,
      phone: (tags['phone'] ?? tags['contact:phone']) as String?,
      website: (tags['website'] ?? tags['contact:website']) as String?,
      operator: tags['operator'] as String?,
      email: (tags['email'] ?? tags['contact:email']) as String?,
      cuisine: tags['cuisine'] as String?,
      description: tags['description'] as String?,
      wheelchair: tags['wheelchair'] as String?,
      outdoorSeating: tags['outdoor_seating'] as String?,
      internetAccess: tags['internet_access'] as String?,
      delivery: tags['delivery'] as String?,
      takeaway: tags['takeaway'] as String?,
      capacity: tags['capacity'] as String?,
      facebook: tags['contact:facebook'] as String?,
      instagram: tags['contact:instagram'] as String?,
      openingHours: openingHours,
      hours: OpeningHours.parse(openingHours),
    );
  }

  static PlaceCategory? categoryFor(Map<String, dynamic> tags) {
    final amenity = tags['amenity'] as String?;
    final shop = tags['shop'] as String?;
    final name = (tags['name'] as String? ?? '').toLowerCase();
    final cuisine = (tags['cuisine'] as String? ?? '').toLowerCase();
    final servesFood = const {
      'fast_food',
      'restaurant',
      'cafe',
    }.contains(amenity);
    final looksLikeCoffee =
        name.contains('coffee') ||
        name.contains('cafe') ||
        name.contains('café') ||
        name.contains('kape') ||
        name.contains('tea') ||
        name.contains('milktea') ||
        name.contains('milk tea') ||
        cuisine.contains('coffee') ||
        cuisine.contains('tea') ||
        cuisine.contains('bubble_tea') ||
        cuisine.contains('dessert');

    if (amenity == 'cafe' ||
        shop == 'coffee' ||
        shop == 'tea' ||
        (servesFood && looksLikeCoffee) ||
        looksLikeCoffee) {
      return PlaceCategory.coffee;
    }

    if (shop != null) {
      if (const {'mall', 'department_store'}.contains(shop)) {
        return PlaceCategory.mall;
      }
      if (const {
        'supermarket',
        'convenience',
        'grocery',
        'greengrocer',
        'general',
        'variety_store',
      }.contains(shop)) {
        return PlaceCategory.supermarket;
      }
      return PlaceCategory.services;
    }

    final mapped = switch ((amenity, shop)) {
      ('fast_food', _) => PlaceCategory.fastFood,
      ('restaurant' || 'food_court', _) => PlaceCategory.kainan,
      ('marketplace', _) => PlaceCategory.palengke,
      _ => null,
    };
    if (mapped != null) return mapped;

    if (tags.containsKey('tourism') ||
        tags.containsKey('leisure') ||
        tags.containsKey('healthcare') ||
        tags.containsKey('office') ||
        tags.containsKey('craft') ||
        tags.containsKey('public_transport')) {
      return PlaceCategory.services;
    }

    if (amenity != null) return PlaceCategory.services;
    return null;
  }

  static String areaFor(Map<String, dynamic> tags) {
    String? first(List<String> keys) {
      for (final k in keys) {
        final v = (tags[k] as String?)?.trim();
        if (v != null && v.isNotEmpty) return v;
      }
      return null;
    }

    return [
      first(['addr:housenumber']),
      first(['addr:street']),
      first(['addr:suburb', 'addr:village', 'addr:hamlet', 'addr:district']),
      first(['addr:city', 'addr:municipality', 'addr:town']),
    ].nonNulls.join(', ');
  }
}
