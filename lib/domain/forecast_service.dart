/// Baseline crowd forecast from historical day-of-week × hour patterns.
///
/// Pure Dart — no Flutter imports. Unit-testable without an emulator.
class ForecastService {
  /// Returns a crowd index in \[0.0, 1.0\].
  ///
  /// [baseline] is the seeded historical value for that slot.
  /// Multipliers nudge for holidays / special events (default 1.0 = no change).
  double predict({
    required double baseline,
    double holidayMultiplier = 1.0,
    double eventMultiplier = 1.0,
  }) {
    final raw = baseline * holidayMultiplier * eventMultiplier;
    return raw.clamp(0.0, 1.0);
  }

  /// Map observer 1–5 scale to \[0.0, 1.0\] for training / validation.
  double levelToIndex(int crowdLevel) {
    final clamped = crowdLevel.clamp(1, 5);
    return (clamped - 1) / 4.0;
  }

  /// Inverse of [levelToIndex] for display (1–5).
  int indexToLevel(double index) {
    final clamped = index.clamp(0.0, 1.0);
    return (clamped * 4).round() + 1;
  }
}
