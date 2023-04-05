import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/carbon_activity/constants/fuel_type.dart';
import '../../../widgets/bottom_sheet_top_bar.dart';
import '../transport_input_screen.dart';

class FuelTypeSelection extends ConsumerWidget {
  const FuelTypeSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem =
        ref.watch(newTripProvider.select((value) => value.fuelType));
    final notifier = ref.watch(newTripProvider.notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          const BottomSheetTopBar(),
          Text(
            "Fuel Type",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: FuelType.values.length,
              itemBuilder: (context, i) {
                final item = FuelType.values[i];

                return CheckboxListTile(
                  secondary: Icon(item.icon),
                  value: selectedItem == item,
                  title: Text(item.text),
                  onChanged: (_) {
                    notifier.setFuelType(item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
