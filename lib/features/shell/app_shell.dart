import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/i18n/tr.dart';
import '../../core/ui/clay.dart';
import '../app_state.dart';
import '../forecast/forecast_screen.dart';
import '../map/map_screen.dart';
import '../places/places_screen.dart';
import '../report/report_sheet.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  late final Timer _clock;

  /// Map and list are built on first visit.
  final _visited = <AppTab>{AppTab.forecast};

  @override
  void initState() {
    super.initState();
    _clock = Timer.periodic(const Duration(minutes: 1), (_) {
      ref.read(nowProvider.notifier).state = DateTime.now();
    });
  }

  @override
  void dispose() {
    _clock.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tab = ref.watch(tabProvider);
    final clay = ClayPalette.of(context);
    _visited.add(tab);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          (clay.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
              .copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.transparent,
              ),
      child: Scaffold(
        backgroundColor: clay.background,
        extendBody: true,
        body: IndexedStack(
          index: tab.index,
          children: [
            const ForecastScreen(),
            if (_visited.contains(AppTab.map))
              const MapScreen()
            else
              const SizedBox.shrink(),
            if (_visited.contains(AppTab.list))
              const PlacesScreen()
            else
              const SizedBox.shrink(),
          ],
        ),
        bottomNavigationBar: _ClayNavBar(
          current: tab,
          onSelect: (t) => ref.read(tabProvider.notifier).state = t,
          onReport: () => showReportSheet(context),
        ),
      ),
    );
  }
}

class _ClayNavBar extends StatelessWidget {
  const _ClayNavBar({
    required this.current,
    required this.onSelect,
    required this.onReport,
  });

  final AppTab current;
  final ValueChanged<AppTab> onSelect;
  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    final clay = ClayPalette.of(context);
    final tr = Tr.of(context);
    final items = {
      AppTab.forecast: (Icons.wb_sunny_outlined, tr.tabForecast),
      AppTab.map: (Icons.map_outlined, tr.tabMap),
      AppTab.list: (Icons.format_list_bulleted_rounded, tr.tabList),
    };

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: ClayBox(
              radius: 30,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  for (final MapEntry(key: tab, value: (icon, label))
                      in items.entries)
                    Expanded(
                      flex: tab == current ? 5 : 3,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onSelect(tab),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          curve: Curves.easeOut,
                          height: 50,
                          decoration: BoxDecoration(
                            color: tab == current
                                ? clay.accentSoft
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icon,
                                size: 20,
                                color: tab == current
                                    ? clay.accent
                                    : clay.muted,
                              ),
                              if (tab == current) ...[
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    label,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: clay.accent,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Tooltip(
            message: tr.reportCrowd,
            child: ClayBox(
              width: 66,
              height: 66,
              radius: 999,
              color: clay.accent,
              padding: EdgeInsets.zero,
              onTap: onReport,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.campaign_rounded, color: clay.onAccent, size: 24),
                  Text(
                    tr.report,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: clay.onAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
