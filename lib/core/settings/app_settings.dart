import 'dart:convert';
import 'dart:io';
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

enum AppLanguage { english, filipino }

class AppSettings {
  const AppSettings({required this.language, required this.themeMode, this.scopeKm = 10});

  /// Filipino on phones set to Filipino/Tagalog, English otherwise; dark theme.
  factory AppSettings.defaults() {
    final code = PlatformDispatcher.instance.locale.languageCode;
    return AppSettings(
      language: const {'fil', 'tl'}.contains(code)
          ? AppLanguage.filipino
          : AppLanguage.english,
      themeMode: ThemeMode.dark,
      scopeKm: 10,
    );
  }

  final AppLanguage language;
  final ThemeMode themeMode;
  final int scopeKm;

  AppSettings copyWith({AppLanguage? language, ThemeMode? themeMode, int? scopeKm}) {
    return AppSettings(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      scopeKm: scopeKm ?? this.scopeKm,
    );
  }

  Map<String, String> toJson() => {
    'language': language.name,
    'themeMode': themeMode.name,
    'scopeKm': '$scopeKm',
  };

  static AppSettings fromJson(Map<String, dynamic> json, AppSettings fallback) {
    return AppSettings(
      language:
          AppLanguage.values.asNameMap()[json['language']] ?? fallback.language,
      themeMode:
          ThemeMode.values.asNameMap()[json['themeMode']] ?? fallback.themeMode,
      scopeKm: const [1, 5, 10].contains(json['scopeKm'] is int
          ? json['scopeKm']
          : int.tryParse('${json['scopeKm']}'))
          ? (json['scopeKm'] is int ? json['scopeKm'] : int.parse('${json['scopeKm']}'))
          : fallback.scopeKm,
    );
  }
}

abstract interface class SettingsStore {
  Future<Map<String, dynamic>?> load();
  Future<void> save(Map<String, String> json);
}

/// `settings.json` in the app documents folder.
class FileSettingsStore implements SettingsStore {
  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, 'settings.json'));
  }

  @override
  Future<Map<String, dynamic>?> load() async {
    try {
      final file = await _file();
      if (!await file.exists()) return null;
      return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> save(Map<String, String> json) async {
    await (await _file()).writeAsString(jsonEncode(json));
  }
}

class MemorySettingsStore implements SettingsStore {
  Map<String, dynamic>? _json;

  @override
  Future<Map<String, dynamic>?> load() async => _json;

  @override
  Future<void> save(Map<String, String> json) async => _json = json;
}

final settingsStoreProvider = Provider<SettingsStore>((ref) {
  return FileSettingsStore();
});

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    final defaults = AppSettings.defaults();
    ref.read(settingsStoreProvider).load().then((json) {
      if (json != null) state = AppSettings.fromJson(json, defaults);
    });
    return defaults;
  }

  void update(AppSettings Function(AppSettings) change) {
    state = change(state);
    ref.read(settingsStoreProvider).save(state.toJson());
  }
}
