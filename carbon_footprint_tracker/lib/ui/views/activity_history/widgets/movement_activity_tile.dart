import 'package:carbon_footprint_tracker/extensions/string_extensions.dart';
import 'package:carbon_footprint_tracker/navigation/named_route.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'emission_trailing.dart';

class MovementActivityTile extends StatelessWidget {
  final MovementActivity activity;

  const MovementActivityTile({
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
        leading: Icon(activity.transportMode.icon),
        title: Text(activity.transportMode.name.capitalize()),
        subtitle: Text(
          "${DateFormat.jm().format(activity.startedAt)} \u{2022} ${activity.durationString}",
        ),
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
