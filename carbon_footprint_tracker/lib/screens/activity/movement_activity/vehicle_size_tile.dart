import 'package:carbon_footprint_tracker/screens/activity/movement_activity/update_vehicle_size_bottom_sheet.dart';
import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/carbon_activity/movement_activity.dart';

class VehicleSizeTile extends ConsumerWidget {
  final MovementActivity activity;

  const VehicleSizeTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (activity.vehicleSize == null) return const SizedBox();

    return ListTile(
      leading: Icon(activity.transportMode.iconOutlined),
      title: Text(activity.vehicleSize?.name.capitalize() ?? "None"),
      subtitle: const Text("Vehicle Size"),
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
            return UpdateVehicleSizeBottomSheet(activity: activity);
          },
        );
      },
    );
  }
}
