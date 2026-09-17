import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/i18n/tr.dart';
import '../../core/ui/clay.dart';
import '../../core/ui/crowd_style.dart';
import '../../domain/place.dart';
import '../app_state.dart';

/// All / Fast food / Restaurant / … filter shared by the map and list tabs.
class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = Tr.of(context);
    final filter = ref.watch(categoryFilterProvider);
    void select(PlaceCategory? c) =>
        ref.read(categoryFilterProvider.notifier).state = c;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          ClayChip(
            label: tr.all,
            selected: filter == null,
            onTap: () => select(null),
          ),
          for (final c in PlaceCategory.values) ...[
            const SizedBox(width: 10),
            ClayChip(
              label: tr.category(c),
              icon: CrowdStyle.categoryIcon(c),
              selected: filter == c,
              onTap: () => select(c),
            ),
          ],
        ],
      ),
    );
  }
}
