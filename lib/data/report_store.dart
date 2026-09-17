import 'package:uuid/uuid.dart';

import '../core/database/app_database.dart';
import '../core/database/daos.dart';
import '../domain/place_forecast.dart';
import 'backend_data_client.dart';

/// Where crowd reports are kept.
abstract interface class ReportStore {
  Future<List<LiveReport>> since(DateTime since);
  Future<void> save(LiveReport report);
}

/// Saved in UserReports with `synced = false`, ready for SyncQueue upload.
class DriftReportStore implements ReportStore {
  DriftReportStore(this._dao);

  final UserReportsDao _dao;
  static const _uuid = Uuid();

  @override
  Future<List<LiveReport>> since(DateTime since) async {
    final rows = await _dao.since(since);
    return [
      for (final r in rows)
        LiveReport(
          placeId: r.branchId,
          reportedAt: r.reportedAt,
          crowdLevel: r.crowdLevel,
        ),
    ];
  }

  @override
  Future<void> save(LiveReport report) {
    return _dao.insertOne(
      UserReportsCompanion.insert(
        id: _uuid.v4(),
        branchId: report.placeId,
        reportedAt: report.reportedAt,
        crowdLevel: report.crowdLevel,
      ),
    );
  }
}

/// For tests.
class MemoryReportStore implements ReportStore {
  final _reports = <LiveReport>[];

  @override
  Future<List<LiveReport>> since(DateTime since) async =>
      _reports.where((r) => !r.reportedAt.isBefore(since)).toList();

  @override
  Future<void> save(LiveReport report) async => _reports.add(report);
}

class BackendReportStore implements ReportStore {
  BackendReportStore({required ReportStore local, required BackendDataClient backend})
    : _local = local,
      _backend = backend;

  final ReportStore _local;
  final BackendDataClient _backend;

  @override
  Future<List<LiveReport>> since(DateTime since) async {
    final local = await _local.since(since);
    if (!_backend.isConfigured) return local;

    try {
      final remote = await _backend.reportsSince(since);
      final byKey = <String, LiveReport>{};
      for (final report in [...remote, ...local]) {
        byKey[_key(report)] = report;
      }
      return byKey.values.toList()
        ..sort((a, b) => b.reportedAt.compareTo(a.reportedAt));
    } catch (_) {
      return local;
    }
  }

  @override
  Future<void> save(LiveReport report) async {
    await _local.save(report);
    if (!_backend.isConfigured) return;
    try {
      await _backend.postReport(report);
    } catch (_) {
      // Local copy remains queued in Drift for a later sync pass.
    }
  }

  static String _key(LiveReport report) =>
      '${report.placeId}:${report.reportedAt.millisecondsSinceEpoch ~/ 1000}:${report.crowdLevel}';
}
