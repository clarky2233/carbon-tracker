import 'package:carbon_footprint_tracker/models/carbon_activity/constants/fuel_type.dart';
import 'package:carbon_footprint_tracker/screens/activity/movement_activity/update_fuel_type_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/carbon_activity/movement_activity.dart';

class FuelTypeTile extends ConsumerWidget {
  final MovementActivity activity;

  const FuelTypeTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (activity.fuelType == FuelType.none) return const SizedBox();

    return ListTile(
      leading: Icon(activity.fuelType.icon),
      title: Text(activity.fuelType.text),
      subtitle: const Text("Fuel Type"),
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
            return UpdateFuelTypeBottomSheet(activity: activity);
          },
        );
      },
    );
  }
}
