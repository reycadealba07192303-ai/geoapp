import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:geoapp/data/google_places_parser.dart';
import 'package:geoapp/domain/place.dart';

void main() {
  final response = jsonEncode({
    'places': [
      {
        'id': 'ChIJcoffee',
        'displayName': {'text': 'Kape Kanto', 'languageCode': 'en'},
        'location': {'latitude': 15.1501, 'longitude': 120.5902},
        'primaryType': 'coffee_shop',
        'types': ['coffee_shop', 'cafe', 'food', 'establishment'],
        'shortFormattedAddress': 'Rizal St, Angeles',
        'businessStatus': 'OPERATIONAL',
        'photos': [
          {
            'name': 'places/ChIJcoffee/photos/AbC123',
            'widthPx': 4000,
            'heightPx': 3000,
            'authorAttributions': [
              {'displayName': 'Juan Dela Cruz', 'uri': '//maps.google.com/x'},
            ],
          },
        ],
        'regularOpeningHours': {
          'periods': [
            for (var day = 0; day < 7; day++)
              {
                'open': {'day': day, 'hour': 7, 'minute': 0},
                'close': {'day': day, 'hour': 21, 'minute': 30},
              },
          ],
        },
      },
      {
        // Jollibee comes back from the "restaurant" search too.
        'id': 'ChIJjollibee',
        'displayName': {'text': 'Jollibee'},
        'location': {'latitude': 15.1385, 'longitude': 120.5902},
        'primaryType': 'fast_food_restaurant',
        'types': ['fast_food_restaurant', 'restaurant'],
        'regularOpeningHours': {
          'periods': [
            {
              'open': {'day': 0, 'hour': 0, 'minute': 0},
            },
          ],
        },
      },
      {
        'id': 'ChIJclosed',
        'displayName': {'text': 'Old Diner'},
        'location': {'latitude': 15.1, 'longitude': 120.5},
        'businessStatus': 'CLOSED_PERMANENTLY',
      },
      {
        'id': 'ChIJnoname',
        'location': {'latitude': 15.1, 'longitude': 120.5},
      },
    ],
  });

  test('parses places with category, photo, credit and hours', () {
    final places = GooglePlacesParser.parseResponse(
      response,
      PlaceCategory.kainan,
    );

    expect(places.map((p) => p.name), ['Kape Kanto', 'Jollibee']);

    final coffee = places.first;
    expect(coffee.id, 'g-ChIJcoffee');
    expect(coffee.source, PlaceSource.google);
    expect(coffee.category, PlaceCategory.coffee);
    expect(coffee.area, 'Rizal St, Angeles');
    expect(coffee.photoName, 'places/ChIJcoffee/photos/AbC123');
    expect(coffee.photoAuthor, 'Juan Dela Cruz');
    expect((coffee.openHour, coffee.closeHour), (7, 22));

    final jollibee = places[1];
    expect(jollibee.category, PlaceCategory.fastFood);
    expect(jollibee.isOpen24Hours, isTrue);
    expect(jollibee.photoName, isNull);
  });

  test('request asks for the 20 nearest of a category within the scope', () {
    final body = GooglePlacesParser.requestBody(
      category: PlaceCategory.coffee,
      lat: 15.14,
      lng: 120.58,
      radiusMeters: 10000,
    );

    expect(body['includedTypes'], ['cafe', 'coffee_shop', 'tea_house']);
    expect(body['maxResultCount'], 20);
    expect(body['rankPreference'], 'DISTANCE');
    expect(
      (body['locationRestriction'] as Map)['circle'],
      containsPair('radius', 10000),
    );
    expect(GooglePlacesParser.fieldMask, contains('places.photos'));
  });

  test('every Google-backed category has search types', () {
    for (final c in PlaceCategory.values.where((c) => c != PlaceCategory.services)) {
      expect(GooglePlacesParser.typesFor[c], isNotEmpty);
    }
    expect(GooglePlacesParser.typesFor[PlaceCategory.services], isEmpty);
  });
}
