import 'package:carbon_footprint_tracker/ui/views/home/controllers/chart_time_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartTimeSelector extends ConsumerWidget {
  const ChartTimeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ranges = ["All time", "Past Week", "Past Month"];

    final selected = ref.watch(chartTimePeriodProvider);
    final notifier = ref.watch(chartTimePeriodProvider.notifier);

    return SegmentedButton<String>(
      segments: ranges
          .map((item) => ButtonSegment(
                value: item,
                label: Text(item),
              ))
          .toList(),
      selected: {selected},
      onSelectionChanged: (x) {
        notifier.state = x.first;
      },
    );
  }
}
