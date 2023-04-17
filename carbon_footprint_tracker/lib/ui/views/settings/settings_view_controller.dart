import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_controller.dart';
import '../../theme/theme_data.dart';

final settingsViewControllerProvider =
    StateProvider<SettingsViewController>((ref) {
  return SettingsViewController();
});

class SettingsViewController {
  Future<void> updateThemeMode(BuildContext context, bool value) async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = ThemeProvider.of(context);
    final themeController = context.read<ThemeController>();
    final settings = themeProvider.settings.value;
    final newSettings = ThemeSettings(
      sourceColor: settings.sourceColor,
      themeMode: isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );

    ThemeSettingChange(settings: newSettings).dispatch(context);

    await themeController
        .updateThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}
