import 'package:carbon_footprint_tracker/extensions/string_extensions.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/vehicle_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/bottom_sheet_top_bar.dart';
import '../controllers/movement_activity_notifier.dart';

class VehicleSizeSelection extends ConsumerWidget {
  const VehicleSizeSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem =
        ref.watch(newTripProvider.select((value) => value.vehicleSize));
    final notifier = ref.watch(newTripProvider.notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          const BottomSheetTopBar(),
          Text(
            "Vehicle Size",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: VehicleSize.options.length,
              itemBuilder: (context, i) {
                final item = VehicleSize.options[i];

                return CheckboxListTile(
                  value: selectedItem == item,
                  title: Text(item.name.capitalize()),
                  onChanged: (_) {
                    notifier.setVehicleSize(item);
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
