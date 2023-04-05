import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:carbon_footprint_tracker/screens/activity/food_activity/update_consumption_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsumptionTile extends ConsumerWidget {
  final FoodActivity activity;

  const ConsumptionTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(activity.foodConsumption.icon),
      title: Text(activity.foodConsumption.text),
      subtitle: Text(activity.foodConsumption.description),
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
            return UpdateConsumptionBottomSheet(activity: activity);
          },
        );
      },
    );
  }
}
