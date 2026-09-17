import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/i18n/tr.dart';
import '../../core/ui/clay.dart';
import '../app_state.dart';

/// "Near you · 10 km" — or a prompt to turn location on.
class ScopeLabel extends ConsumerWidget {
  const ScopeLabel({super.key, this.emphasized = false});

  /// Bold ink text (map pill) instead of muted (top bars).
  final bool emphasized;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final location = ref.watch(userLocationProvider);
    final coverage = ref.watch(coverageProvider);
    final km = (coverage.radiusMeters / 1000).round();

    final (icon, text, color) = switch (location) {
      AsyncValue(isLoading: true, hasValue: false) => (
        Icons.gps_not_fixed_rounded,
        tr.locating,
        clay.muted,
      ),
      _ when coverage.followsUser => (
        Icons.near_me_rounded,
        tr.nearYou(km),
        emphasized ? clay.ink : clay.muted,
      ),
      _ => (
        Icons.location_off_rounded,
        tr.turnOnLocation(coverage.name),
        clay.accent,
      ),
    };

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: coverage.followsUser
          ? null
          : () => ref.invalidate(userLocationProvider),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: coverage.followsUser ? clay.accent : color,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: emphasized ? FontWeight.w700 : FontWeight.w600,
                    color: color,
                  ),
                ),
                if (coverage.followsUser)
                  Text(
                    '${coverage.centerLat.toStringAsFixed(6)}, ${coverage.centerLng.toStringAsFixed(6)}',
                    style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
