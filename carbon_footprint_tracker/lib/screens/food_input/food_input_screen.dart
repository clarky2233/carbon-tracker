import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:carbon_footprint_tracker/models/object_box/object_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/carbon_activity/constants/food_consumption.dart';

final foodInputProvider = StateProvider.autoDispose<FoodConsumption?>((ref) {
  return null;
});

class FoodInputScreen extends ConsumerWidget {
  const FoodInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodConsumption = ref.watch(foodInputProvider);
    final consumptionNotifier = ref.watch(foodInputProvider.notifier);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar.large(
              title: const Text("Food Entry"),
              actions: [
                FilledButton.icon(
                  onPressed: () {
                    if (foodConsumption == null) return;

                    final box = store.box<CarbonActivitySchema>();

                    box.put(FoodActivity(
                      date: DateTime.now(),
                      foodConsumption: foodConsumption,
                    ).toDB());

                    context.pop();
                  },
                  icon: const Icon(Icons.done),
                  label: const Text("Save"),
                ),
                const SizedBox(width: 16),
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
                onChanged: (bool? value) {
                  consumptionNotifier.state =
                      type == foodConsumption ? null : type;
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
