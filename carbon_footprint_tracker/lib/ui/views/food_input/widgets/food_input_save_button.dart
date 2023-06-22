import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/food_input_view_notifier.dart';

class FoodInputSaveButton extends ConsumerWidget {
  const FoodInputSaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodConsumption = ref.watch(foodInputViewProvider);
    final notifier = ref.watch(foodInputViewProvider.notifier);

    return FilledButton.icon(
      onPressed: () {
        if (foodConsumption == null) return;
        notifier.save();
        context.pop();
      },
      icon: const Icon(Icons.done),
      label: const Text("Save"),
    );
  }
}
