import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/named_route.dart';
import 'emission_trailing.dart';

class FoodActivityTile extends StatelessWidget {
  final FoodActivity activity;

  const FoodActivityTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // tileColor: Theme.of(context).colorScheme.onInverseSurface,
      // iconColor: Theme.of(context).colorScheme.tertiary,
      // leading: Icon(activity.foodConsumption.icon),
      title: Text(activity.foodConsumption.text),
      subtitle: Text(activity.date.toHumanString()),
      trailing:
          Text("${activity.emissions!.toStringAsFixed(1)} kg CO\u{2082}e"),
      onTap: () {
        context.pushNamed(
          NamedRoute.activity.name,
          pathParameters: {'id': activity.id.toString()},
        );
      },
    );
  }
}
