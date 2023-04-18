import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/movement_activity_notifier.dart';

class TransportModeSelection extends ConsumerWidget {
  const TransportModeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMode =
        ref.watch(newTripProvider.select((value) => value.transportMode));
    final notifier = ref.watch(newTripProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Transport Mode",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: TransportMode.values.length,
            itemBuilder: (context, i) {
              final mode = TransportMode.values[i];
              final isSelected = mode == selectedMode;
              return Padding(
                padding: const EdgeInsets.only(right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      isSelected: isSelected,
                      enableFeedback: true,
                      iconSize: 40,
                      onPressed: () {
                        notifier.setTransportMode(mode);
                      },
                      icon: Icon(mode.icon),
                    ),
                    Text(
                      mode.name.capitalize(),
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
