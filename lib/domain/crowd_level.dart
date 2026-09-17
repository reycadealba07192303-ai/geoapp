import 'forecast_service.dart';

/// Human-readable crowd buckets, aligned with the observer 1–5 scale.
///
/// Pure Dart — no Flutter imports.
enum CrowdLevel {
  maluwag('Maluwag', 'Walang pila, dumiretso'),
  kaunti('Kaunti', 'Kaunting tao, mabilis'),
  katamtaman('Katamtaman', 'Normal na dami ng tao'),
  mataong('Mataong', 'Asahan ang pila'),
  siksikan('Siksikan', 'Iwasan kung pwede');

  const CrowdLevel(this.label, this.advice);

  final String label;
  final String advice;

  /// 1 = maluwag … 5 = siksikan.
  int get scale => index + 1;

  static CrowdLevel fromIndex(double crowdIndex) {
    return values[ForecastService().indexToLevel(crowdIndex) - 1];
  }
}
