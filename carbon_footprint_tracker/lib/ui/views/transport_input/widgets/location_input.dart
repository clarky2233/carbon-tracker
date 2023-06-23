import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/movement_activity_notifier.dart';

class LocationInput extends ConsumerWidget {
  const LocationInput({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(newTripProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Start location",
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Enter a start location";
              }
              return null;
            },
            onSaved: (startLocation) {
              notifier.setStartStreet(startLocation!);
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Destination",
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Enter a destination";
              }
              return null;
            },
            onSaved: (destination) {
              notifier.setEndStreet(destination!);
            },
          ),
        ],
      ),
    );
  }
}
