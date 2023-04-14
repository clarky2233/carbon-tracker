import 'package:carbon_footprint_tracker/models/carbon_activity/constants/vehicle_size.dart';
import 'package:carbon_footprint_tracker/screens/transport_input/transport_input_screen.dart';
import 'package:carbon_footprint_tracker/screens/transport_input/widgets/vehicle_size_selection.dart';
import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleSizeDetails extends ConsumerWidget {
  const VehicleSizeDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size =
        ref.watch(newTripProvider.select((value) => value.vehicleSize));
    final icon = ref.watch(
        newTripProvider.select((value) => value.transportMode.iconOutlined));

    if (size == VehicleSize.none) return const SizedBox();

    return ListTile(
      leading: Icon(icon),
      title: const Text("Vehicle Size"),
      trailing: Text(size.name.capitalize()),
      onTap: () async {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return const VehicleSizeSelection();
          },
        );
      },
    );
  }
}
