import 'package:carbon_footprint_tracker/screens/transport_input/transport_input_screen.dart';
import 'package:carbon_footprint_tracker/screens/transport_input/widgets/fuel_type_details.dart';
import 'package:carbon_footprint_tracker/screens/transport_input/widgets/vehicle_size_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsInput extends ConsumerWidget {
  const DetailsInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noShow = ref.watch(newTripProvider.select(
        (value) => value.vehicleSize == null && value.fuelType == null));

    if (noShow) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Details",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        const VehicleSizeDetails(),
        const FuelTypeDetails(),
      ],
    );
  }
}
