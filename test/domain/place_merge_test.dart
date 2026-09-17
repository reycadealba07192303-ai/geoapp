import 'package:flutter_test/flutter_test.dart';
import 'package:geoapp/domain/place.dart';
import 'package:geoapp/domain/place_merge.dart';

void main() {
  Place at(String id, String name, double lat, double lng, PlaceSource s) =>
      Place(
        id: id,
        name: name,
        area: '',
        category: PlaceCategory.fastFood,
        lat: lat,
        lng: lng,
        source: s,
      );

  test('drops OSM copies of Google places, keeps the rest', () {
    final google = [
      at(
        'g-1',
        'Jollibee Sto. Rosario',
        15.13850,
        120.59020,
        PlaceSource.google,
      ),
    ];
    final osm = [
      at('osm-1', 'Jollibee', 15.13870, 120.59030, PlaceSource.osm), // ~25 m
      at('osm-2', 'Jollibee', 15.16930, 120.58060, PlaceSource.osm), // 3 km
      at('osm-3', "Aling Lucing's", 15.13860, 120.59010, PlaceSource.osm),
    ];

    final merged = mergePlaces(primary: google, secondary: osm);

    expect(merged.map((p) => p.id), ['g-1', 'osm-2', 'osm-3']);
  });

  test('name matching ignores punctuation, case and generic words', () {
    expect(namesMatch("McDonald's Dau", 'Mcdonalds'), isTrue);
    expect(namesMatch('Starbucks Coffee', 'STARBUCKS'), isTrue);
    expect(namesMatch('Cafe Bella', 'Cafe Tribu'), isFalse);
    expect(namesMatch('Coffee', 'Coffee'), isTrue);
  });
}
