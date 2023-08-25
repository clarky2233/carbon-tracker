import 'package:carbon_footprint_tracker/models/carbon_activity/electricity_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/bottom_sheet_top_bar.dart';
import '../../controllers/activity_view_notifier.dart';

class UpdateUsageBottomSheet extends ConsumerWidget {
  final ElectricityActivity activity;

  const UpdateUsageBottomSheet({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usage = ref.watch(activityViewProvider(activity)
        .select((value) => (value as ElectricityActivity).kiloWatts));
    final controller = ref.read(activityViewProvider(activity).notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          const BottomSheetTopBar(),
          Text(
            "Update Electricity Usage",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(height: 32),
          const SizedBox(height: 32),
          Text(
            "$usage",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          Text(
            "kWh/day",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).textTheme.bodySmall!.color),
          ),
          const SizedBox(height: 16),
          Slider(
            min: 0,
            max: 50,
            label: usage.toString(),
            value: usage.toDouble(),
            onChanged: (val) {
              controller.updateElectricityUsage(val.toInt());
            },
          ),
        ],
      ),
    );
  }
}
