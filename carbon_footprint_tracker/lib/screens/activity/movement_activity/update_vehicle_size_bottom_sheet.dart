import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/vehicle_size.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:carbon_footprint_tracker/models/object_box/object_box.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:carbon_footprint_tracker/widgets/bottom_sheet_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateVehicleSizeProvider =
    StateProvider.autoDispose.family<VehicleSize?, int>((ref, id) {
  final box = store.box<CarbonActivitySchema>();
  final activity = box.get(id)!.toActivity() as MovementActivity;
  return activity.vehicleSize;
});

class UpdateVehicleSizeBottomSheet extends ConsumerWidget {
  final MovementActivity activity;

  const UpdateVehicleSizeBottomSheet({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(updateVehicleSizeProvider(activity.id));
    final notifier = ref.read(updateVehicleSizeProvider(activity.id).notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          const BottomSheetTopBar(),
          Text(
            "Update Vehicle Size",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: VehicleSize.values.length,
              itemBuilder: (context, i) {
                final item = VehicleSize.values[i];

                return CheckboxListTile(
                  value: selectedItem == item,
                  title: Text(item.name.capitalize()),
                  onChanged: (_) {
                    notifier.state = item;
                    store.box<CarbonActivitySchema>().put(
                          (activity..vehicleSize = item).toDB(),
                          mode: PutMode.update,
                        );
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
