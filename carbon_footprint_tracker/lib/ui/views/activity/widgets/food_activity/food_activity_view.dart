import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:flutter/material.dart';
import '../activity_title.dart';
import '../delete_activity_button.dart';
import '../no_emissions_factor_alert.dart';
import 'consumption_tile.dart';

class FoodActivityView extends StatelessWidget {
  final FoodActivity activity;

  const FoodActivityView({
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
          // ActivityTitle(activity: activity),
          // NoEmissionFactorAlert(activity: activity),
          // const SizedBox(height: 20),
          ConsumptionTile(activity: activity),
        ],
      ),
    );
  }
}
