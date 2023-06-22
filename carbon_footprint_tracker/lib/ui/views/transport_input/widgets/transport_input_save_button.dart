import 'package:carbon_footprint_tracker/ui/views/transport_input/controllers/movement_activity_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransportInputSaveButton extends ConsumerWidget {
  const TransportInputSaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(newTripProvider.notifier);

    return FilledButton.icon(
      onPressed: () {
        notifier.saveActivity();
        context.pop();
      },
      icon: const Icon(Icons.done),
      label: const Text("Save"),
    );
  }
}
