import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:flutter/material.dart';

class ActivityDetailsTile extends StatelessWidget {
  final MovementActivity activity;

  const ActivityDetailsTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.more_vert),
      title: Text(
        "${activity.durationString} \t\u{2022}\t ${activity.distanceString}",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
      ),
    );
  }
}
