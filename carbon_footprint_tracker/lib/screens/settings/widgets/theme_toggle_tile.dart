import 'package:carbon_footprint_tracker/config/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/theme_data.dart';

class ThemeToggleTile extends ConsumerWidget {
  const ThemeToggleTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final themeController = context.read<ThemeController>();

    return ListTile(
      leading: Icon(Theme.of(context).brightness == Brightness.light
          ? Icons.dark_mode_outlined
          : Icons.light_mode_outlined),
      title: const Text("Theme"),
      subtitle: Text("Switch to ${isDarkMode ? 'light' : 'dark'} mode"),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (bool value) async {
          final themeProvider = ThemeProvider.of(context);
          final settings = themeProvider.settings.value;
          final newSettings = ThemeSettings(
            sourceColor: settings.sourceColor,
            themeMode: isDarkMode ? ThemeMode.light : ThemeMode.dark,
          );

          ThemeSettingChange(settings: newSettings).dispatch(context);

          await themeController
              .updateThemeMode(value ? ThemeMode.dark : ThemeMode.light);
        },
      ),
    );
  }
}
