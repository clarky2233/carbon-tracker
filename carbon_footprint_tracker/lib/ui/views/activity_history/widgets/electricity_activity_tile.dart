import 'package:carbon_footprint_tracker/models/carbon_activity/electricity_activity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/named_route.dart';
import 'emission_trailing.dart';

class ElectricityActivityTile extends StatelessWidget {
  final ElectricityActivity activity;

  const ElectricityActivityTile({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.onInverseSurface,
        iconColor: Theme.of(context).colorScheme.tertiary,
        leading: const Icon(Icons.power),
        title: const Text("Electricity"),
        subtitle: Text("${activity.kiloWatts} kWh"),
        trailing: EmissionTrailing(activity: activity),
        onTap: () {
          context.pushNamed(
            NamedRoute.activity.name,
            pathParameters: {'id': activity.id.toString()},
          );
        },
      ),
    );
  }
}
