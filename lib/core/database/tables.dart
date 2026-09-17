import 'package:drift/drift.dart';

/// Place catalog, cached from OpenStreetMap so it works offline.
@DataClassName('Branch')
class Branches extends Table {
  /// `osm-<type>-<id>`.
  TextColumn get id => text()();

  /// OSM `brand` tag (e.g. Jollibee); empty when unbranded.
  TextColumn get brand => text()();
  TextColumn get name => text()();
  TextColumn get address => text().nullable()();
  RealColumn get lat => real()();
  RealColumn get lng => real()();

  /// `PlaceCategory.name` (fastFood, kainan, coffee, …).
  TextColumn get category => text().withDefault(const Constant('kainan'))();

  /// Raw OSM `opening_hours`.
  TextColumn get openingHours => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get website => text().nullable()();
  TextColumn get operatorName => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get cuisine => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get wheelchair => text().nullable()();
  TextColumn get outdoorSeating => text().nullable()();
  TextColumn get internetAccess => text().nullable()();
  TextColumn get delivery => text().nullable()();
  TextColumn get takeaway => text().nullable()();
  TextColumn get capacity => text().nullable()();
  TextColumn get facebook => text().nullable()();
  TextColumn get instagram => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Areas already downloaded from OpenStreetMap — avoids re-fetching on
/// every small movement.
@DataClassName('PlaceFetch')
class PlaceFetches extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get centerLat => real()();
  RealColumn get centerLng => real()();
  RealColumn get radiusMeters => real()();
  DateTimeColumn get fetchedAt => dateTime()();
}

/// Historical crowd forecast per branch × day-of-week × hour.
/// [crowdIndex] is 0.0–1.0 (prediction, not a live camera/sensor reading).
class Forecasts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get branchId => text().references(Branches, #id)();

  /// 1 = Monday … 7 = Sunday (ISO weekday).
  IntColumn get dayOfWeek => integer()();

  /// 0–23 local hour.
  IntColumn get hour => integer()();
  RealColumn get crowdIndex => real()();
  RealColumn get confidence => real().withDefault(const Constant(0.5))();
  IntColumn get sampleCount => integer().withDefault(const Constant(0))();
  TextColumn get source => text().withDefault(const Constant('estimate'))();
  DateTimeColumn get lastUpdated => dateTime().nullable()();
}

/// Field / pipeline observation used to train or validate forecasts.
/// Stored locally; pipeline may also keep a separate SQLite export.
class Observations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get branchId => text().references(Branches, #id)();
  DateTimeColumn get observedAt => dateTime()();

  /// Observer score 1–5 (1 = empty, 5 = packed).
  IntColumn get crowdLevel => integer()();
  IntColumn get queueLength => integer().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get observerId => text().nullable()();
}

/// Crowdsourced live reports from app users.
/// [synced] gates the offline → Supabase upload queue.
class UserReports extends Table {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  DateTimeColumn get reportedAt => dateTime()();

  /// User score 1–5.
  IntColumn get crowdLevel => integer()();
  TextColumn get note => text().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get syncedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
