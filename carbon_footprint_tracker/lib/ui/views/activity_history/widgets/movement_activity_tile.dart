import 'package:carbon_footprint_tracker/extensions/string_extensions.dart';
import 'package:carbon_footprint_tracker/navigation/named_route.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovementActivityTile extends StatelessWidget {
  final MovementActivity activity;

  const MovementActivityTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // tileColor: Theme.of(context).colorScheme.onInverseSurface,
      // iconColor: Theme.of(context).colorScheme.tertiary,
      // leading: Icon(activity.transportMode.icon),
      title: Text(activity.transportMode.name.capitalize()),
      subtitle: Text(activity.startedAt.toHumanString()),
      trailing: Text("${activity.emissions!.toStringAsFixed(1)} kg CO\u{2082}e"),
      onTap: () {
        context.pushNamed(
          NamedRoute.activity.name,
          pathParameters: {'id': activity.id.toString()},
        );
      },
    );
  }
}
