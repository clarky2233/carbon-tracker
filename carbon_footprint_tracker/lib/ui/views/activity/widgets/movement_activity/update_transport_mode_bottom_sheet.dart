import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:carbon_footprint_tracker/ui/widgets/bottom_sheet_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/activity_view_notifier.dart';

class UpdateTransportModeBottomSheet extends ConsumerWidget {
  final MovementActivity activity;

  const UpdateTransportModeBottomSheet({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(activityViewProvider(activity)
        .select((value) => (value as MovementActivity).transportMode));
    final controller =
        ref.read(activityViewProvider(activity).notifier);

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
                    controller.updateTransportMode(item);
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
