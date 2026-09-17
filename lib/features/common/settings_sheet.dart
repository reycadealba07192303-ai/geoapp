import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/i18n/tr.dart';
import '../../core/settings/app_settings.dart';
import '../../core/ui/clay.dart';

Future<void> showSettingsSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: ClayPalette.of(context).background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => const _SettingsSheet(),
  );
}

class _SettingsSheet extends ConsumerWidget {
  const _SettingsSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    Widget title(String text) => Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10, top: 18),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: clay.muted,
        ),
      ),
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
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
            const SizedBox(height: 16),
            Text(
              tr.settings,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: clay.ink,
              ),
            ),
            title(tr.languageLabel),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ClayChip(
                  label: 'English',
                  selected: settings.language == AppLanguage.english,
                  onTap: () => notifier.update(
                    (s) => s.copyWith(language: AppLanguage.english),
                  ),
                ),
                ClayChip(
                  label: 'Filipino',
                  selected: settings.language == AppLanguage.filipino,
                  onTap: () => notifier.update(
                    (s) => s.copyWith(language: AppLanguage.filipino),
                  ),
                ),
              ],
            ),
            title(tr.theme),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final (mode, label, icon) in [
                  (ThemeMode.dark, tr.dark, Icons.dark_mode_rounded),
                  (ThemeMode.light, tr.light, Icons.light_mode_rounded),
                  (ThemeMode.system, tr.system, Icons.brightness_auto_rounded),
                ])
                  ClayChip(
                    label: label,
                    icon: icon,
                    selected: settings.themeMode == mode,
                    onTap: () =>
                        notifier.update((s) => s.copyWith(themeMode: mode)),
                  ),
              ],
            ),
            title('Nearby scope'),
            Wrap(
              spacing: 10,
              children: [
                for (final km in [1, 5, 10])
                  ClayChip(
                    label: '${km} km',
                    icon: Icons.radar_rounded,
                    selected: settings.scopeKm == km,
                    onTap: () => notifier.update((s) => s.copyWith(scopeKm: km)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
