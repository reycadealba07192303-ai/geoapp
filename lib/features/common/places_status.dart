import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/i18n/tr.dart';
import '../../core/ui/clay.dart';
import '../app_state.dart';

/// Why there may be no places: still downloading, offline, or truly none.
enum PlacesStatus { loading, offline, empty, ready }

final placesStatusProvider = Provider<PlacesStatus>((ref) {
  final snapshot = ref.watch(placesSnapshotProvider);
  if (ref.watch(placesProvider).isNotEmpty) return PlacesStatus.ready;
  if (snapshot.isLoading) return PlacesStatus.loading;
  if (snapshot.valueOrNull?.downloadFailed ?? snapshot.hasError) {
    return PlacesStatus.offline;
  }
  return PlacesStatus.empty;
});

/// Clay card explaining an empty scope, with the right action.
class PlacesStatusCard extends ConsumerWidget {
  const PlacesStatusCard({super.key, required this.status});

  final PlacesStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final km = (ref.watch(coverageProvider).radiusMeters / 1000).round();

    final (icon, title, body) = switch (status) {
      PlacesStatus.loading => (
        Icons.travel_explore_rounded,
        tr.downloadingTitle,
        tr.downloadingBody(km),
      ),
      PlacesStatus.offline => (
        Icons.wifi_off_rounded,
        tr.offlineTitle,
        tr.offlineBody,
      ),
      _ => (Icons.travel_explore_rounded, tr.emptyTitle(km), tr.emptyBody),
    };

    return ClayBox(
      radius: 36,
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          ClayBox(
            width: 88,
            height: 88,
            radius: 999,
            depth: 0.6,
            padding: EdgeInsets.zero,
            color: clay.accentSoft,
            child: Center(
              child: status == PlacesStatus.loading
                  ? SizedBox(
                      width: 36,
                      height: 36,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: clay.accent,
                      ),
                    )
                  : Icon(icon, size: 40, color: clay.accent),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: clay.ink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: clay.muted, height: 1.45),
          ),
          if (status == PlacesStatus.offline) ...[
            const SizedBox(height: 20),
            ClayChip(
              label: tr.tryAgain,
              icon: Icons.refresh_rounded,
              selected: true,
              onTap: () => ref.invalidate(placesSnapshotProvider),
            ),
          ],
        ],
      ),
    );
  }
}
