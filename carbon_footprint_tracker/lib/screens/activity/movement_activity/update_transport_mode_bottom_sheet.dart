import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:carbon_footprint_tracker/models/object_box/object_box.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:carbon_footprint_tracker/ui/widgets/bottom_sheet_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateTransportModeProvider =
    StateProvider.autoDispose.family<TransportMode, int>((ref, id) {
  final box = store.box<CarbonActivitySchema>();
  final activity = box.get(id)!.toActivity() as MovementActivity;
  return activity.transportMode;
});

class UpdateTransportModeBottomSheet extends ConsumerWidget {
  final MovementActivity activity;

  const UpdateTransportModeBottomSheet({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(updateTransportModeProvider(activity.id));
    final notifier =
        ref.read(updateTransportModeProvider(activity.id).notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          const BottomSheetTopBar(),
          Text(
            "Update Transport Mode",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: TransportMode.values.length,
              itemBuilder: (context, i) {
                final item = TransportMode.values[i];

                return CheckboxListTile(
                  value: selectedItem == item,
                  title: Text(item.name.capitalize()),
                  secondary: Icon(item.icon),
                  onChanged: (_) {
                    notifier.state = item;
                    store.box<CarbonActivitySchema>().put(
                          (activity
                                ..transportMode = item
                                ..fuelType = item.defaultFuelType
                                ..vehicleSize = item.defaultVehicleSize)
                              .toDB(),
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
