import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> themeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLightTheme = prefs.getBool('isLightTheme');
    if (isLightTheme == null) {
      return ThemeMode.system;
    }
    if (!isLightTheme) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLightTheme", theme == ThemeMode.light);
  }
}