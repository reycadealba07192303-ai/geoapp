import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/i18n/tr.dart';
import '../../core/ui/clay.dart';
import '../../core/ui/crowd_style.dart';
import '../../domain/crowd_level.dart';
import '../../domain/place.dart';
import '../app_state.dart';
import '../common/place_photo.dart';

/// Anonymous crowd report. Defaults to [placeId], else the place on the
/// Forecast tab (nearest). Saved locally and fused into the forecast.
Future<void> showReportSheet(BuildContext context, {String? placeId}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: ClayPalette.of(context).background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => _ReportSheet(initialPlaceId: placeId),
  );
}

class _ReportSheet extends ConsumerStatefulWidget {
  const _ReportSheet({this.initialPlaceId});

  final String? initialPlaceId;

  @override
  ConsumerState<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends ConsumerState<_ReportSheet> {
  String? _placeId;
  CrowdLevel? _level;
  bool _choosingPlace = false;

  @override
  void initState() {
    super.initState();
    _placeId = widget.initialPlaceId ?? ref.read(activePlaceIdProvider);
  }

  Future<void> _submit(Place place) async {
    final level = _level;
    if (level == null) return;

    final tr = Tr.of(context);
    final clay = ClayPalette.of(context);
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();

    ref.read(nowProvider.notifier).state = DateTime.now();
    await ref
        .read(liveReportsProvider.notifier)
        .add(placeId: place.id, crowdLevel: level.scale);

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: clay.crowdAccent(CrowdLevel.maluwag),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr.dataAdded,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    tr.dataAddedBody(place.name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final places = ref.watch(placesProvider);
    final byId = ref.watch(placesByIdProvider);
    final place = byId[_placeId] ?? places.firstOrNull;
    final coverage = ref.watch(coverageProvider);

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.9,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: clay.line,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                tr.howCrowded,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  color: clay.ink,
                ),
              ),
              const SizedBox(height: 14),
              if (place == null)
                Text(tr.emptyBody, style: TextStyle(color: clay.muted))
              else if (_choosingPlace)
                _PlacePicker(
                  places: places.take(20).toList(),
                  distanceOf: (p) => coverage.distanceFromCenter(p.lat, p.lng),
                  onPick: (p) => setState(() {
                    _placeId = p.id;
                    _choosingPlace = false;
                  }),
                )
              else ...[
                ClayBox(
                  radius: 22,
                  depth: 0.6,
                  padding: const EdgeInsets.all(10),
                  onTap: () => setState(() => _choosingPlace = true),
                  child: Row(
                    children: [
                      PlacePhoto(
                        place: place,
                        height: 48,
                        width: 48,
                        radius: 14,
                        showCredit: false,
                      ),
                      const SizedBox(width: 12),
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
                              '${tr.category(place.category)} · ${CrowdStyle.distance(coverage.distanceFromCenter(place.lat, place.lng))}',
                              style: TextStyle(fontSize: 12, color: clay.muted),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        tr.change,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: clay.accent,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                for (final level in CrowdLevel.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _LevelOption(
                      level: level,
                      selected: _level == level,
                      onTap: () => setState(() => _level = level),
                    ),
                  ),
                const SizedBox(height: 6),
                ClayButton(
                  label: tr.postAnonymously,
                  icon: Icons.send_rounded,
                  onTap: _level == null ? null : () => _submit(place),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.no_accounts_rounded,
                      size: 16,
                      color: clay.muted,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        tr.anonymousNote,
                        style: TextStyle(fontSize: 12, color: clay.muted),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PlacePicker extends StatelessWidget {
  const _PlacePicker({
    required this.places,
    required this.distanceOf,
    required this.onPick,
  });

  final List<Place> places;
  final double Function(Place) distanceOf;
  final ValueChanged<Place> onPick;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr.choosePlace,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: clay.muted,
          ),
        ),
        const SizedBox(height: 8),
        for (final p in places)
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onPick(p),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                children: [
                  PlacePhoto(
                    place: p,
                    height: 40,
                    width: 40,
                    radius: 12,
                    showCredit: false,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      p.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: clay.ink),
                    ),
                  ),
                  Text(
                    CrowdStyle.distance(distanceOf(p)),
                    style: TextStyle(fontSize: 12, color: clay.muted),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _LevelOption extends StatelessWidget {
  const _LevelOption({
    required this.level,
    required this.selected,
    required this.onTap,
  });

  final CrowdLevel level;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);

    return ClayBox(
      color: selected ? clay.crowdSurface(level) : clay.surface,
      radius: 22,
      depth: selected ? 0.4 : 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: clay.crowdAccent(level),
              shape: BoxShape.circle,
            ),
            child: Icon(CrowdStyle.icon(level), size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr.level(level),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: selected ? clay.crowdInk(level) : clay.ink,
                  ),
                ),
                Text(
                  tr.advice(level),
                  style: TextStyle(
                    fontSize: 12,
                    color: selected
                        ? clay.crowdInk(level).withValues(alpha: 0.8)
                        : clay.muted,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            selected
                ? Icons.check_circle_rounded
                : Icons.radio_button_off_rounded,
            color: selected ? clay.crowdInk(level) : clay.line,
          ),
        ],
      ),
    );
  }
}
