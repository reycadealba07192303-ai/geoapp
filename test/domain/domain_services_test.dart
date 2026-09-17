import 'package:flutter_test/flutter_test.dart';
import 'package:geoapp/domain/forecast_service.dart';
import 'package:geoapp/domain/fusion_service.dart';
import 'package:geoapp/domain/recommendation_service.dart';

void main() {
  group('ForecastService', () {
    final svc = ForecastService();

    test('clamps prediction to 0–1', () {
      expect(svc.predict(baseline: 0.9, holidayMultiplier: 2.0), 1.0);
      expect(svc.predict(baseline: 0.1, holidayMultiplier: 0.0), 0.0);
    });

    test('maps crowd level 1–5 to index', () {
      expect(svc.levelToIndex(1), 0.0);
      expect(svc.levelToIndex(5), 1.0);
      expect(svc.levelToIndex(3), 0.5);
    });
  });

  group('FusionService', () {
    final fusion = FusionService(alpha: 0.5, halfLifeMinutes: 60);

    test('returns forecast when no reports', () {
      expect(
        fusion.fuse(
          forecastIndex: 0.4,
          reportIndexes: const [],
          reportAges: const [],
        ),
        0.4,
      );
    });

    test('pulls toward fresh busy report', () {
      final fused = fusion.fuse(
        forecastIndex: 0.2,
        reportIndexes: const [1.0],
        reportAges: const [Duration.zero],
      );
      expect(fused, greaterThan(0.2));
      expect(fused, lessThan(1.0));
    });

    test('old reports decay toward forecast', () {
      final fresh = fusion.fuse(
        forecastIndex: 0.2,
        reportIndexes: const [1.0],
        reportAges: const [Duration.zero],
      );
      final stale = fusion.fuse(
        forecastIndex: 0.2,
        reportIndexes: const [1.0],
        reportAges: const [Duration(hours: 6)],
      );
      expect(stale, lessThan(fresh));
      expect(stale, closeTo(0.2, 0.15));
    });
  });

  group('RecommendationService', () {
    final rec = RecommendationService();

    test('finds quietest hour', () {
      final best = rec.findBestTimeToGo({11: 0.8, 14: 0.3, 18: 0.9});
      expect(best?.hour, 14);
      expect(best?.crowdIndex, 0.3);
    });

    test('ranks quieter alternatives', () {
      final ranked = rec.rankQuieterAlternatives([
        const RankedBranch(
          branchId: 'a',
          name: 'A',
          brand: 'X',
          crowdIndex: 0.9,
        ),
        const RankedBranch(
          branchId: 'b',
          name: 'B',
          brand: 'Y',
          crowdIndex: 0.2,
        ),
      ]);
      expect(ranked.first.branchId, 'b');
    });
  });
}
