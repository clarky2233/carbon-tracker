import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:carbon_footprint_tracker/ui/views/activity/movement_activity/transport_mode_tile.dart';
import 'package:carbon_footprint_tracker/ui/views/activity/movement_activity/vehicle_size_tile.dart';
import 'package:flutter/material.dart';

import '../widgets/activity_title.dart';
import '../widgets/delete_activity_button.dart';
import '../widgets/no_emissions_factor_alert.dart';
import 'activity_details_tile.dart';
import 'activity_end_tile.dart';
import 'activity_start_tile.dart';
import 'fuel_type_tile.dart';

class MovementActivityScreen extends StatelessWidget {
  final MovementActivity activity;

  const MovementActivityScreen({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          DeleteActivityButton(activity: activity),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ActivityTitle(activity: activity),
          NoEmissionFactorAlert(activity: activity),
          const SizedBox(height: 20),
          ActivityStartTile(activity: activity),
          ActivityDetailsTile(activity: activity),
          ActivityEndTile(activity: activity),
          const Divider(indent: 16, endIndent: 16),
          TransportModeTile(activity: activity),
          FuelTypeTile(activity: activity),
          VehicleSizeTile(activity: activity),
        ],
      ),
    );
  }
}
