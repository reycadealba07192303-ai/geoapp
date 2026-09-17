import 'package:flutter/material.dart';

import '../../../core/i18n/tr.dart';
import '../../../core/ui/clay.dart';
import '../../../core/ui/crowd_style.dart';
import '../../../domain/place_forecast.dart';

class HourlySection extends StatelessWidget {
  const HourlySection({super.key, required this.forecast});

  final PlaceForecast forecast;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final best = forecast.best;

    return ClaySection(
      title: tr.next24Hours,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      child: SizedBox(
        height: 132,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: forecast.next24.length,
          separatorBuilder: (_, _) => const SizedBox(width: 2),
          itemBuilder: (context, i) {
            final slot = forecast.next24[i];
            final isBest = best != null && best.slot.time == slot.time;

            return Container(
              width: 52,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: isBest
                  ? BoxDecoration(
                      color: clay.crowdSurface(slot.level),
                      borderRadius: BorderRadius.circular(18),
                    )
                  : null,
              child: Column(
                children: [
                  Text(
                    i == 0 ? tr.now : CrowdStyle.hour(slot.time.hour),
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: i == 0 ? FontWeight.w700 : FontWeight.w500,
                      color: i == 0 ? clay.ink : clay.muted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 10,
                        height: slot.isOpen ? 6 + 52 * slot.crowdIndex : 4,
                        decoration: BoxDecoration(
                          color: clay.accentFor(slot.isOpen, slot.level),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    slot.isOpen ? CrowdStyle.percent(slot.crowdIndex) : '–',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: clay.ink,
                      fontFeatures: CrowdStyle.tabular,
                    ),
                  ),
                  Text(
                    isBest ? tr.best : '',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: clay.crowdInk(slot.level),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
