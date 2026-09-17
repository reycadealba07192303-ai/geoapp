import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

import 'package:geoapp/data/places_repository.dart';
import 'package:geoapp/data/report_store.dart';
import 'package:geoapp/features/app_state.dart';

import '../fixtures/test_places.dart';

void main() {
  late StreamController<LatLng?> location;
  late ProviderContainer container;

  setUp(() {
    location = StreamController<LatLng?>();
    container = ProviderContainer(
      overrides: [
        userLocationProvider.overrideWith((ref) => location.stream),
        placesSnapshotProvider.overrideWith(
          (ref) async => const PlacesSnapshot(places: testPlaces),
        ),
        reportStoreProvider.overrideWithValue(MemoryReportStore()),
        fieldBaselinesProvider.overrideWith((ref) async => const {}),
      ],
    );
    container.listen(activePlaceIdProvider, (_, _) {});
  });

  tearDown(() {
    container.dispose();
    location.close();
  });

  Future<void> moveTo(double lat, double lng) async {
    location.add(LatLng(lat, lng));
    await container.read(placesSnapshotProvider.future);
    await pumpEventQueue();
  }

  void select(String placeId) {
    final scope = container.read(coverageProvider);
    container.read(selectedPlaceProvider.notifier).state = PlaceSelection(
      placeId: placeId,
      atLat: scope.centerLat,
      atLng: scope.centerLng,
    );
  }

  test('moving changes the scope and the nearest place follows', () async {
    await moveTo(15.1440, 120.5870); // Puregold Angeles
    expect(container.read(activePlaceIdProvider), 'osm-node-1');

    await moveTo(15.1696, 120.5800); // SM City Clark
    expect(container.read(activePlaceIdProvider), 'osm-way-2');
  });

  test('a tapped place stays selected while the user stays nearby', () async {
    await moveTo(15.1440, 120.5870);
    select('osm-node-4');
    expect(container.read(activePlaceIdProvider), 'osm-node-4');
    expect(container.read(showingSelectionProvider), isTrue);

    await moveTo(15.1445, 120.5872); // ~60 m
    expect(container.read(activePlaceIdProvider), 'osm-node-4');
  });

  test('after moving over 1 km the forecast goes back to nearest', () async {
    await moveTo(15.1440, 120.5870);
    select('osm-node-4');

    await moveTo(15.1696, 120.5800); // ~2.9 km away
    expect(container.read(activePlaceIdProvider), 'osm-way-2');
    expect(container.read(showingSelectionProvider), isFalse);
  });
}
