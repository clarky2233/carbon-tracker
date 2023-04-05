import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:carbon_footprint_tracker/screens/activity_history/widgets/emission_trailing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routing/named_route.dart';

class FoodActivityTile extends StatelessWidget {
  final FoodActivity activity;

  const FoodActivityTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.onInverseSurface,
        iconColor: Theme.of(context).colorScheme.tertiary,
        leading: Icon(activity.foodConsumption.icon),
        title: const Text("Food"),
        subtitle: Text(activity.foodConsumption.text),
        trailing: EmissionTrailing(activity: activity),
        onTap: () {
          context.pushNamed(
            NamedRoute.activity.name,
            params: {'id': activity.id.toString()},
          );
        },
      ),
    );
  }
}
