import 'dart:convert';
import 'dart:io';

import '../domain/place_forecast.dart';

class BackendForecastRow {
  const BackendForecastRow({
    required this.placeId,
    required this.dayOfWeek,
    required this.hour,
    required this.crowdIndex,
    required this.confidence,
  });

  final String placeId;
  final int dayOfWeek;
  final int hour;
  final double crowdIndex;
  final double confidence;
}

class BackendDataClient {
  BackendDataClient({required this.baseUrl});

  final String baseUrl;

  bool get isConfigured => baseUrl.trim().isNotEmpty;

  Uri _uri(String path, [Map<String, String>? query]) {
    final base = Uri.parse(baseUrl);
    final prefix = base.path.endsWith('/')
        ? base.path.substring(0, base.path.length - 1)
        : base.path;
    return base.replace(path: '$prefix$path', queryParameters: query);
  }

  Future<List<LiveReport>> reportsSince(DateTime since) async {
    if (!isConfigured) return const [];
    final json = await _getJson(
      _uri('/reports', {'since': since.toUtc().toIso8601String()}),
    );
    final rows = (json['reports'] as List?) ?? const [];
    return [
      for (final row in rows)
        ?_parseReport((row as Map).cast<String, dynamic>()),
    ];
  }

  Future<void> postReport(LiveReport report) async {
    if (!isConfigured) return;
    await _postJson(_uri('/reports'), {
      'placeId': report.placeId,
      'reportedAt': report.reportedAt.toUtc().toIso8601String(),
      'crowdLevel': report.crowdLevel,
    });
  }

  Future<List<BackendForecastRow>> forecastsFor(List<String> placeIds) async {
    if (!isConfigured || placeIds.isEmpty) return const [];
    final json = await _getJson(
      _uri('/forecasts', {'placeIds': placeIds.join(',')}),
    );
    final rows = (json['forecasts'] as List?) ?? const [];
    return [
      for (final row in rows)
        ?_parseForecast((row as Map).cast<String, dynamic>()),
    ];
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 8);
    try {
      final request = await client.getUrl(uri);
      final response = await request.close().timeout(const Duration(seconds: 20));
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode != HttpStatus.ok) {
        throw BackendDataException('HTTP ${response.statusCode}: $body');
      }
      return jsonDecode(body) as Map<String, dynamic>;
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> _postJson(
    Uri uri,
    Map<String, dynamic> body,
  ) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 8);
    try {
      final request = await client.postUrl(uri);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(body));
      final response = await request.close().timeout(const Duration(seconds: 20));
      final payload = await response.transform(utf8.decoder).join();
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw BackendDataException('HTTP ${response.statusCode}: $payload');
      }
      return jsonDecode(payload) as Map<String, dynamic>;
    } finally {
      client.close();
    }
  }

  static LiveReport? _parseReport(Map<String, dynamic> json) {
    final placeId = json['placeId'] as String?;
    final crowdLevel = json['crowdLevel'] as num?;
    final reportedAt = DateTime.tryParse((json['reportedAt'] as String?) ?? '');
    if (placeId == null || crowdLevel == null || reportedAt == null) {
      return null;
    }
    return LiveReport(
      placeId: placeId,
      reportedAt: reportedAt.toLocal(),
      crowdLevel: crowdLevel.toInt(),
    );
  }

  static BackendForecastRow? _parseForecast(Map<String, dynamic> json) {
    final placeId = json['placeId'] as String?;
    final dayOfWeek = json['dayOfWeek'] as num?;
    final hour = json['hour'] as num?;
    final crowdIndex = json['crowdIndex'] as num?;
    if (placeId == null ||
        dayOfWeek == null ||
        hour == null ||
        crowdIndex == null) {
      return null;
    }
    return BackendForecastRow(
      placeId: placeId,
      dayOfWeek: dayOfWeek.toInt(),
      hour: hour.toInt(),
      crowdIndex: crowdIndex.toDouble(),
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.5,
    );
  }
}

class BackendDataException implements Exception {
  const BackendDataException(this.message);

  final String message;

  @override
  String toString() => 'BackendDataException: $message';
}
