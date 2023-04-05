import 'package:carbon_footprint_tracker/models/carbon_activity/constants/food_consumption.dart';
import 'package:carbon_footprint_tracker/screens/questionnaire/questionnaire_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodConsumptionQuestion extends ConsumerWidget {
  const FoodConsumptionQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consumption =
        ref.watch(userInfoProvider.select((value) => value.foodConsumption));
    final consumptionNotifier = ref.watch(userInfoProvider.notifier);

    return ListView(
      shrinkWrap: true,
      children: [
        const Text(
          "Select your average daily food intake",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ...FoodConsumption.values.map((type) {
          return CheckboxListTile(
            value: consumption == type,
            title: Text(type.text),
            subtitle: Text(type.description),
            onChanged: (bool? value) {
              consumptionNotifier.setFoodConsumption(type);
            },
          );
        }).toList(),
      ],
    );
  }
}
