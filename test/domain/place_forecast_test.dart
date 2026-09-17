import 'package:flutter_test/flutter_test.dart';
import 'package:geoapp/domain/crowd_level.dart';
import 'package:geoapp/domain/place.dart';
import 'package:geoapp/domain/place_forecast.dart';

void main() {
  const palengke = Place(
    id: 'p1',
    name: 'Palengke 1',
    area: 'A',
    category: PlaceCategory.palengke,
    lat: 15.14,
    lng: 120.58,
  );
  const quietPalengke = Place(
    id: 'p2',
    name: 'Palengke 2',
    area: 'B',
    category: PlaceCategory.palengke,
    lat: 15.15,
    lng: 120.58,
  );
  const mall = Place(
    id: 'm1',
    name: 'Mall',
    area: 'C',
    category: PlaceCategory.mall,
    lat: 15.16,
    lng: 120.58,
  );

  // p1: busy mornings, quiet at 1 PM. p2 is always quiet. Mall flat 0.5.
  double baseline(Place place, int dayOfWeek, int hour) {
    if (place.id == 'p2') return 0.1;
    if (place.id == 'm1') return 0.5;
    return hour == 13 ? 0.15 : 0.7;
  }

  final builder = PlaceForecastBuilder(baseline: baseline);
  const all = [palengke, quietPalengke, mall];
  final tuesday = DateTime(2026, 9, 8, 9); // not a payday

  test('best time is the quietest remaining open hour today', () {
    final f = builder.build(
      place: palengke,
      now: tuesday,
      allPlaces: all,
      reports: const [],
    );
    expect(f.best?.isToday, isTrue);
    expect(f.best?.slot.time.hour, 13);
  });

  test('after closing, best time moves to tomorrow', () {
    final night = DateTime(2026, 9, 8, 21);
    final f = builder.build(
      place: palengke,
      now: night,
      allPlaces: all,
      reports: const [],
    );
    expect(f.current.isOpen, isFalse);
    expect(f.current.crowdIndex, 0);
    expect(f.best?.isToday, isFalse);
    expect(f.best?.slot.time.day, 9);
  });

  test('alternatives are quieter places of the same category only', () {
    final f = builder.build(
      place: palengke,
      now: tuesday,
      allPlaces: all,
      reports: const [],
    );
    expect(f.alternatives.map((a) => a.place.id), ['p2']);
    expect(f.alternatives.first.distanceMeters, closeTo(1112, 20));
  });

  test('payday boosts the forecast', () {
    final payday = DateTime(2026, 9, 15, 9);
    expect(PlaceForecastBuilder.isPayday(payday), isTrue);
    expect(PlaceForecastBuilder.isPayday(DateTime(2026, 2, 28)), isTrue);
    expect(builder.forecastAt(palengke, payday), closeTo(0.805, 1e-9));
  });

  test('fresh siksikan report pulls current index up', () {
    final reports = [
      LiveReport(placeId: 'p1', reportedAt: tuesday, crowdLevel: 5),
    ];
    final f = builder.build(
      place: palengke,
      now: tuesday,
      allPlaces: all,
      reports: reports,
    );
    expect(f.baseForecast, 0.7);
    expect(f.current.crowdIndex, greaterThan(0.7));
    expect(f.recentReports, hasLength(1));
  });

  test('week has seven days with open-hour slots only', () {
    final f = builder.build(
      place: palengke,
      now: tuesday,
      allPlaces: all,
      reports: const [],
    );
    expect(f.week, hasLength(7));
    expect(f.week.first.openSlots, hasLength(15)); // 4 AM – 7 PM
    expect(f.week.first.quietest.time.hour, 13);
  });

  test('alternatives farther than 3 km are not suggested', () {
    const farQuiet = Place(
      id: 'p3',
      name: 'Far Palengke',
      area: '',
      category: PlaceCategory.palengke,
      lat: 15.20, // ~6.7 km north
      lng: 120.58,
    );
    final f = builder.build(
      place: palengke,
      now: tuesday,
      allPlaces: const [palengke, farQuiet],
      reports: const [],
    );
    expect(f.alternatives, isEmpty);
  });

  test('flags whether the baseline comes from field data', () {
    final withField = PlaceForecastBuilder(
      baseline: baseline,
      hasFieldData: (p) => p.id == 'p1',
    );
    expect(
      withField
          .build(
            place: palengke,
            now: tuesday,
            allPlaces: all,
            reports: const [],
          )
          .usesFieldData,
      isTrue,
    );
    expect(
      builder
          .build(
            place: palengke,
            now: tuesday,
            allPlaces: all,
            reports: const [],
          )
          .usesFieldData,
      isFalse,
    );
  });

  test('a report from a place we think is closed means it is open', () {
    final night = DateTime(2026, 9, 8, 21); // palengke hours end at 7 PM
    final reports = [
      LiveReport(
        placeId: 'p1',
        reportedAt: night.subtract(const Duration(minutes: 5)),
        crowdLevel: 4,
      ),
    ];

    final slot = builder.currentSlot(palengke, night, reports);
    expect(slot.isOpen, isTrue);
    expect(slot.crowdIndex, closeTo(0.75, 1e-9));
    expect(builder.currentSlot(palengke, night, const []).isOpen, isFalse);
  });

  test('crowd level buckets follow the 1–5 scale', () {
    expect(CrowdLevel.fromIndex(0), CrowdLevel.maluwag);
    expect(CrowdLevel.fromIndex(0.5), CrowdLevel.katamtaman);
    expect(CrowdLevel.fromIndex(1), CrowdLevel.siksikan);
  });
}
