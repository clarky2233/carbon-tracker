import 'package:carbon_footprint_tracker/ui/theme/theme_service.dart';
import 'package:flutter/material.dart';

class ThemeController with ChangeNotifier {
  ThemeController(this._themeService);

  // Make SettingsService a private variable so it is not used directly.
  final ThemeService _themeService;

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> load() async {
    _themeMode = await _themeService.themeMode();
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Dot not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new theme mode in memory
    _themeMode = newThemeMode;

    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _themeService.updateThemeMode(newThemeMode);
  }
}