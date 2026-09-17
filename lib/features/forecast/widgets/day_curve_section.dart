import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/i18n/tr.dart';
import '../../../core/ui/clay.dart';
import '../../../core/ui/crowd_style.dart';
import '../../../domain/place_forecast.dart';

class DayCurveSection extends StatelessWidget {
  const DayCurveSection({super.key, required this.forecast});

  final PlaceForecast forecast;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final labelStyle = TextStyle(fontSize: 11, color: clay.muted);
    final nowX = forecast.asOf.hour + forecast.asOf.minute / 60;
    final fill = clay.accentFor(
      forecast.current.isOpen,
      forecast.current.level,
    );
    final hidden = AxisTitles(sideTitles: SideTitles(showTitles: false));

    return ClaySection(
      title: tr.todayCurve,
      padding: const EdgeInsets.fromLTRB(12, 20, 16, 10),
      child: SizedBox(
        height: 150,
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 23,
            minY: 0,
            maxY: 1.05,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            lineTouchData: const LineTouchData(enabled: false),
            titlesData: FlTitlesData(
              topTitles: hidden,
              leftTitles: hidden,
              rightTitles: hidden,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 6,
                  reservedSize: 24,
                  getTitlesWidget: (value, meta) => SideTitleWidget(
                    meta: meta,
                    child: Text(
                      CrowdStyle.hour(value.toInt()),
                      style: labelStyle,
                    ),
                  ),
                ),
              ),
            ),
            extraLinesData: ExtraLinesData(
              verticalLines: [
                VerticalLine(
                  x: nowX,
                  color: clay.muted.withValues(alpha: 0.6),
                  strokeWidth: 1.2,
                  dashArray: [4, 4],
                  label: VerticalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: clay.ink,
                    ),
                    labelResolver: (_) => tr.now,
                  ),
                ),
              ],
            ),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  for (final slot in forecast.today)
                    FlSpot(slot.time.hour.toDouble(), slot.crowdIndex),
                ],
                isCurved: true,
                preventCurveOverShooting: true,
                color: clay.accent,
                barWidth: 2.5,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      fill.withValues(alpha: 0.45),
                      fill.withValues(alpha: 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
