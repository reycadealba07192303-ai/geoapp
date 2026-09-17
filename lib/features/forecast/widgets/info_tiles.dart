import 'package:flutter/material.dart';

import '../../../core/i18n/tr.dart';
import '../../../core/ui/clay.dart';
import '../../../core/ui/crowd_style.dart';
import '../../../domain/place_forecast.dart';

/// Weather-app style detail tiles (like UV / humidity / wind).
class InfoTiles extends StatelessWidget {
  const InfoTiles({super.key, required this.forecast});

  final PlaceForecast forecast;

  @override
  Widget build(BuildContext context) {
    final tr = Tr.of(context);
    final place = forecast.place;
    final peak = forecast.todayOutlook.peak;
    final reports = forecast.recentReports;
    final shift = ((forecast.current.crowdIndex - forecast.baseForecast) * 100)
        .round();
    final range = place.isOpen24Hours
        ? tr.open24Hours
        : '${CrowdStyle.hour(place.openHour)} – ${CrowdStyle.hour(place.closeHour)}';

    String lastReportAge() {
      final latest = reports
          .map((r) => r.reportedAt)
          .reduce((a, b) => a.isAfter(b) ? a : b);
      return tr.minutesAgo(forecast.asOf.difference(latest).inMinutes);
    }

    return Column(
      children: [
        Row(
          children: [
            _Tile(
              icon: Icons.access_time_rounded,
              title: tr.hours,
              value: forecast.current.isOpen ? tr.open : tr.closed,
              caption: place.hasKnownHours ? range : tr.typicalHours(range),
            ),
            const SizedBox(width: 14),
            _Tile(
              icon: Icons.trending_up_rounded,
              title: tr.peakToday,
              value: CrowdStyle.hour(peak.time.hour),
              caption:
                  '${CrowdStyle.percent(peak.crowdIndex)} · ${tr.level(peak.level)}',
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            _Tile(
              icon: Icons.sensors_rounded,
              title: tr.liveReportsTitle,
              value: '${reports.length}',
              caption: reports.isEmpty ? tr.noReportsRecently : lastReportAge(),
            ),
            const SizedBox(width: 14),
            _Tile(
              icon: Icons.tune_rounded,
              title: tr.source,
              value: forecast.usesFieldData ? tr.fieldData : tr.estimate,
              caption: shift == 0
                  ? tr.baseForecast(CrowdStyle.percent(forecast.baseForecast))
                  : tr.fromReports('${shift > 0 ? '+' : ''}$shift%'),
            ),
          ],
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.title,
    required this.value,
    required this.caption,
  });

  final IconData icon;
  final String title;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);

    return Expanded(
      child: ClayBox(
        height: 124,
        radius: 26,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 15, color: clay.muted),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: clay.muted,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: clay.ink,
                fontFeatures: CrowdStyle.tabular,
              ),
            ),
            Text(
              caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: clay.muted),
            ),
          ],
        ),
      ),
    );
  }
}
