import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Branches, PlaceFetches, Forecasts, Observations, UserReports],
  daos: [BranchesDao, ForecastsDao, ObservationsDao, UserReportsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        // v2: real places from OpenStreetMap.
        await m.addColumn(branches, branches.category);
        await m.addColumn(branches, branches.openingHours);
        await m.createTable(placeFetches);
      }
      if (from < 3) {
        await m.addColumn(branches, branches.phone);
        await m.addColumn(branches, branches.website);
        await m.addColumn(branches, branches.operatorName);
      }
      if (from < 4) {
        for (final column in [
          branches.email, branches.cuisine, branches.description,
          branches.wheelchair, branches.outdoorSeating, branches.internetAccess,
          branches.delivery, branches.takeaway, branches.capacity,
          branches.facebook, branches.instagram,
        ]) {
          await m.addColumn(branches, column);
        }
      }
      if (from < 5) {
        await m.addColumn(forecasts, forecasts.sampleCount);
        await m.addColumn(forecasts, forecasts.source);
        await m.addColumn(forecasts, forecasts.lastUpdated);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'geoapp.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
