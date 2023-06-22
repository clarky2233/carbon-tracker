import 'package:carbon_footprint_tracker/models/carbon_activity/constants/fuel_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/movement_activity_notifier.dart';
import 'fuel_type_selection.dart';

class FuelTypeDetails extends ConsumerWidget {
  const FuelTypeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fuel = ref.watch(newTripProvider.select((value) => value.fuelType));
    final icon =
        ref.watch(newTripProvider.select((value) => value.fuelType.icon));

    if (fuel == FuelType.none) return const SizedBox();

    return ListTile(
      leading: Icon(icon),
      title: const Text("Fuel Type"),
      trailing: Text(fuel.text),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const FuelTypeSelection(),
        );
      },
    );
  }
}
