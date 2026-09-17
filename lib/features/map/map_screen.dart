import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' as ll;

import '../../core/i18n/tr.dart';
import '../../core/ui/clay.dart';
import '../../core/ui/crowd_style.dart';
import '../../domain/geo.dart';
import '../../domain/place.dart';
import '../app_state.dart';
import '../common/category_chips.dart';
import '../common/place_photo.dart';
import '../common/places_status.dart';
import '../common/scope_label.dart';
import '../report/report_sheet.dart';

/// OpenStreetMap renderer with clay crowd pins for every place in scope.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final _controller = MapController();
  String? _previewId;
  double _zoom = 12.5;
  Timer? _debounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scheduleRefresh();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _scheduleRefresh() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 120), () {
      if (mounted) setState(() {});
    });
  }

  LatLngBounds _scopeBounds() {
    final box = ref.read(coverageProvider).box;
    return LatLngBounds(
      ll.LatLng(box.south, box.west),
      ll.LatLng(box.north, box.east),
    );
  }

  void _showPreview(Place place) {
    setState(() => _previewId = place.id);
    _scheduleRefresh();
    _controller.move(ll.LatLng(place.lat, place.lng), math.max(_zoom, 15));
  }

  void _closePreview() {
    if (_previewId == null) return;
    setState(() => _previewId = null);
    _scheduleRefresh();
  }

  void _goToUser() {
    final user = ref.read(userLocationProvider).valueOrNull;
    if (user == null) {
      ref.invalidate(userLocationProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Tr.of(context).turnOnLocationSnack)),
      );
      return;
    }
    _controller.move(ll.LatLng(user.latitude, user.longitude), 15);
  }

  void _fitScope() {
    _controller.fitCamera(
      CameraFit.bounds(bounds: _scopeBounds(), padding: const EdgeInsets.all(24)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final coverage = ref.watch(coverageProvider);
    final places = ref.watch(filteredPlacesProvider);
    final user = ref.watch(userLocationProvider).valueOrNull;
    final padding = MediaQuery.paddingOf(context);

    ref.listen(filteredPlacesProvider, (_, _) => _scheduleRefresh());
    ref.listen(liveReportsProvider, (_, _) => _scheduleRefresh());
    ref.listen(nowProvider, (_, _) => _scheduleRefresh());
    ref.listen(placeForecastBuilderProvider, (_, _) => _scheduleRefresh());

    ref.listen(coverageProvider, (previous, next) {
      if (previous?.followsUser != next.followsUser) {
        _controller.move(ll.LatLng(next.centerLat, next.centerLng), 12.5);
      }
    });

    final previewPlace = places.where((p) => p.id == _previewId).firstOrNull;
    final attributionColor = clay.isDark
        ? Colors.white.withValues(alpha: 0.72)
        : Colors.black.withValues(alpha: 0.48);

    return Stack(
      children: [
        FlutterMap(
          // Recreate the map when the selected scope changes. flutter_map
          // does not allow cameraConstraint to be replaced on a live map.
          key: ValueKey('${coverage.centerLat}:${coverage.centerLng}:${coverage.radiusMeters}'),
          mapController: _controller,
          options: MapOptions(
            initialCenter: ll.LatLng(coverage.centerLat, coverage.centerLng),
            initialZoom: _zoom,
            minZoom: 10,
            maxZoom: 19,
            backgroundColor: clay.background,
            onTap: (_, _) => _closePreview(),
            onPositionChanged: (camera, _) => _zoom = camera.zoom,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.geoapp.geoapp',
              maxZoom: 19,
            ),
            CircleLayer(
              circles: [
                CircleMarker(
                  point: ll.LatLng(coverage.centerLat, coverage.centerLng),
                  radius: coverage.radiusMeters,
                  useRadiusInMeter: true,
                  color: clay.accent.withValues(alpha: 0.06),
                  borderColor: clay.accent.withValues(alpha: 0.6),
                  borderStrokeWidth: 2,
                ),
                if (user != null)
                  CircleMarker(
                    point: ll.LatLng(user.latitude, user.longitude),
                    radius: 8,
                    color: clay.accent,
                    borderColor: clay.surface,
                    borderStrokeWidth: 3,
                  ),
              ],
            ),
            MarkerLayer(
              markers: [
                for (final place in places)
                  Marker(
                    key: ValueKey(place.id),
                    point: ll.LatLng(place.lat, place.lng),
                    width: place.id == _previewId ? 92 : 78,
                    height: 42,
                    child: _PlaceMarker(
                      place: place,
                      selected: place.id == _previewId,
                      onTap: () => _showPreview(place),
                    ),
                  ),
              ],
            ),
            SimpleAttributionWidget(
              source: Text(
                'OpenStreetMap',
                style: TextStyle(fontSize: 10, color: attributionColor),
              ),
              backgroundColor: clay.surface.withValues(alpha: 0.72),
            ),
          ],
        ),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Row(
                  children: [
                    const Flexible(
                      child: ClayBox(
                        radius: 999,
                        depth: 0.7,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: ScopeLabel(emphasized: true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClayIconButton(
                      icon: Icons.my_location_rounded,
                      tooltip: tr.myLocation,
                      onTap: _goToUser,
                    ),
                    const SizedBox(width: 12),
                    ClayIconButton(
                      icon: Icons.zoom_out_map_rounded,
                      tooltip: tr.wholeScope,
                      onTap: _fitScope,
                    ),
                  ],
                ),
              ),
              const CategoryChips(),
              const _StatusPill(),
            ],
          ),
        ),
        if (previewPlace != null)
          Positioned(
            left: 20,
            right: 20,
            bottom: padding.bottom + 18,
            child: _PreviewCard(place: previewPlace, onClose: _closePreview),
          ),
      ],
    );
  }
}

class _PlaceMarker extends ConsumerWidget {
  const _PlaceMarker({
    required this.place,
    required this.selected,
    required this.onTap,
  });

  final Place place;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clay = ClayPalette.of(context);
    final slot = ref.watch(currentSlotProvider(place.id));
    final fill = selected ? clay.accent : clay.surfaceFor(slot.isOpen, slot.level);
    final foreground = selected
        ? clay.onAccent
        : clay.inkFor(slot.isOpen, slot.level);
    final border = selected ? clay.onAccent : clay.surface;

    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: border, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.22),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CrowdStyle.categoryIcon(place.category), size: 15, color: foreground),
              const SizedBox(width: 5),
              Text(
                slot.isOpen ? CrowdStyle.percent(slot.crowdIndex) : '-',
                style: TextStyle(
                  color: foreground,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Download progress / offline notice floating under the filter chips.
class _StatusPill extends ConsumerWidget {
  const _StatusPill();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final status = ref.watch(placesStatusProvider);
    final count = ref.watch(filteredPlacesProvider).length;

    final (Widget leading, String text, VoidCallback? onTap) = switch (status) {
      PlacesStatus.loading => (
        SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(strokeWidth: 2, color: clay.accent),
        ),
        tr.downloadingShort,
        null,
      ),
      PlacesStatus.offline => (
        Icon(Icons.wifi_off_rounded, size: 16, color: clay.accent),
        tr.offlineRetry,
        () => ref.invalidate(placesSnapshotProvider),
      ),
      PlacesStatus.empty => (
        Icon(Icons.search_off_rounded, size: 16, color: clay.muted),
        tr.noPlacesHere,
        null,
      ),
      PlacesStatus.ready => (
        Icon(Icons.place_outlined, size: 16, color: clay.muted),
        tr.placeCount(count),
        null,
      ),
    };

    return ClayBox(
      radius: 999,
      depth: 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: clay.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewCard extends ConsumerWidget {
  const _PreviewCard({required this.place, required this.onClose});

  final Place place;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final current = ref.watch(currentSlotProvider(place.id));
    final isOpen = current.isOpen;
    final user = ref.watch(userLocationProvider).valueOrNull;

    final subtitle = [
      tr.category(place.category),
      if (user != null)
        tr.fromYou(
          CrowdStyle.distance(
            distanceMeters(user.latitude, user.longitude, place.lat, place.lng),
          ),
        )
      else if (place.area.isNotEmpty)
        place.area,
    ].join(' · ');

    return ClayBox(
      radius: 30,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              PlacePhoto(
                place: place,
                height: 64,
                width: 64,
                radius: 18,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: clay.ink,
                      ),
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: clay.muted),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isOpen
                          ? '${CrowdStyle.percent(current.crowdIndex)} · ${tr.level(current.level)}'
                          : tr.closed,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: clay.accentFor(isOpen, current.level),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: Icon(Icons.close_rounded, color: clay.muted),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ClayBox(
                  radius: 18,
                  depth: 0.5,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  onTap: () => showReportSheet(context, placeId: place.id),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.campaign_rounded, size: 18, color: clay.accent),
                      const SizedBox(width: 6),
                      Text(
                        tr.report,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: clay.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ClayBox(
                  color: clay.accent,
                  radius: 18,
                  depth: 0.7,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  onTap: () => openForecast(ref, place.id),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr.tabForecast,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: clay.onAccent,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.arrow_forward_rounded, size: 16, color: clay.onAccent),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (place.source == PlaceSource.google)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 6, right: 4),
                child: GoogleMapsAttribution(color: clay.muted),
              ),
            ),
        ],
      ),
    );
  }
}
