import 'package:carbon_footprint_tracker/ui/views/transport_input/controllers/movement_activity_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransportInputSaveButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const TransportInputSaveButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(newTripProvider.notifier);

    return FilledButton.icon(
      onPressed: () async {
        if (!(formKey.currentState?.validate() ?? false)) return;
        formKey.currentState!.save();

        final success = await notifier.saveActivity();

        if (context.mounted && success) {
          context.pop();
        }
      },
      icon: const Icon(Icons.done),
      label: const Text("Save"),
    );
  }
}
