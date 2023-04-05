import 'package:carbon_footprint_tracker/screens/settings/screens/tracking_settings/widgets/activity_permission_tile.dart';
import 'package:carbon_footprint_tracker/screens/settings/screens/tracking_settings/widgets/location_permission_tile.dart';
import 'package:carbon_footprint_tracker/screens/settings/screens/tracking_settings/widgets/tracking_help_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackingSettingsScreen extends ConsumerWidget {
  const TrackingSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar.large(
              title: const Text("Tracking"),
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const TrackingHelpDialog();
                      },
                    );
                  },
                  icon: const Icon(Icons.help_outline),
                ),
              ],
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(activityPermissionStatusProvider);
            ref.invalidate(locationPermissionStatusProvider);
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              ActivityPermissionTile(),
              SizedBox(height: 10),
              LocationPermissionTile(),
            ],
          ),
        ),
      ),
    );
  }
}
