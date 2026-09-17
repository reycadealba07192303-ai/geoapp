import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import '../domain/place.dart';
import 'osm_place_parser.dart';

/// Downloads real places from OpenStreetMap via public Overpass servers.
class OverpassClient {
  OverpassClient({
    this.endpoints = const [
      'https://overpass.kumi.systems/api/interpreter',
      'https://overpass.private.coffee/api/interpreter',
      'https://overpass-api.de/api/interpreter',
    ],
    this.userAgent = 'GeoApp/1.0 (com.geoapp.geoapp)',
  });

  /// Queried at the same time — public servers are often slow or down, so
  /// the first good answer wins.
  final List<String> endpoints;
  final String userAgent;

  Future<List<Place>> fetchAround({
    required double lat,
    required double lng,
    required double radiusMeters,
  }) {
    final query = OsmPlaceParser.query(
      lat: lat,
      lng: lng,
      radiusMeters: radiusMeters,
    );
    return firstSuccess([
      for (final endpoint in endpoints)
        () async {
          final body = await _post(endpoint, query);
          // Responses can be a few MB — parse off the UI thread.
          return Isolate.run(() => OsmPlaceParser.parseResponse(body));
        },
    ]);
  }

  Future<String> _post(String endpoint, String query) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 15)
      ..userAgent = userAgent;
    try {
      final request = await client.postUrl(Uri.parse(endpoint));
      request.headers.contentType = ContentType(
        'application',
        'x-www-form-urlencoded',
        charset: 'utf-8',
      );
      request.write('data=${Uri.encodeQueryComponent(query)}');
      final response = await request.close().timeout(
        const Duration(seconds: 60),
      );
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode != HttpStatus.ok) {
        throw HttpException('Overpass HTTP ${response.statusCode}');
      }
      return body;
    } finally {
      client.close();
    }
  }
}

/// Runs all [tasks] at once; completes with the first success, or with an
/// error once every task has failed.
Future<T> firstSuccess<T>(List<Future<T> Function()> tasks) {
  final completer = Completer<T>();
  var failures = 0;
  for (final task in tasks) {
    task().then(
      (value) {
        if (!completer.isCompleted) completer.complete(value);
      },
      onError: (Object error) {
        failures++;
        if (failures == tasks.length && !completer.isCompleted) {
          completer.completeError(OverpassException('$error'));
        }
      },
    );
  }
  return completer.future;
}

class OverpassException implements Exception {
  const OverpassException(this.message);

  final String message;

  @override
  String toString() => 'OverpassException: $message';
}
