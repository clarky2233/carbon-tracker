import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/fuel_type.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:carbon_footprint_tracker/models/object_box/object_box.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:carbon_footprint_tracker/widgets/bottom_sheet_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateFuelTypeProvider =
    StateProvider.autoDispose.family<FuelType?, int>((ref, id) {
  final box = store.box<CarbonActivitySchema>();
  final activity = box.get(id)!.toActivity() as MovementActivity;
  return activity.fuelType;
});

class UpdateFuelTypeBottomSheet extends ConsumerWidget {
  final MovementActivity activity;

  const UpdateFuelTypeBottomSheet({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(updateFuelTypeProvider(activity.id));
    final notifier = ref.read(updateFuelTypeProvider(activity.id).notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          const BottomSheetTopBar(),
          Text(
            "Update Fuel Type",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: FuelType.options.length,
              itemBuilder: (context, i) {
                final item = FuelType.options[i];

                return CheckboxListTile(
                  value: selectedItem == item,
                  title: Text(item.text.capitalize()),
                  onChanged: (_) {
                    notifier.state = item;
                    store.box<CarbonActivitySchema>().put(
                          (activity..fuelType = item).toDB(),
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
