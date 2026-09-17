import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:geoapp/data/osm_place_parser.dart';
import 'package:geoapp/domain/place.dart';

void main() {
  final response = jsonEncode({
    'elements': [
      {
        'type': 'node',
        'id': 101,
        'lat': 15.1385,
        'lon': 120.5902,
        'tags': {
          'amenity': 'fast_food',
          'name': 'Jollibee',
          'brand': 'Jollibee',
          'opening_hours': '24/7',
          'addr:street': 'Rizal St',
          'addr:city': 'Angeles',
        },
      },
      {
        'type': 'way',
        'id': 202,
        'center': {'lat': 15.1624, 'lon': 120.5891},
        'tags': {
          'amenity': 'cafe',
          'name': 'Starbucks',
          'opening_hours': 'Mo-Su 07:00-22:00',
        },
      },
      {
        'type': 'node',
        'id': 303,
        'lat': 15.15,
        'lon': 120.59,
        'tags': {
          'amenity': 'restaurant',
          'name': 'Kape Kanto',
          'cuisine': 'coffee_shop;filipino',
        },
      },
      {
        'type': 'node',
        'id': 404,
        'lat': 15.15,
        'lon': 120.59,
        'tags': {'amenity': 'restaurant', 'name': "Aling Lucing's"},
      },
      {
        'type': 'relation',
        'id': 505,
        'center': {'lat': 15.147, 'lon': 120.575},
        'tags': {'amenity': 'marketplace', 'name': 'Pampang Public Market'},
      },
      // Skipped: no name and no coordinates.
      {
        'type': 'node',
        'id': 606,
        'lat': 15.1,
        'lon': 120.5,
        'tags': {'amenity': 'fast_food'},
      },
      {
        'type': 'node',
        'id': 707,
        'lat': 15.1,
        'lon': 120.5,
        'tags': {'amenity': 'bank', 'name': 'BDO'},
      },
      {
        'type': 'way',
        'id': 808,
        'tags': {'shop': 'mall', 'name': 'No Center Mall'},
      },
    ],
  });

  test('parses named places with categories, ids and coordinates', () {
    final places = OsmPlaceParser.parseResponse(response);

    expect(places.map((p) => p.name), [
      'Jollibee',
      'Starbucks',
      'Kape Kanto',
        "Aling Lucing's",
        'Pampang Public Market',
        'BDO',
      ]);
      expect(places.map((p) => p.category), [
        PlaceCategory.fastFood,
        PlaceCategory.coffee,
        PlaceCategory.coffee,
        PlaceCategory.kainan,
        PlaceCategory.palengke,
        PlaceCategory.services,
      ]);

    final jollibee = places.first;
    expect(jollibee.id, 'osm-node-101');
    expect(jollibee.brand, 'Jollibee');
    expect(jollibee.area, 'Rizal St, Angeles');
    expect(jollibee.isOpen24Hours, isTrue);

    final starbucks = places[1];
    expect(starbucks.id, 'osm-way-202');
    expect(starbucks.lat, 15.1624);
    expect((starbucks.openHour, starbucks.closeHour), (7, 22));
    expect(starbucks.hasKnownHours, isTrue);

    // No hours on OSM → category defaults.
    expect(places[3].hasKnownHours, isFalse);
    expect(places[3].openHour, PlaceCategory.kainan.openHour);
  });

  test(
    'query asks Overpass for named establishments',
    () {
      final q = OsmPlaceParser.query(
        lat: 15.1,
        lng: 120.5,
        radiusMeters: 13000,
      );

      expect(q, contains('around:13000,15.1,120.5'));
      for (final tag in [
        'amenity',
        'shop',
        'tourism',
        'leisure',
        'healthcare',
        'office',
        'craft',
        'public_transport',
      ]) {
        expect(q, contains(tag));
      }
    },
  );
}
