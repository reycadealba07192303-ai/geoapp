import 'dart:convert';
import 'dart:io';

import '../domain/place.dart';
import '../domain/opening_hours.dart';

/// GeoApp backend proxy for place discovery.
///
/// Expected response:
/// `{ "places": [{ "id": "...", "name": "...", "lat": 0, "lng": 0, ... }] }`
class BackendPlacesClient {
  BackendPlacesClient({required this.baseUrl});

  final String baseUrl;

  bool get isConfigured => baseUrl.trim().isNotEmpty;

  Future<List<Place>> nearby({
    required double lat,
    required double lng,
    required double radiusMeters,
  }) async {
    if (!isConfigured) return const [];
    final uri = Uri.parse(baseUrl).replace(
      path: '${Uri.parse(baseUrl).path}/places/nearby'.replaceAll('//', '/'),
      queryParameters: {
        'lat': '$lat',
        'lng': '$lng',
        'radius': '${radiusMeters.round()}',
      },
    );

    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 8);
    try {
      final request = await client.getUrl(uri);
      final response = await request.close().timeout(const Duration(seconds: 20));
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode != HttpStatus.ok) {
        throw BackendPlacesException('HTTP ${response.statusCode}: $body');
      }

      final json = jsonDecode(body) as Map<String, dynamic>;
      final rows = (json['places'] as List?) ?? const [];
      return [
        for (final row in rows)
          ?_parsePlace((row as Map).cast<String, dynamic>()),
      ];
    } finally {
      client.close();
    }
  }

  static Place? _parsePlace(Map<String, dynamic> json) {
    final id = (json['id'] as String?)?.trim();
    final name = (json['name'] as String?)?.trim();
    final lat = json['lat'] as num?;
    final lng = json['lng'] as num?;
    final categoryName = json['category'] as String?;
    if (id == null ||
        id.isEmpty ||
        name == null ||
        name.isEmpty ||
        lat == null ||
        lng == null) {
      return null;
    }

    final source = switch (json['source'] as String?) {
      'google' => PlaceSource.google,
      _ => PlaceSource.osm,
    };

    return Place(
      id: id,
      name: name,
      area: (json['area'] as String?) ?? '',
      category:
          PlaceCategory.values.asNameMap()[categoryName] ?? PlaceCategory.kainan,
      lat: lat.toDouble(),
      lng: lng.toDouble(),
      brand: json['brand'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      operator: json['operator'] as String?,
      email: json['email'] as String?,
      cuisine: json['cuisine'] as String?,
      description: json['description'] as String?,
      wheelchair: json['wheelchair'] as String?,
      outdoorSeating: json['outdoorSeating'] as String?,
      internetAccess: json['internetAccess'] as String?,
      delivery: json['delivery'] as String?,
      takeaway: json['takeaway'] as String?,
      capacity: json['capacity'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      openingHours: json['openingHours'] as String?,
      hours: OpeningHours.parse(json['openingHours'] as String?),
      source: source,
      photoName: json['photoName'] as String?,
      photoAuthor: json['photoAuthor'] as String?,
    );
  }
}

class BackendPlacesException implements Exception {
  const BackendPlacesException(this.message);

  final String message;

  @override
  String toString() => 'BackendPlacesException: $message';
}
