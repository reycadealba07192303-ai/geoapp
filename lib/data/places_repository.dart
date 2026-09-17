import 'package:drift/drift.dart';

import '../core/database/app_database.dart';
import '../core/database/daos.dart';
import '../domain/coverage.dart';
import '../domain/geo.dart';
import '../domain/opening_hours.dart';
import '../domain/place.dart';
import '../domain/place_merge.dart';
import 'backend_places_client.dart';
import 'google_places_client.dart';
import 'overpass_client.dart';

/// Places for the current scope, plus where they came from.
class PlacesSnapshot {
  const PlacesSnapshot({
    required this.places,
    this.fetchedAt,
    this.downloadFailed = false,
    this.fromGoogle = false,
  });

  /// Inside the scope, nearest first.
  final List<Place> places;

  /// When the OpenStreetMap area was last downloaded; null = never.
  final DateTime? fetchedAt;

  /// Nothing could be downloaded — [places] are whatever was cached.
  final bool downloadFailed;

  /// Google Places answered for this scope.
  final bool fromGoogle;
}

/// Google Places (nearest, with photos) merged with OpenStreetMap (wider
/// coverage, cached for offline use).
///
/// Google results live in memory only — Google Maps Platform terms forbid
/// caching them. OpenStreetMap places are stored in the database.
class PlacesRepository {
  PlacesRepository({
    required BranchesDao dao,
    required OverpassClient overpass,
    BackendPlacesClient? backend,
    GooglePlacesClient? google,
    DateTime Function()? clock,
  }) : _dao = dao,
       _overpass = overpass,
       _backend = backend,
       _google = google,
       _clock = clock ?? DateTime.now;

  final BranchesDao _dao;
  final OverpassClient _overpass;
  final BackendPlacesClient? _backend;
  final GooglePlacesClient? _google;
  final DateTime Function() _clock;

  /// Re-download OpenStreetMap areas older than this.
  static const osmMaxAge = Duration(days: 14);

  /// Forces one refresh for devices that cached the older, narrow Overpass
  /// query before we expanded it to all named establishments.
  static final osmExpandedQueryCutover = DateTime(2026, 9, 17, 3, 45);

  /// Download a bit beyond the scope so small moves stay cached.
  static const osmBufferMeters = 3000.0;

  /// Ask Google again after moving this far or waiting this long, so the
  /// "nearest" list stays accurate.
  static const googleRefreshMeters = 1000.0;
  static const googleMaxAge = Duration(minutes: 30);

  _GoogleResult? _lastGoogle;
  Future<void>? _osmDownload;

  /// [onUpdated] fires when a background OpenStreetMap download finishes, so
  /// the caller can ask again for the fuller list.
  Future<PlacesSnapshot> placesFor(
    Coverage scope, {
    void Function()? onUpdated,
  }) async {
    final now = _clock();
    final osmFetch = await _latestOsmFetch(scope);
    final osmStale =
        osmFetch == null ||
        osmFetch.fetchedAt.isBefore(osmExpandedQueryCutover) ||
        now.difference(osmFetch.fetchedAt) >= osmMaxAge;

    final remotePlaces = await _remoteNearby(scope, now);
    var osmFailed = false;

    if (osmStale) {
      final download = _osmDownload ??= _downloadOsm(
        scope,
        now,
      ).whenComplete(() => _osmDownload = null);
      if (remotePlaces != null) {
        // Google already gave us something to show — don't wait.
        download.then((_) => onUpdated?.call(), onError: (_) {});
      } else {
        try {
          await download;
        } catch (_) {
          osmFailed = true;
        }
      }
    }

    final osmPlaces = await _cachedOsm(scope);
    final places = remotePlaces == null
        ? osmPlaces
        : mergePlaces(primary: remotePlaces, secondary: osmPlaces);

    return PlacesSnapshot(
      places: scope.filter(places),
      fetchedAt: osmFetch?.fetchedAt,
      downloadFailed: remotePlaces == null && osmFailed,
      fromGoogle:
          remotePlaces?.any((p) => p.source == PlaceSource.google) ?? false,
    );
  }

  Future<List<Place>?> _remoteNearby(Coverage scope, DateTime now) async {
    final backend = _backend;
    if (backend != null && backend.isConfigured) {
      try {
        return await backend.nearby(
          lat: scope.centerLat,
          lng: scope.centerLng,
          radiusMeters: scope.radiusMeters,
        );
      } catch (_) {
        // Fall through to direct Google, then cached/downloaded OSM.
      }
    }
    return _googleNearby(scope, now);
  }

  Future<List<Place>?> _googleNearby(Coverage scope, DateTime now) async {
    final google = _google;
    if (google == null || !google.isConfigured) return null;

    final last = _lastGoogle;
    if (last != null &&
        now.difference(last.fetchedAt) < googleMaxAge &&
        distanceMeters(last.lat, last.lng, scope.centerLat, scope.centerLng) <
            googleRefreshMeters) {
      return last.places;
    }

    try {
      final places = await google.nearby(
        lat: scope.centerLat,
        lng: scope.centerLng,
        radiusMeters: scope.radiusMeters,
      );
      _lastGoogle = _GoogleResult(
        lat: scope.centerLat,
        lng: scope.centerLng,
        fetchedAt: now,
        places: places,
      );
      return places;
    } catch (_) {
      // Offline or quota — fall back to the last answer, then to OSM.
      return last?.places;
    }
  }

  Future<PlaceFetch?> _latestOsmFetch(Coverage scope) async {
    final covering = (await _dao.allFetches()).where(
      (f) =>
          distanceMeters(
                f.centerLat,
                f.centerLng,
                scope.centerLat,
                scope.centerLng,
              ) +
              scope.radiusMeters <=
          f.radiusMeters,
    );
    if (covering.isEmpty) return null;
    return covering.reduce((a, b) => a.fetchedAt.isAfter(b.fetchedAt) ? a : b);
  }

  Future<void> _downloadOsm(Coverage scope, DateTime now) async {
    final area = Coverage(
      name: scope.name,
      centerLat: scope.centerLat,
      centerLng: scope.centerLng,
      radiusMeters: scope.radiusMeters + osmBufferMeters,
    );
    final places = await _overpass.fetchAround(
      lat: area.centerLat,
      lng: area.centerLng,
      radiusMeters: area.radiusMeters,
    );
    await _dao.saveFetch(
      box: area.box,
      rows: [for (final p in places) _toRow(p)],
      fetch: PlaceFetchesCompanion.insert(
        centerLat: area.centerLat,
        centerLng: area.centerLng,
        radiusMeters: area.radiusMeters,
        fetchedAt: now,
      ),
    );
  }

  Future<List<Place>> _cachedOsm(Coverage scope) async {
    final box = scope.box;
    final rows = await _dao.activeInBox(
      south: box.south,
      west: box.west,
      north: box.north,
      east: box.east,
    );
    return scope.filter(rows.map(_toPlace));
  }

  static BranchesCompanion _toRow(Place p) {
    return BranchesCompanion.insert(
      id: p.id,
      brand: p.brand ?? '',
      name: p.name,
      address: Value(p.area),
      lat: p.lat,
      lng: p.lng,
      category: Value(p.category.name),
      openingHours: Value(p.openingHours),
      phone: Value(p.phone),
      website: Value(p.website),
      operatorName: Value(p.operator),
      email: Value(p.email), cuisine: Value(p.cuisine),
      description: Value(p.description), wheelchair: Value(p.wheelchair),
      outdoorSeating: Value(p.outdoorSeating), internetAccess: Value(p.internetAccess),
      delivery: Value(p.delivery), takeaway: Value(p.takeaway), capacity: Value(p.capacity),
      facebook: Value(p.facebook), instagram: Value(p.instagram),
      isActive: const Value(true),
    );
  }

  static Place _toPlace(Branch row) {
    return Place(
      id: row.id,
      name: row.name,
      area: row.address ?? '',
      category:
          PlaceCategory.values.asNameMap()[row.category] ??
          PlaceCategory.kainan,
      lat: row.lat,
      lng: row.lng,
      brand: row.brand.isEmpty ? null : row.brand,
      openingHours: row.openingHours,
      phone: row.phone,
      website: row.website,
      operator: row.operatorName,
      email: row.email, cuisine: row.cuisine, description: row.description,
      wheelchair: row.wheelchair, outdoorSeating: row.outdoorSeating,
      internetAccess: row.internetAccess, delivery: row.delivery,
      takeaway: row.takeaway, capacity: row.capacity,
      facebook: row.facebook, instagram: row.instagram,
      hours: OpeningHours.parse(row.openingHours),
    );
  }
}

class _GoogleResult {
  const _GoogleResult({
    required this.lat,
    required this.lng,
    required this.fetchedAt,
    required this.places,
  });

  final double lat;
  final double lng;
  final DateTime fetchedAt;
  final List<Place> places;
}
