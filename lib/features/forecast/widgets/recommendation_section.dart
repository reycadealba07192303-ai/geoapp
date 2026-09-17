import 'package:flutter/material.dart';

import '../../../core/i18n/tr.dart';
import '../../../core/ui/clay.dart';
import '../../../core/ui/crowd_style.dart';
import '../../../domain/place_forecast.dart';
import '../../common/place_photo.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({
    super.key,
    required this.forecast,
    required this.onOpenPlace,
  });

  final PlaceForecast forecast;
  final ValueChanged<String> onOpenPlace;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final best = forecast.best;
    final current = forecast.current;

    return ClaySection(
      title: tr.recommendation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (best != null) _BestTime(best: best, current: current),
          if (forecast.alternatives.isNotEmpty) ...[
            const SizedBox(height: 18),
            Divider(height: 1, color: clay.line),
            const SizedBox(height: 14),
            Text(
              current.isOpen ? tr.quieterNearby : tr.openNearby,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: clay.muted,
              ),
            ),
            const SizedBox(height: 6),
            for (final alt in forecast.alternatives)
              _AlternativeRow(alt: alt, onTap: () => onOpenPlace(alt.place.id)),
          ],
        ],
      ),
    );
  }
}

class _BestTime extends StatelessWidget {
  const _BestTime({required this.best, required this.current});

  final BestVisit best;
  final HourSlot current;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final slot = best.slot;
    final hour = CrowdStyle.hour(slot.time.hour);
    final summary =
        '${CrowdStyle.percent(slot.crowdIndex)} · ${tr.level(slot.level)}';
    final saving = ((current.crowdIndex - slot.crowdIndex) * 100).round();

    final (title, subtitle) = switch (best) {
      _ when !best.isToday => (
        tr.tomorrowAt(hour),
        '${tr.noQuietLeftToday} · $summary',
      ),
      _ when slot.time.hour == current.time.hour => (
        tr.goNow,
        '${tr.notQuieterLater} · $summary',
      ),
      _ => (
        tr.goAt(hour),
        current.isOpen && saving >= 5
            ? '$summary · ${tr.lessThanNow(saving)}'
            : summary,
      ),
    };

    return Row(
      children: [
        ClayBox(
          width: 52,
          height: 52,
          radius: 18,
          depth: 0.6,
          padding: EdgeInsets.zero,
          color: clay.crowdAccent(slot.level),
          child: const Center(
            child: Icon(Icons.schedule_rounded, color: Colors.white),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: clay.ink,
                ),
              ),
              Text(subtitle, style: TextStyle(fontSize: 13, color: clay.muted)),
            ],
          ),
        ),
      ],
    );
  }
}

class _AlternativeRow extends StatelessWidget {
  const _AlternativeRow({required this.alt, required this.onTap});

  final Alternative alt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            PlacePhoto(
              place: alt.place,
              height: 44,
              width: 44,
              radius: 14,
              showCredit: false,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alt.place.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: clay.ink,
                    ),
                  ),
                  Text(
                    '${tr.level(alt.level)} · ${CrowdStyle.distance(alt.distanceMeters)}',
                    style: TextStyle(fontSize: 12, color: clay.muted),
                  ),
                ],
              ),
            ),
            Text(
              CrowdStyle.percent(alt.crowdIndex),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: clay.crowdAccent(alt.level),
                fontFeatures: CrowdStyle.tabular,
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: clay.muted),
          ],
        ),
      ),
    );
  }
}
