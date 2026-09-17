import 'geo.dart';
import 'place.dart';

/// Combines two place lists, dropping [secondary] places that look like a
/// place already in [primary] (same spot, similar name).
///
/// Pure Dart — no Flutter imports.
List<Place> mergePlaces({
  required List<Place> primary,
  required List<Place> secondary,
  double sameSpotMeters = 120,
}) {
  final keep = [...primary];
  for (final candidate in secondary) {
    final duplicate = primary.any(
      (p) =>
          distanceMeters(p.lat, p.lng, candidate.lat, candidate.lng) <=
              sameSpotMeters &&
          namesMatch(p.name, candidate.name),
    );
    if (!duplicate) keep.add(candidate);
  }
  return keep;
}

const _genericWords = {
  'the', 'and', 'of', 'ng', 'sa', 'at', //
  'cafe', 'café', 'coffee', 'restaurant', 'resto', 'kainan', 'eatery',
  'store', 'shop', 'branch', 'market', 'public', 'mall', 'supermarket',
  'city', 'inc', 'corp',
};

List<String> _tokens(String name) => name
    .toLowerCase()
    .replaceAll(RegExp(r"[’'`]"), '')
    .split(RegExp(r'[^a-z0-9ñé]+'))
    .where((t) => t.length >= 3 && !_genericWords.contains(t))
    .toList();

/// "Jollibee" ≈ "Jollibee Sto. Rosario", "McDonald's" ≈ "Mcdonalds Dau".
bool namesMatch(String a, String b) {
  final ta = _tokens(a);
  final tb = _tokens(b);
  if (ta.isEmpty || tb.isEmpty) {
    return a.trim().toLowerCase() == b.trim().toLowerCase();
  }
  return ta.any(tb.contains);
}
