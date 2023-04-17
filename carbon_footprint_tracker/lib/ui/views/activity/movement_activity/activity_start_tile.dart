import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityStartTile extends StatelessWidget {
  final MovementActivity activity;

  const ActivityStartTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on_outlined),
      title: Text(
        DateFormat("EEEE, d MMM \t\u{2022}\t")
            .add_jm()
            .format(activity.startedAt),
      ),
      subtitle: Text(activity.fullStartAddress),
    );
  }
}
