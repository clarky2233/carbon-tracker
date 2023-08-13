import 'package:carbon_footprint_tracker/models/carbon_activity/constants/food_consumption.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FoodInputViewNotifier extends AutoDisposeNotifier<FoodConsumption?> {
  @override
  FoodConsumption? build() {
    return null;
  }

  void update(FoodConsumption consumption) {
    state = state == consumption ? null : consumption;
  }

  void save() {
    if (state == null) return;

    final foodActivity = FoodActivity(
      date: DateTime.now(),
      foodConsumption: state!,
    );

    ActivityService.instance.saveActivity(foodActivity);
  }
}

final foodInputViewProvider =
    NotifierProvider.autoDispose<FoodInputViewNotifier, FoodConsumption?>(
        FoodInputViewNotifier.new);
