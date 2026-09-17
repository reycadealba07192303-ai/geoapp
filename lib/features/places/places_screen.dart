import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/i18n/tr.dart';
import '../../core/ui/clay.dart';
import '../../core/ui/crowd_style.dart';
import '../../domain/place.dart';
import '../app_state.dart';
import '../common/category_chips.dart';
import '../common/place_photo.dart';
import '../common/places_status.dart';
import '../common/scope_label.dart';

/// All places in the 10 km scope, nearest first.
class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final coverage = ref.watch(coverageProvider);
    final filtered = ref.watch(filteredPlacesProvider);
    final fromGoogle =
        ref.watch(placesSnapshotProvider).valueOrNull?.fromGoogle ?? false;

    // Already nearest-first from the scope center.
    final q = _query.trim().toLowerCase();
    final places = [
      for (final p in filtered)
        if (q.isEmpty ||
            p.name.toLowerCase().contains(q) ||
            p.area.toLowerCase().contains(q))
          p,
    ];

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        tr.places,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: clay.ink,
                        ),
                      ),
                    ),
                    if (fromGoogle) GoogleMapsAttribution(color: clay.muted),
                  ],
                ),
                Row(
                  children: [
                    const Flexible(child: ScopeLabel()),
                    if (places.isNotEmpty)
                      Text(
                        '  ·  ${tr.placeCount(places.length)}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: clay.muted,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: ClayBox(
              radius: 22,
              depth: 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (v) => setState(() => _query = v),
                style: TextStyle(color: clay.ink),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search_rounded, color: clay.muted),
                  hintText: tr.searchHint,
                  hintStyle: TextStyle(color: clay.muted),
                ),
              ),
            ),
          ),
          const CategoryChips(),
          Expanded(
            child: places.isEmpty
                ? ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      if (q.isEmpty && filtered.isEmpty)
                        PlacesStatusCard(
                          status: ref.watch(placesStatusProvider),
                        )
                      else
                        Center(
                          child: Text(
                            tr.noResults,
                            style: TextStyle(color: clay.muted),
                          ),
                        ),
                    ],
                  )
                : ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      8,
                      20,
                      MediaQuery.paddingOf(context).bottom + 24,
                    ),
                    itemCount: places.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 14),
                    itemBuilder: (_, i) => _PlaceTile(
                      place: places[i],
                      distance: coverage.distanceFromCenter(
                        places[i].lat,
                        places[i].lng,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _PlaceTile extends ConsumerWidget {
  const _PlaceTile({required this.place, required this.distance});

  final Place place;
  final double distance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final current = ref.watch(currentSlotProvider(place.id));
    final isOpen = current.isOpen;
    final hours = place.isOpen24Hours
        ? tr.hours24Short
        : isOpen
        ? tr.until(CrowdStyle.hour(place.closeHour))
        : tr.opensAt(CrowdStyle.hour(place.openHour));

    return ClayBox(
      radius: 26,
      depth: 0.8,
      padding: const EdgeInsets.all(12),
      onTap: () => openForecast(ref, place.id),
      child: Row(
        children: [
          PlacePhoto(
            place: place,
            height: 64,
            width: 64,
            radius: 18,
            showCredit: false,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: clay.ink,
                  ),
                ),
                Text(
                  '${tr.category(place.category)} · ${CrowdStyle.distance(distance)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: clay.muted),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: clay.accentFor(isOpen, current.level),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        isOpen ? tr.level(current.level) : tr.closed,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: clay.inkFor(isOpen, current.level),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isOpen ? CrowdStyle.percent(current.crowdIndex) : '–',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: clay.ink,
                  fontFeatures: CrowdStyle.tabular,
                ),
              ),
              Text(hours, style: TextStyle(fontSize: 11, color: clay.muted)),
            ],
          ),
        ],
      ),
    );
  }
}
