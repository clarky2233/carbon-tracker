import 'package:carbon_footprint_tracker/extensions/map_extensions.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/food_consumption.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';

import '../../objectbox.g.dart';
import '../carbon_activity/carbon_activity_schema.dart';
import 'package:collection/collection.dart';

class FoodPrediction {
  final Store store;

  FoodPrediction({
    required this.store,
  });

  void getData() {
    final box = store.box<CarbonActivitySchema>();

    final query = box
        .query(CarbonActivitySchema_.type.equals(FoodActivity.type))
        .order(CarbonActivitySchema_.startedAt, flags: Order.descending)
        .build();

    final foodData =
        query.find().map((e) => e.toActivity() as FoodActivity).toList();

    List<FoodConsumption> votes = [];

    // Group by food consumption count
    Map<FoodConsumption, int> allFoodFreq = {};
    Map<FoodConsumption, int> dayFoodFreq = {};
    for (FoodActivity activity in foodData) {
      allFoodFreq.update(
        activity.foodConsumption,
        (value) => ++value,
        ifAbsent: () => 1,
      );

      if (activity.date.weekday == DateTime.now().weekday) {
        dayFoodFreq.update(
          activity.foodConsumption,
          (value) => ++value,
          ifAbsent: () => 1,
        );
      }
    }

    // Most recent food consumption
    FoodConsumption? mostRecent = foodData.firstOrNull?.foodConsumption;
    if (mostRecent != null) votes.add(mostRecent);

    // Most frequent food consumption
    final mostFreq = allFoodFreq.max();
    if (mostFreq != null) votes.add(mostFreq);

    // Most frequency food consumption for specific day
    final dayFreq = dayFoodFreq.max();
    if (dayFreq != null) votes.add(dayFreq);

    print(votes);
  }
}
