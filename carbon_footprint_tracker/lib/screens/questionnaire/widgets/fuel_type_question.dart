import 'package:carbon_footprint_tracker/models/carbon_activity/constants/fuel_type.dart';
import 'package:carbon_footprint_tracker/screens/questionnaire/questionnaire_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FuelTypeQuestion extends ConsumerWidget {
  const FuelTypeQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fuelType =
        ref.watch(userInfoProvider.select((value) => value.fuelType));
    final fuelTypeNotifier = ref.watch(userInfoProvider.notifier);

    final enabled = ref
        .watch(userInfoProvider.select((value) => value.transportMode != null));

    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            enabled
                ? "Select the fuel type associated with your primary transport mode"
                : "You must select a primary transport mode first",
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        ...FuelType.values.map((type) {
          return CheckboxListTile(
            enabled: enabled,
            secondary: Icon(type.icon),
            value: fuelType == type,
            title: Text(type.text),
            onChanged: (bool? value) {
              fuelTypeNotifier.setFuelType(type);
            },
          );
        }).toList(),
      ],
    );
  }
}
