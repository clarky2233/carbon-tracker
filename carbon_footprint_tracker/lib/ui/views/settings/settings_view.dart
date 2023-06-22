import 'package:carbon_footprint_tracker/ui/views/settings/widgets/logs_tile.dart';
import 'package:carbon_footprint_tracker/ui/views/settings/widgets/questionnaire_tile.dart';
import 'package:carbon_footprint_tracker/ui/views/settings/widgets/theme_toggle_tile.dart';
import 'package:carbon_footprint_tracker/ui/views/settings/widgets/tracking_permissions_tile.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: const [
          ThemeToggleTile(),
          TrackingPermissionsTile(),
          QuestionnaireTile(),
          LogsTile(),
        ],
      ),
    );
  }
}
