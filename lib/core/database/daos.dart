import 'package:drift/drift.dart';

import 'app_database.dart';
import 'tables.dart';

part 'daos.g.dart';

@DriftAccessor(
  tables: [Branches, PlaceFetches, Forecasts, Observations, UserReports],
)
class BranchesDao extends DatabaseAccessor<AppDatabase>
    with _$BranchesDaoMixin {
  BranchesDao(super.db);

  Future<List<Branch>> getAllActive() {
    return (select(branches)..where((t) => t.isActive.equals(true))).get();
  }

  Future<Branch?> getById(String id) {
    return (select(branches)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<List<Branch>> watchAllActive() {
    return (select(branches)..where((t) => t.isActive.equals(true))).watch();
  }

  Future<void> upsertAll(List<BranchesCompanion> rows) async {
    await batch((b) => b.insertAllOnConflictUpdate(branches, rows));
  }

  Future<List<Branch>> activeInBox({
    required double south,
    required double west,
    required double north,
    required double east,
  }) {
    return (select(branches)..where(
          (t) =>
              t.isActive.equals(true) &
              t.lat.isBetweenValues(south, north) &
              t.lng.isBetweenValues(west, east),
        ))
        .get();
  }

  Future<List<PlaceFetch>> allFetches() => select(placeFetches).get();

  /// Replaces the cached places inside the fetched box: places missing from
  /// the new download (closed / removed on OSM) are deactivated.
  Future<void> saveFetch({
    required ({double south, double west, double north, double east}) box,
    required List<BranchesCompanion> rows,
    required PlaceFetchesCompanion fetch,
  }) {
    return transaction(() async {
      await (update(branches)..where(
            (t) =>
                t.lat.isBetweenValues(box.south, box.north) &
                t.lng.isBetweenValues(box.west, box.east),
          ))
          .write(const BranchesCompanion(isActive: Value(false)));
      await batch((b) => b.insertAllOnConflictUpdate(branches, rows));
      await into(placeFetches).insert(fetch);
    });
  }
}

@DriftAccessor(
  tables: [Branches, PlaceFetches, Forecasts, Observations, UserReports],
)
class ForecastsDao extends DatabaseAccessor<AppDatabase>
    with _$ForecastsDaoMixin {
  ForecastsDao(super.db);

  Future<List<Forecast>> forBranch(String branchId) {
    return (select(forecasts)..where((t) => t.branchId.equals(branchId))).get();
  }

  Future<Forecast?> forSlot({
    required String branchId,
    required int dayOfWeek,
    required int hour,
  }) {
    return (select(forecasts)..where(
          (t) =>
              t.branchId.equals(branchId) &
              t.dayOfWeek.equals(dayOfWeek) &
              t.hour.equals(hour),
        ))
        .getSingleOrNull();
  }

  Future<List<Forecast>> all() => select(forecasts).get();

  Future<void> insertAll(List<ForecastsCompanion> rows) async {
    await batch((b) => b.insertAll(forecasts, rows));
  }
}

@DriftAccessor(
  tables: [Branches, PlaceFetches, Forecasts, Observations, UserReports],
)
class ObservationsDao extends DatabaseAccessor<AppDatabase>
    with _$ObservationsDaoMixin {
  ObservationsDao(super.db);

  Future<int> insertOne(ObservationsCompanion row) =>
      into(observations).insert(row);

  Future<List<Observation>> forBranch(String branchId) {
    return (select(observations)
          ..where((t) => t.branchId.equals(branchId))
          ..orderBy([(t) => OrderingTerm.desc(t.observedAt)]))
        .get();
  }
}

@DriftAccessor(
  tables: [Branches, PlaceFetches, Forecasts, Observations, UserReports],
)
class UserReportsDao extends DatabaseAccessor<AppDatabase>
    with _$UserReportsDaoMixin {
  UserReportsDao(super.db);

  Future<void> insertOne(UserReportsCompanion row) =>
      into(userReports).insert(row);

  Future<List<UserReport>> since(DateTime since) {
    return (select(
      userReports,
    )..where((t) => t.reportedAt.isBiggerOrEqualValue(since))).get();
  }

  Future<List<UserReport>> pendingSync() {
    return (select(userReports)..where((t) => t.synced.equals(false))).get();
  }

  Future<List<UserReport>> recentForBranch(
    String branchId, {
    required DateTime since,
  }) {
    return (select(userReports)
          ..where(
            (t) =>
                t.branchId.equals(branchId) &
                t.reportedAt.isBiggerOrEqualValue(since),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.reportedAt)]))
        .get();
  }

  Future<void> markSynced(String id, DateTime at) {
    return (update(userReports)..where((t) => t.id.equals(id))).write(
      UserReportsCompanion(synced: const Value(true), syncedAt: Value(at)),
    );
  }
}
