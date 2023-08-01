import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:carbon_footprint_tracker/ui/views/activity/widgets/movement_activity/transport_mode_tile.dart';
import 'package:carbon_footprint_tracker/ui/views/activity/widgets/movement_activity/vehicle_size_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../activity_title.dart';
import '../delete_activity_button.dart';
import '../no_emissions_factor_alert.dart';
import 'activity_details_tile.dart';
import 'activity_end_tile.dart';
import 'activity_start_tile.dart';
import 'fuel_type_tile.dart';

class MovementActivityView extends StatelessWidget {
  final MovementActivity activity;

  const MovementActivityView({
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Text(
            activity.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16),
          Text(
            "Emissions: ${activity.emissions!.toStringAsFixed(2)} kg CO\u{2082}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Divider(height: 32),
          Text(
              "Start Time: ${DateFormat("EEEE, d MMM \t\u{2022}\t").add_jm().format(activity.startedAt)}"),
          const SizedBox(height: 16),
          Text(
              "End Time: ${DateFormat("EEEE, d MMM \t\u{2022}\t").add_jm().format(activity.endedAt)}"),
          const SizedBox(height: 16),
          Text("Duration: ${activity.durationString}"),
          const Divider(height: 32),
          Text("Start Location: ${activity.fullStartAddress}"),
          const SizedBox(height: 16),
          Text("End Location: ${activity.fullEndAddress}"),
          const SizedBox(height: 16),
          Text("Distance: ${activity.distanceString}"),
          const Divider(height: 32),
          // ActivityTitle(activity: activity),
          // NoEmissionFactorAlert(activity: activity),
          // const SizedBox(height: 20),
          // ActivityStartTile(activity: activity),
          // ActivityDetailsTile(activity: activity),
          // ActivityEndTile(activity: activity),
          // const Divider(indent: 16, endIndent: 16),
          TransportModeTile(activity: activity),
          FuelTypeTile(activity: activity),
          VehicleSizeTile(activity: activity),
        ],
      ),
    );
  }
}
