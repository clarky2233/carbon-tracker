import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/models/object_box/object_box.dart';
import 'package:carbon_footprint_tracker/models/user_info/user_info.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../carbon_activity/constants/food_consumption.dart';
import '../carbon_activity/constants/fuel_type.dart';

class UserInfoNotifier extends Notifier<UserInfo> {
  final box = store.box<UserInfo>();

  @override
  UserInfo build() {
    final userInfoList = box.getAll();
    return userInfoList.isEmpty ? UserInfo() : userInfoList.first;
  }

  void setTransportMode(TransportMode transportMode) {
    state = state.copyWith(
      transportMode:
          transportMode == state.transportMode ? null : transportMode,
    );
  }

  void setFuelType(FuelType fuelType) {
    state = state.copyWith(
      fuelType: fuelType == state.fuelType ? null : fuelType,
    );
  }

  void setFoodConsumption(FoodConsumption foodConsumption) {
    state = state.copyWith(
      foodConsumption:
          foodConsumption == state.foodConsumption ? null : foodConsumption,
    );
  }

  void setElectricityUsage(int usage) {
    state = state.copyWith(electricityUsage: usage);
  }

  void save() {
    box.put(state, mode: state.id == 0 ? PutMode.insert : PutMode.update);
  }
}
