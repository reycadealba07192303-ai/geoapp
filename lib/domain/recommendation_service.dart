/// Finds quieter times and nearby alternatives.
///
/// Pure Dart — no Flutter imports.
class RecommendationService {
  /// Lowest forecast slot for a branch across the given hourly series.
  ///
  /// [hourlyIndexes] maps hour (0–23) → crowd index.
  BestTime? findBestTimeToGo(Map<int, double> hourlyIndexes) {
    if (hourlyIndexes.isEmpty) return null;

    MapEntry<int, double>? best;
    for (final entry in hourlyIndexes.entries) {
      if (best == null || entry.value < best.value) {
        best = entry;
      }
    }

    return BestTime(hour: best!.key, crowdIndex: best.value);
  }

  /// Rank branches by fused crowd index ascending (quietest first).
  List<RankedBranch> rankQuieterAlternatives(
    List<RankedBranch> candidates, {
    int limit = 5,
  }) {
    final sorted = [...candidates]
      ..sort((a, b) => a.crowdIndex.compareTo(b.crowdIndex));
    return sorted.take(limit).toList();
  }
}

class BestTime {
  const BestTime({required this.hour, required this.crowdIndex});

  final int hour;
  final double crowdIndex;
}

class RankedBranch {
  const RankedBranch({
    required this.branchId,
    required this.name,
    required this.brand,
    required this.crowdIndex,
    this.distanceMeters,
  });

  final String branchId;
  final String name;
  final String brand;
  final double crowdIndex;
  final double? distanceMeters;
}
