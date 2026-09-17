import 'package:flutter/material.dart';

import '../../../core/i18n/tr.dart';
import '../../../core/ui/clay.dart';
import '../../../core/ui/crowd_style.dart';
import '../../../domain/crowd_level.dart';
import '../../../domain/forecast_service.dart';
import '../../../domain/place_forecast.dart';

/// Anonymous crowd reports from the last 2 hours, newest first.
class RecentReportsSection extends StatelessWidget {
  const RecentReportsSection({super.key, required this.forecast});

  final PlaceForecast forecast;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final reports = [...forecast.recentReports]
      ..sort((a, b) => b.reportedAt.compareTo(a.reportedAt));

    return ClaySection(
      title: tr.recentReports,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: reports.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Icon(Icons.forum_outlined, color: clay.muted),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tr.noReportsYet,
                      style: TextStyle(fontSize: 13, color: clay.muted),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                for (final (i, report) in reports.take(5).indexed) ...[
                  if (i > 0) Divider(height: 1, color: clay.line),
                  _ReportRow(report: report, now: forecast.asOf),
                ],
              ],
            ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({required this.report, required this.now});

  final LiveReport report;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final level = CrowdLevel.fromIndex(
      ForecastService().levelToIndex(report.crowdLevel),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: clay.accentSoft,
            child: Icon(
              Icons.no_accounts_rounded,
              size: 20,
              color: clay.accent,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr.anonymous,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: clay.ink,
                  ),
                ),
                Text(
                  tr.minutesAgo(now.difference(report.reportedAt).inMinutes),
                  style: TextStyle(fontSize: 12, color: clay.muted),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: clay.crowdSurface(level),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CrowdStyle.icon(level),
                  size: 14,
                  color: clay.crowdInk(level),
                ),
                const SizedBox(width: 5),
                Text(
                  tr.level(level),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: clay.crowdInk(level),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
