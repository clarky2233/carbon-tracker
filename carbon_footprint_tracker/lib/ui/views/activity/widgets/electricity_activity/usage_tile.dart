import 'package:carbon_footprint_tracker/models/carbon_activity/electricity_activity.dart';
import 'package:carbon_footprint_tracker/ui/views/activity/widgets/electricity_activity/update_usage_bottom_sheet.dart';
import 'package:flutter/material.dart';

class UsageTile extends StatelessWidget {
  final ElectricityActivity activity;

  const UsageTile({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.power),
      title: Text("${activity.kiloWatts} kWh"),
      subtitle: const Text("Daily energy usage"),
      trailing: IgnorePointer(
        child: IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {},
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return UpdateUsageBottomSheet(activity: activity);
          },
        );
      },
    );
  }
}
