import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/i18n/tr.dart';
import 'core/settings/app_settings.dart';
import 'core/ui/clay.dart';
import 'features/shell/app_shell.dart';
import 'dart:async';

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
      home: const _SplashScreen(),
    );
  }
}

class _SplashScreen extends StatefulWidget {
  const _SplashScreen();

  @override
  State<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1400), () {
      if (mounted) Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AppShell()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: Color(0xFF171822)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/geoapp_logo.png', width: 150, height: 150),
                const SizedBox(height: 10),
                const Text(
                  'geoapp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 28),
                const SizedBox(
                  width: 34,
                  height: 34,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Color(0xFFFF796B),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Finding places near you…',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
