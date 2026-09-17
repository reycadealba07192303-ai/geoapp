import 'package:flutter/material.dart';

import '../../../core/i18n/tr.dart';
import '../../../core/ui/clay.dart';
import '../../../core/ui/crowd_style.dart';
import '../../../domain/place_forecast.dart';

class WeekSection extends StatelessWidget {
  const WeekSection({super.key, required this.forecast});

  final PlaceForecast forecast;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);

    return ClaySection(
      title: Tr.of(context).sevenDay,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Column(
        children: [
          for (final (i, day) in forecast.week.indexed) ...[
            if (i > 0) Divider(height: 1, color: clay.line),
            _DayRow(day: day, today: forecast.asOf),
          ],
        ],
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({required this.day, required this.today});

  final DayOutlook day;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final peak = day.peak;
    final quietest = day.quietest;
    final mutedStyle = TextStyle(
      fontSize: 12,
      color: clay.muted,
      fontFeatures: CrowdStyle.tabular,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  CrowdStyle.day(tr, day.date, today),
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: clay.ink,
                  ),
                ),
                if (day.isPayday)
                  Text(
                    tr.payday,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: clay.crowdAccent(peak.level),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 42,
            child: Text(CrowdStyle.hour(quietest.time.hour), style: mutedStyle),
          ),
          SizedBox(
            width: 34,
            child: Text(
              CrowdStyle.percent(quietest.crowdIndex),
              style: mutedStyle,
            ),
          ),
          Expanded(
            child: _RangeBar(min: quietest, max: peak),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 38,
            child: Text(
              CrowdStyle.percent(peak.crowdIndex),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: clay.ink,
                fontFeatures: CrowdStyle.tabular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Quietest → busiest range on a 0–100% track, like a temperature bar.
class _RangeBar extends StatelessWidget {
  const _RangeBar({required this.min, required this.max});

  final HourSlot min;
  final HourSlot max;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final span = (width * (max.crowdIndex - min.crowdIndex)).clamp(
          8.0,
          width,
        );
        final left = (width * min.crowdIndex).clamp(0.0, width - span);

        return Container(
          height: 8,
          decoration: BoxDecoration(
            color: clay.line,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: left),
            width: span,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: [
                  clay.crowdAccent(min.level),
                  clay.crowdAccent(max.level),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
