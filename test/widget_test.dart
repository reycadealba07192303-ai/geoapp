import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';

import 'package:geoapp/core/settings/app_settings.dart';
import 'package:geoapp/data/places_repository.dart';
import 'package:geoapp/data/report_store.dart';
import 'package:geoapp/features/app_state.dart';
import 'package:geoapp/main.dart';

import 'fixtures/test_places.dart';

void main() {
  Widget app({
    required DateTime now,
    LatLng? user,
    PlacesSnapshot snapshot = const PlacesSnapshot(places: testPlaces),
    ReportStore? reports,
    SettingsStore? settings,
  }) {
    return ProviderScope(
      overrides: [
        nowProvider.overrideWith((ref) => now),
        userLocationProvider.overrideWith((ref) => Stream.value(user)),
        placesSnapshotProvider.overrideWith((ref) async => snapshot),
        reportStoreProvider.overrideWithValue(reports ?? MemoryReportStore()),
        fieldBaselinesProvider.overrideWith((ref) async => const {}),
        settingsStoreProvider.overrideWithValue(
          settings ?? MemorySettingsStore(),
        ),
      ],
      child: const GeoApp(),
    );
  }

  testWidgets('without location, scope falls back to Angeles City', (
    tester,
  ) async {
    await tester.pumpWidget(app(now: DateTime(2026, 9, 15, 14)));
    await tester.pumpAndSettle();

    // Nearest to the Angeles City center.
    expect(find.text('Puregold Angeles'), findsOneWidget);
    expect(find.text('Angeles City · Turn on location'), findsOneWidget);
    expect(find.text('Estimate'), findsWidgets);
    expect(find.text('Payday +15%'), findsOneWidget);
  });

  testWidgets('user location is the center: nearest place is shown', (
    tester,
  ) async {
    // Standing at SM City Clark.
    await tester.pumpWidget(
      app(
        now: DateTime(2026, 9, 16, 12),
        user: const LatLng(15.1696, 120.5800),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('SM City Clark'), findsOneWidget);
    expect(find.text('Near you · 10 km'), findsOneWidget);
  });

  testWidgets('nothing within 10 km of the user shows an empty state', (
    tester,
  ) async {
    // Naga City — far from the fixture places.
    await tester.pumpWidget(
      app(
        now: DateTime(2026, 9, 16, 12),
        user: const LatLng(13.6218, 123.1948),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No places within 10 km'), findsOneWidget);
  });

  testWidgets('first launch offline asks for internet', (tester) async {
    await tester.pumpWidget(
      app(
        now: DateTime(2026, 9, 16, 12),
        snapshot: const PlacesSnapshot(places: [], downloadFailed: true),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Internet needed'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('closed place shows Closed', (tester) async {
    await tester.pumpWidget(app(now: DateTime(2026, 9, 16, 23)));
    await tester.pumpAndSettle();

    expect(find.text('Closed'), findsWidgets);
  });

  testWidgets('switching to Filipino translates the app', (tester) async {
    final settings = MemorySettingsStore();
    await tester.pumpWidget(
      app(now: DateTime(2026, 9, 16, 15), settings: settings),
    );
    await tester.pumpAndSettle();
    expect(find.text('Report crowd'), findsOneWidget);

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Filipino'));
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.text('Settings'))).pop();
    await tester.pumpAndSettle();

    expect(find.text('I-report ang dami ng tao'), findsOneWidget);
    expect(find.text('Listahan'), findsNothing); // nav shows only active label
    expect(find.text('Forecast'), findsWidgets);
    expect((await settings.load())?['language'], 'filipino');
  });

  testWidgets('list tab filters coffee shops and opens the forecast', (
    tester,
  ) async {
    await tester.pumpWidget(app(now: DateTime(2026, 9, 16, 15)));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.format_list_bulleted_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Coffee shop'));
    await tester.pumpAndSettle();

    expect(find.text('Puregold Angeles'), findsNothing);
    await tester.tap(find.text('Starbucks Marquee'));
    await tester.pumpAndSettle();

    expect(find.text('Starbucks Marquee'), findsOneWidget);
    expect(find.text('Show nearest to me'), findsOneWidget);
  });

  testWidgets('report from the nav bar is anonymous and says Data added', (
    tester,
  ) async {
    final store = MemoryReportStore();
    // 11 PM: Puregold looks closed, but reporting is still allowed.
    final now = DateTime.now();
    await tester.pumpWidget(
      app(now: DateTime(now.year, now.month, now.day, 23), reports: store),
    );
    await tester.pumpAndSettle();

    // The round Report button in the nav bar.
    await tester.tap(find.byTooltip('Report crowd'));
    await tester.pumpAndSettle();
    expect(find.text('How crowded is it now?'), findsOneWidget);
    expect(find.text('Puregold Angeles'), findsWidgets);

    await tester.tap(find.text('Packed'));
    await tester.pump();
    await tester.tap(find.text('Post anonymously'));
    await tester.pumpAndSettle();

    final saved = await store.since(DateTime(2000));
    expect(saved.single.placeId, 'osm-node-1');
    expect(saved.single.crowdLevel, 5);
    expect(find.text('Data added'), findsOneWidget);
  });
}
