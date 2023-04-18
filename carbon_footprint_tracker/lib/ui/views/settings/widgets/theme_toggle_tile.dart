import 'package:carbon_footprint_tracker/ui/views/settings/controllers/settings_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeToggleTile extends ConsumerWidget {
  const ThemeToggleTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final controller = ref.watch(settingsViewProvider.notifier);

    return ListTile(
      leading: Icon(
          !isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
      title: const Text("Theme"),
      subtitle: Text("Switch to ${isDarkMode ? 'light' : 'dark'} mode"),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (bool value) async =>
            await controller.updateThemeMode(context, value),
      ),
    );
  }
}
