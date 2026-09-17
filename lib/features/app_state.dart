import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../core/config.dart';
import '../core/providers.dart';
import '../core/settings/app_settings.dart';
import '../data/backend_data_client.dart';
import '../data/backend_places_client.dart';
import '../data/estimate_baseline.dart';
import '../data/google_places_client.dart';
import '../data/overpass_client.dart';
import '../data/places_repository.dart';
import '../data/report_store.dart';
import '../data/study_area.dart';
import '../domain/coverage.dart';
import '../domain/geo.dart';
import '../domain/place.dart';
import '../domain/place_forecast.dart';

enum AppTab { forecast, map, list }

final tabProvider = StateProvider<AppTab>((ref) => AppTab.forecast);

/// Live GPS fix, updated as the user moves. Emits null when permission is
/// denied or location is off. Invalidate to ask again.
final userLocationProvider = StreamProvider<LatLng?>((ref) async* {
  final service = ref.watch(locationServiceProvider);
  LatLng toLatLng(dynamic p) => LatLng(p.latitude, p.longitude);

  try {
    if (!await service.ensurePermission()) {
      yield null;
      return;
    }
    final first =
        await service.lastKnownPosition() ?? await service.currentPosition();
    yield first == null ? null : toLatLng(first);
  } catch (_) {
    yield null;
    return;
  }

  yield* service.positionStream().map(toLatLng).handleError((_) {});
});

/// 10 km around the user once location is on; Angeles City until then.
final coverageProvider = Provider<Coverage>((ref) {
  final user = ref.watch(userLocationProvider).valueOrNull;
  if (user == null) return defaultCoverage;
  return Coverage(
    name: 'Iyong lokasyon',
    centerLat: user.latitude,
    centerLng: user.longitude,
    radiusMeters: ref.watch(settingsProvider).scopeKm * 1000.0,
    followsUser: true,
  );
});

final googlePlacesClientProvider = Provider<GooglePlacesClient>((ref) {
  return GooglePlacesClient(apiKey: googleMapsApiKey);
});

final backendPlacesClientProvider = Provider<BackendPlacesClient>((ref) {
  return BackendPlacesClient(baseUrl: backendBaseUrl);
});

final backendDataClientProvider = Provider<BackendDataClient>((ref) {
  return BackendDataClient(baseUrl: backendBaseUrl);
});

final placesRepositoryProvider = Provider<PlacesRepository>((ref) {
  return PlacesRepository(
    dao: ref.watch(appDatabaseProvider).branchesDao,
    overpass: OverpassClient(),
    backend: ref.watch(backendPlacesClientProvider),
    google: ref.watch(googlePlacesClientProvider),
  );
});

/// Real places for the scope: Google Places (nearest, photos) + cached
/// OpenStreetMap. Refreshes itself when a background download lands.
final placesSnapshotProvider = FutureProvider<PlacesSnapshot>((ref) async {
  var alive = true;
  ref.onDispose(() => alive = false);

  // Wait for the first GPS answer so we don't download the default area
  // just before the user's own location arrives.
  await ref.watch(userLocationProvider.future);
  final scope = ref.watch(coverageProvider);
  return ref
      .watch(placesRepositoryProvider)
      .placesFor(
        scope,
        onUpdated: () {
          if (alive) ref.invalidateSelf();
        },
      );
});

/// Places inside the scope, nearest first.
final placesProvider = Provider<List<Place>>((ref) {
  final snapshot = ref.watch(placesSnapshotProvider).valueOrNull;
  return ref.watch(coverageProvider).filter(snapshot?.places ?? const []);
});

final placesByIdProvider = Provider<Map<String, Place>>((ref) {
  return {for (final p in ref.watch(placesProvider)) p.id: p};
});

/// Shared by the map and list tabs. `null` = all categories.
final categoryFilterProvider = StateProvider<PlaceCategory?>((ref) => null);

final filteredPlacesProvider = Provider<List<Place>>((ref) {
  final filter = ref.watch(categoryFilterProvider);
  return [
    for (final p in ref.watch(placesProvider))
      if (filter == null || p.category == filter) p,
  ];
});

/// A place the user tapped, and where they were when they tapped it.
class PlaceSelection {
  const PlaceSelection({
    required this.placeId,
    required this.atLat,
    required this.atLng,
  });

  final String placeId;
  final double atLat;
  final double atLng;
}

/// What the user tapped last. `null` = nearest place.
final selectedPlaceProvider = StateProvider<PlaceSelection?>((ref) => null);

/// After moving this far, the Forecast tab goes back to the nearest place.
const selectionResetMeters = 1000.0;

/// Place shown on the Forecast tab: the selection while it is still in scope
/// and the user hasn't moved away, else the nearest place, else null.
final activePlaceIdProvider = Provider<String?>((ref) {
  final places = ref.watch(placesProvider);
  if (places.isEmpty) return null;

  final selection = ref.watch(selectedPlaceProvider);
  final scope = ref.watch(coverageProvider);
  final stillHere =
      selection != null &&
      distanceMeters(
            selection.atLat,
            selection.atLng,
            scope.centerLat,
            scope.centerLng,
          ) <
          selectionResetMeters;

  return stillHere &&
          ref.watch(placesByIdProvider).containsKey(selection.placeId)
      ? selection.placeId
      : places.first.id;
});

/// True when the Forecast tab shows something other than the nearest place.
final showingSelectionProvider = Provider<bool>((ref) {
  final places = ref.watch(placesProvider);
  final active = ref.watch(activePlaceIdProvider);
  return active != null && places.isNotEmpty && active != places.first.id;
});

/// Ticked by the app shell once a minute.
final nowProvider = StateProvider<DateTime>((ref) => DateTime.now());

final reportStoreProvider = Provider<ReportStore>((ref) {
  return BackendReportStore(
    local: DriftReportStore(ref.watch(appDatabaseProvider).userReportsDao),
    backend: ref.watch(backendDataClientProvider),
  );
});

/// Recent crowd reports, persisted so they survive restarts.
final liveReportsProvider =
    NotifierProvider<LiveReportsNotifier, List<LiveReport>>(
      LiveReportsNotifier.new,
    );

class LiveReportsNotifier extends Notifier<List<LiveReport>> {
  var _alive = true;

  @override
  List<LiveReport> build() {
    _alive = true;
    _load();
    final reportsTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _load(),
    );
    final forecastTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => ref.invalidate(fieldBaselinesProvider),
    );
    ref.onDispose(() {
      _alive = false;
      reportsTimer.cancel();
      forecastTimer.cancel();
    });
    return const [];
  }

  Future<void> _load() async {
    final since = DateTime.now().subtract(PlaceForecastBuilder.reportWindow);
    final saved = await ref.read(reportStoreProvider).since(since);
    if (!_alive) return;
    // Keep anything reported while loading; DB times are whole seconds.
    String key(LiveReport r) =>
        '${r.placeId}@${r.reportedAt.millisecondsSinceEpoch ~/ 1000}';
    state = {
      for (final r in [...saved, ...state]) key(r): r,
    }.values.toList();
  }

  Future<void> add({required String placeId, required int crowdLevel}) async {
    final report = LiveReport(
      placeId: placeId,
      reportedAt: DateTime.now(),
      crowdLevel: crowdLevel,
    );
    state = [...state, report];
    await ref.read(reportStoreProvider).save(report);
  }
}

/// Field-data baselines (Forecasts table, from the pipeline): placeId →
/// (weekday × 24 + hour) → crowd index. Empty until field data is imported.
final fieldBaselinesProvider = FutureProvider<Map<String, Map<int, double>>>((
  ref,
) async {
  final places = ref.watch(placesProvider);
  final backend = ref.watch(backendDataClientProvider);
  if (backend.isConfigured && places.isNotEmpty) {
    try {
      final rows = await backend.forecastsFor([for (final p in places) p.id]);
      if (rows.isNotEmpty) {
        final baselines = <String, Map<int, double>>{};
        for (final r in rows) {
          (baselines[r.placeId] ??= {})[r.dayOfWeek * 24 + r.hour] =
              r.crowdIndex;
        }
        return baselines;
      }
    } catch (_) {
      // Fall back to local field-data baselines.
    }
  }

  final rows = await ref.watch(appDatabaseProvider).forecastsDao.all();
  final baselines = <String, Map<int, double>>{};
  for (final r in rows) {
    (baselines[r.branchId] ??= {})[r.dayOfWeek * 24 + r.hour] = r.crowdIndex;
  }
  return baselines;
});

final placeForecastBuilderProvider = Provider<PlaceForecastBuilder>((ref) {
  final field = ref.watch(fieldBaselinesProvider).valueOrNull ?? const {};
  return PlaceForecastBuilder(
    baseline: (place, day, hour) =>
        field[place.id]?[day * 24 + hour] ?? estimateBaseline(place, day, hour),
    hasFieldData: (place) => field.containsKey(place.id),
    forecast: ref.watch(forecastServiceProvider),
    fusion: ref.watch(fusionServiceProvider),
    recommendation: ref.watch(recommendationServiceProvider),
  );
});

Place _placeById(Ref ref, String placeId) {
  final place = ref.watch(placesByIdProvider)[placeId];
  if (place == null) throw StateError('Place $placeId is not in scope');
  return place;
}

final placeForecastProvider = Provider.family<PlaceForecast, String>((
  ref,
  placeId,
) {
  return ref
      .watch(placeForecastBuilderProvider)
      .build(
        place: _placeById(ref, placeId),
        now: ref.watch(nowProvider),
        allPlaces: ref.watch(placesProvider),
        reports: ref.watch(liveReportsProvider),
      );
});

/// Current hour only — for map pins and list rows.
final currentSlotProvider = Provider.family<HourSlot, String>((ref, placeId) {
  return ref
      .watch(placeForecastBuilderProvider)
      .currentSlot(
        _placeById(ref, placeId),
        ref.watch(nowProvider),
        ref.watch(liveReportsProvider),
      );
});

void selectPlace(WidgetRef ref, String placeId) {
  final scope = ref.read(coverageProvider);
  ref.read(selectedPlaceProvider.notifier).state = PlaceSelection(
    placeId: placeId,
    atLat: scope.centerLat,
    atLng: scope.centerLng,
  );
}

/// Show a place on the Forecast tab.
void openForecast(WidgetRef ref, String placeId) {
  selectPlace(ref, placeId);
  ref.read(tabProvider.notifier).state = AppTab.forecast;
}
