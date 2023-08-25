import 'package:carbon_footprint_tracker/models/carbon_activity/electricity_activity.dart';
import 'package:carbon_footprint_tracker/ui/views/activity/widgets/electricity_activity/usage_tile.dart';
import 'package:flutter/material.dart';

import '../activity_title.dart';
import '../delete_activity_button.dart';

class ElectricityActivityView extends StatelessWidget {
  final ElectricityActivity activity;

  const ElectricityActivityView({
    super.key,
    required this.activity,
  });

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
          const SizedBox(height: 20),
          UsageTile(activity: activity),
        ],
      ),
    );
  }
}
