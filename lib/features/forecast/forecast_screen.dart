import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/i18n/tr.dart';
import '../../core/ui/clay.dart';
import '../../core/ui/crowd_style.dart';
import '../../domain/place.dart';
import '../app_state.dart';
import '../common/place_photo.dart';
import '../common/places_status.dart';
import '../common/scope_label.dart';
import '../common/settings_sheet.dart';
import '../report/report_sheet.dart';
import 'widgets/crowd_hero.dart';
import 'widgets/day_curve_section.dart';
import 'widgets/hourly_section.dart';
import 'widgets/info_tiles.dart';
import 'widgets/recent_reports_section.dart';
import 'widgets/recommendation_section.dart';
import 'widgets/week_section.dart';

/// Weather-style forecast for the nearest (or tapped) place.
class ForecastScreen extends ConsumerWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final placeId = ref.watch(activePlaceIdProvider);
    final padding = EdgeInsets.fromLTRB(
      20,
      8,
      20,
      MediaQuery.paddingOf(context).bottom + 24,
    );

    if (placeId == null) {
      return SafeArea(
        bottom: false,
        child: ListView(
          padding: padding,
          children: [
            const _TopBar(),
            const SizedBox(height: 40),
            PlacesStatusCard(status: ref.watch(placesStatusProvider)),
          ],
        ),
      );
    }

    final forecast = ref.watch(placeForecastProvider(placeId));
    final place = forecast.place;

    return SafeArea(
      bottom: false,
      child: ListView(
        key: ValueKey(placeId),
        padding: padding,
        children: [
          const _TopBar(),
          if (ref.watch(showingSelectionProvider)) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: ClayChip(
                label: tr.showNearest,
                icon: Icons.near_me_rounded,
                onTap: () =>
                    ref.read(selectedPlaceProvider.notifier).state = null,
              ),
            ),
          ],
          const SizedBox(height: 18),
          ClayBox(
            radius: 30,
            padding: EdgeInsets.zero,
            clip: true,
            child: PlacePhoto(place: place, height: 190, radius: 30),
          ),
          const SizedBox(height: 18),
          _PlaceHeader(place: place),
          const SizedBox(height: 20),
          CrowdHero(forecast: forecast),
          const SizedBox(height: 18),
          ClayButton(
            label: tr.reportCrowd,
            icon: Icons.campaign_rounded,
            onTap: () => showReportSheet(context, placeId: placeId),
          ),
          const SizedBox(height: 30),
          RecommendationSection(
            forecast: forecast,
            onOpenPlace: (id) => selectPlace(ref, id),
          ),
          const SizedBox(height: 28),
          RecentReportsSection(forecast: forecast),
          const SizedBox(height: 28),
          HourlySection(forecast: forecast),
          const SizedBox(height: 28),
          DayCurveSection(forecast: forecast),
          const SizedBox(height: 28),
          WeekSection(forecast: forecast),
          const SizedBox(height: 28),
          InfoTiles(forecast: forecast),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = Tr.of(context);

    return Row(
      children: [
        const Expanded(child: ScopeLabel()),
        ClayIconButton(
          icon: Icons.search_rounded,
          tooltip: tr.tabList,
          onTap: () => ref.read(tabProvider.notifier).state = AppTab.list,
        ),
        const SizedBox(width: 12),
        ClayIconButton(
          icon: Icons.tune_rounded,
          tooltip: tr.settings,
          onTap: () => showSettingsSheet(context),
        ),
      ],
    );
  }
}

class _PlaceHeader extends StatelessWidget {
  const _PlaceHeader({required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CrowdStyle.categoryIcon(place.category),
                size: 16,
                color: clay.accent,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  tr.category(place.category),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: clay.accent,
                  ),
                ),
              ),
              if (place.source == PlaceSource.google)
                GoogleMapsAttribution(color: clay.muted),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            place.name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 1.15,
              letterSpacing: -0.3,
              color: clay.ink,
            ),
          ),
          if (place.area.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(place.area, style: TextStyle(fontSize: 13, color: clay.muted)),
          ],
        ],
      ),
    );
  }
}
