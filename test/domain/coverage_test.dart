import 'package:flutter_test/flutter_test.dart';
import 'package:geoapp/domain/coverage.dart';
import 'package:geoapp/domain/place.dart';

void main() {
  const coverage = Coverage(
    name: 'Test',
    centerLat: 15.1450,
    centerLng: 120.5887,
  );

  Place at(String id, double lat, double lng) => Place(
    id: id,
    name: id,
    area: '',
    category: PlaceCategory.fastFood,
    lat: lat,
    lng: lng,
  );

  test('keeps places within 10 km and drops the rest', () {
    final inside = at('clark', 15.1696, 120.5800); // ~2.9 km
    final outside = at('san-fernando', 15.0300, 120.6850); // ~16 km

    expect(coverage.filter([inside, outside]), [inside]);
  });

  test('filter sorts nearest to the center first', () {
    final far = at('dau', 15.1850, 120.5880);
    final near = at('puregold', 15.1440, 120.5870);

    expect(coverage.filter([far, near]), [near, far]);
  });

  test('box encloses the circle', () {
    final box = coverage.box;
    expect(
      coverage.distanceFromCenter(box.north, coverage.centerLng),
      closeTo(10000, 50),
    );
    expect(
      coverage.distanceFromCenter(coverage.centerLat, box.east),
      closeTo(10000, 50),
    );
  });
}
