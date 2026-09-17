import 'package:flutter_test/flutter_test.dart';
import 'package:geoapp/data/estimate_baseline.dart';
import 'package:geoapp/domain/place.dart';

void main() {
  Place of(String id, PlaceCategory category) => Place(
    id: id,
    name: id,
    area: '',
    category: category,
    lat: 15.14,
    lng: 120.58,
  );

  test('estimate is the same for every place of a category (no fake data)', () {
    final a = of('osm-node-1', PlaceCategory.fastFood);
    final b = of('osm-node-999', PlaceCategory.fastFood);

    for (var hour = 0; hour < 24; hour++) {
      expect(
        estimateBaseline(a, DateTime.wednesday, hour),
        estimateBaseline(b, DateTime.wednesday, hour),
      );
    }
  });

  test('curves peak when each kind of place is typically busy', () {
    double at(PlaceCategory c, int hour) =>
        estimateBaseline(of('x', c), DateTime.wednesday, hour);

    expect(
      at(PlaceCategory.fastFood, 12),
      greaterThan(at(PlaceCategory.fastFood, 15)),
    );
    expect(
      at(PlaceCategory.coffee, 15),
      greaterThan(at(PlaceCategory.coffee, 12)),
    );
    expect(
      at(PlaceCategory.palengke, 6),
      greaterThan(at(PlaceCategory.palengke, 13)),
    );
  });

  test('weekends are busier at malls', () {
    final mall = of('m', PlaceCategory.mall);
    expect(
      estimateBaseline(mall, DateTime.saturday, 18),
      greaterThan(estimateBaseline(mall, DateTime.wednesday, 18)),
    );
  });
}
