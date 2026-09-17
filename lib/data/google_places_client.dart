import 'dart:convert';
import 'dart:io';

import '../domain/place.dart';
import 'google_places_parser.dart';

/// Places API (New) — nearest places per category, with photos.
///
/// Results must not be cached (Google Maps Platform terms), so callers keep
/// them in memory only.
class GooglePlacesClient {
  GooglePlacesClient({required this.apiKey});

  final String apiKey;

  bool get isConfigured => apiKey.isNotEmpty;

  /// One request per category, in parallel. Fails only if every request fails.
  Future<List<Place>> nearby({
    required double lat,
    required double lng,
    required double radiusMeters,
  }) async {
    Object? lastError;
    final results = await Future.wait([
      for (final category in PlaceCategory.values)
        if (GooglePlacesParser.typesFor[category]!.isNotEmpty)
          _search(category, lat, lng, radiusMeters).catchError((Object e) {
            lastError = e;
            return <Place>[];
          }),
    ]);
    if (lastError != null && results.every((r) => r.isEmpty)) {
      throw GooglePlacesException('$lastError');
    }

    final byId = <String, Place>{};
    for (final place in results.expand((r) => r)) {
      byId.putIfAbsent(place.id, () => place);
    }
    return byId.values.toList();
  }

  /// Image URL for a photo resource name (loaded straight into Image.network).
  String photoUrl(String photoName, {int maxWidthPx = 800}) =>
      'https://places.googleapis.com/v1/$photoName/media'
      '?maxWidthPx=$maxWidthPx&key=$apiKey';

  Future<List<Place>> _search(
    PlaceCategory category,
    double lat,
    double lng,
    double radiusMeters,
  ) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 15);
    try {
      final request = await client.postUrl(
        Uri.parse(GooglePlacesParser.endpoint),
      );
      request.headers
        ..contentType = ContentType.json
        ..set('X-Goog-Api-Key', apiKey)
        ..set('X-Goog-FieldMask', GooglePlacesParser.fieldMask);
      request.write(
        jsonEncode(
          GooglePlacesParser.requestBody(
            category: category,
            lat: lat,
            lng: lng,
            radiusMeters: radiusMeters,
          ),
        ),
      );
      final response = await request.close().timeout(
        const Duration(seconds: 20),
      );
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode != HttpStatus.ok) {
        throw GooglePlacesException('HTTP ${response.statusCode}: $body');
      }
      return GooglePlacesParser.parseResponse(body, category);
    } finally {
      client.close();
    }
  }
}

class GooglePlacesException implements Exception {
  const GooglePlacesException(this.message);

  final String message;

  @override
  String toString() => 'GooglePlacesException: $message';
}
