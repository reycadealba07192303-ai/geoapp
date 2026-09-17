import 'package:flutter_test/flutter_test.dart';
import 'package:geoapp/domain/opening_hours.dart';
import 'package:geoapp/domain/place.dart';

void main() {
  test('parses common OpenStreetMap opening_hours', () {
    expect(OpeningHours.parse('24/7'), (open: 0, close: 24));
    expect(OpeningHours.parse('10:00-22:00'), (open: 10, close: 22));
    expect(OpeningHours.parse('Mo-Su 06:00-23:30'), (open: 6, close: 24));
    expect(OpeningHours.parse('Mo-Fr 3:00-15:00'), (open: 3, close: 15));
    expect(OpeningHours.parse('07:00-00:00'), (open: 7, close: 24));
    expect(OpeningHours.parse('18:00-02:00'), (open: 18, close: 2));
  });

  test('unknown formats fall back to null', () {
    expect(OpeningHours.parse(null), isNull);
    expect(OpeningHours.parse('sunrise-sunset'), isNull);
    expect(OpeningHours.parse('off'), isNull);
  });

  test('places open past midnight are open on both sides of 12AM', () {
    const bar = Place(
      id: 'x',
      name: 'Late Kainan',
      area: '',
      category: PlaceCategory.kainan,
      lat: 0,
      lng: 0,
      hours: (open: 18, close: 2),
    );

    expect(bar.isOpenAt(23), isTrue);
    expect(bar.isOpenAt(1), isTrue);
    expect(bar.isOpenAt(2), isFalse);
    expect(bar.isOpenAt(12), isFalse);
  });
}
