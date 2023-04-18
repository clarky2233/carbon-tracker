import 'package:carbon_footprint_tracker/models/carbon_activity/constants/fuel_type.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/carbon_activity/carbon_activity.dart';
import '../../../../models/carbon_activity/constants/food_consumption.dart';
import '../../../../models/carbon_activity/constants/vehicle_size.dart';
import '../../../../services/activity/activity_service.dart';

class ActivityViewNotifier
    extends AutoDisposeFamilyNotifier<CarbonActivity, CarbonActivity> {
  late ActivityService activityService;

  ActivityViewNotifier();

  @override
  CarbonActivity build(CarbonActivity arg) {
    activityService = ref.watch(activityServiceProvider);
    return arg;
  }

  void deleteActivity() {
    activityService.deleteActivity(state.id);
  }

  void updateFoodConsumption(FoodConsumption foodConsumption) {
    if (state is! FoodActivity) return;

    state = (state as FoodActivity).copyWith(foodConsumption: foodConsumption);

    activityService.updateActivity(state);
  }

  void updateTransportMode(TransportMode transportMode) {
    if (state is! MovementActivity) return;

    state = (state as MovementActivity).copyWith(
      transportMode: transportMode,
      vehicleSize: transportMode.defaultVehicleSize,
      fuelType: transportMode.defaultFuelType,
    );

    activityService.updateActivity(state);
  }

  void updateVehicleSize(VehicleSize vehicleSize) {
    if (state is! MovementActivity) return;

    state = (state as MovementActivity).copyWith(vehicleSize: vehicleSize);

    activityService.updateActivity(state);
  }

  void updateFuelType(FuelType fuelType) {
    if (state is! MovementActivity) return;

    state = (state as MovementActivity).copyWith(fuelType: fuelType);

    activityService.updateActivity(state);
  }
}

final activityViewProvider = NotifierProvider.family
    .autoDispose<ActivityViewNotifier, CarbonActivity, CarbonActivity>(
        ActivityViewNotifier.new);
