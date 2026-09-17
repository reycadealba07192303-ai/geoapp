import 'package:flutter/material.dart';

import '../../../core/i18n/tr.dart';
import '../../../core/ui/clay.dart';
import '../../../core/ui/crowd_style.dart';
import '../../../domain/place_forecast.dart';

/// The big "temperature" card: current crowd %, level and day summary.
class CrowdHero extends StatelessWidget {
  const CrowdHero({super.key, required this.forecast});

  final PlaceForecast forecast;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final current = forecast.current;
    final isOpen = current.isOpen;
    final level = current.level;
    final ink = clay.inkFor(isOpen, level);
    final today = forecast.todayOutlook;
    final reportCount = forecast.recentReports.length;

    return ClayBox(
      color: clay.surfaceFor(isOpen, level),
      radius: 36,
      padding: const EdgeInsets.fromLTRB(24, 22, 22, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOpen
                          ? CrowdStyle.percent(current.crowdIndex)
                          : tr.closed,
                      style: TextStyle(
                        fontSize: isOpen ? 72 : 44,
                        fontWeight: FontWeight.w300,
                        height: 1.1,
                        letterSpacing: -2,
                        color: ink,
                        fontFeatures: CrowdStyle.tabular,
                      ),
                    ),
                    Text(
                      isOpen
                          ? tr.level(level)
                          : tr.opensAt(
                              CrowdStyle.hour(forecast.place.openHour),
                            ),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: ink,
                      ),
                    ),
                    Text(
                      isOpen ? tr.advice(level) : tr.comeBackLater,
                      style: TextStyle(
                        fontSize: 14,
                        color: ink.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),
              ClayBox(
                width: 84,
                height: 84,
                radius: 999,
                depth: 0.8,
                padding: EdgeInsets.zero,
                color: clay.accentFor(isOpen, level),
                child: Center(
                  child: Icon(
                    isOpen ? CrowdStyle.icon(level) : Icons.nightlight_round,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Tag(
                icon: forecast.usesFieldData
                    ? Icons.fact_check_outlined
                    : Icons.auto_graph_rounded,
                text: forecast.usesFieldData ? tr.fieldData : tr.estimate,
                color: ink,
              ),
              _Tag(
                icon: Icons.trending_down_rounded,
                text: tr.quietAt(CrowdStyle.hour(today.quietest.time.hour)),
                color: ink,
              ),
              _Tag(
                icon: Icons.trending_up_rounded,
                text: tr.busyAt(CrowdStyle.hour(today.peak.time.hour)),
                color: ink,
              ),
              if (reportCount > 0)
                _Tag(
                  icon: Icons.sensors_rounded,
                  text: tr.liveReports(reportCount),
                  color: ink,
                ),
              if (today.isPayday)
                _Tag(
                  icon: Icons.payments_outlined,
                  text: tr.paydayBoost,
                  color: ink,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
