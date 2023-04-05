import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:carbon_footprint_tracker/screens/activity/food_activity/consumption_tile.dart';
import 'package:carbon_footprint_tracker/screens/activity/widgets/no_emissions_factor_alert.dart';
import 'package:flutter/material.dart';

import '../widgets/activity_title.dart';
import '../widgets/delete_activity_button.dart';

class FoodActivityScreen extends StatelessWidget {
  final FoodActivity activity;

  const FoodActivityScreen({
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
          ConsumptionTile(activity: activity),
        ],
      ),
    );
  }
}
