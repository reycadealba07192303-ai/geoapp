import 'dart:math' as math;

/// Fuses historical forecast with recent user reports.
///
/// Formula (defense-ready):
///   finalIndex = (1 - α_eff) * forecast + α_eff * reportMean
///   α_eff = α * decay(age)
///
/// Pure Dart — no Flutter imports.
class FusionService {
  FusionService({this.alpha = 0.35, this.halfLifeMinutes = 45});

  /// How much live reports can pull the forecast (0–1).
  final double alpha;

  /// Report weight halves every this many minutes.
  final double halfLifeMinutes;

  /// Exponential decay of a report's influence by age.
  double decay(Duration age) {
    if (age.isNegative) return 1.0;
    final minutes = age.inSeconds / 60.0;
    return math.pow(0.5, minutes / halfLifeMinutes).toDouble();
  }

  /// Fuse forecast with zero or more recent reports.
  ///
  /// [reportIndexes] are 0–1 values; [reportAges] aligned by index.
  /// If there are no reports, returns [forecastIndex] unchanged.
  double fuse({
    required double forecastIndex,
    required List<double> reportIndexes,
    required List<Duration> reportAges,
  }) {
    assert(reportIndexes.length == reportAges.length);

    if (reportIndexes.isEmpty) {
      return forecastIndex.clamp(0.0, 1.0);
    }

    var weightSum = 0.0;
    var weighted = 0.0;
    for (var i = 0; i < reportIndexes.length; i++) {
      final w = decay(reportAges[i]);
      weightSum += w;
      weighted += reportIndexes[i] * w;
    }

    if (weightSum <= 0) {
      return forecastIndex.clamp(0.0, 1.0);
    }

    final reportMean = weighted / weightSum;
    final meanDecay = weightSum / reportIndexes.length;
    final alphaEff = (alpha * meanDecay).clamp(0.0, 1.0);

    final fused = (1 - alphaEff) * forecastIndex + alphaEff * reportMean;
    return fused.clamp(0.0, 1.0);
  }
}
