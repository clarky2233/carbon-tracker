import 'package:carbon_footprint_tracker/ui/views/food_input/controllers/food_input_view_notifier.dart';
import 'package:carbon_footprint_tracker/ui/views/food_input/widgets/food_input_save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/carbon_activity/constants/food_consumption.dart';

class FoodInputView extends ConsumerWidget {
  const FoodInputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodConsumption = ref.watch(foodInputViewProvider);
    final notifier = ref.watch(foodInputViewProvider.notifier);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar.large(
              title: const Text("Food Entry"),
              actions: const [
                FoodInputSaveButton(),
                SizedBox(width: 16),
              ],
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Select the option that best matches your food intake",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).textTheme.bodySmall!.color,
                    ),
              ),
            ),
            const Divider(height: 32, endIndent: 16, indent: 16),
            ...FoodConsumption.values.map((type) {
              return CheckboxListTile(
                value: foodConsumption == type,
                title: Text(type.text),
                subtitle: Text(type.description),
                onChanged: (_) => notifier.update(type),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
