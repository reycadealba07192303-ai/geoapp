import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/i18n/tr.dart';
import 'core/settings/app_settings.dart';
import 'core/ui/clay.dart';
import 'features/shell/app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const ProviderScope(child: GeoApp()));
}

class GeoApp extends ConsumerWidget {
  const GeoApp({super.key});

  static ThemeData _theme(ClayPalette clay) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: clay.brightness,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: clay.accent,
        brightness: clay.brightness,
        surface: clay.background,
      ),
      scaffoldBackgroundColor: clay.background,
      extensions: [clay],
    );
    return base.copyWith(
      snackBarTheme: SnackBarThemeData(
        backgroundColor: clay.isDark ? clay.surface : clay.ink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: clay.accent),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      title: 'GeoApp',
      debugShowCheckedModeBanner: false,
      theme: _theme(ClayPalette.light),
      darkTheme: _theme(ClayPalette.dark),
      themeMode: settings.themeMode,
      builder: (context, child) =>
          TrScope(tr: Tr(settings.language), child: child!),
      home: const AppShell(),
    );
  }
}
