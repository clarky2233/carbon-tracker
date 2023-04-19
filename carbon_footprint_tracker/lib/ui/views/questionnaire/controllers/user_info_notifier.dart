import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/models/user_info/user_info.dart';
import 'package:carbon_footprint_tracker/services/questionnaire/questionnaire_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/carbon_activity/constants/food_consumption.dart';
import '../../../../models/carbon_activity/constants/fuel_type.dart';

class UserInfoNotifier extends Notifier<UserInfo> {
  late QuestionnaireService questionnaireService;

  @override
  UserInfo build() {
    questionnaireService = ref.watch(questionnaireServiceProvider);
    return questionnaireService.getAnswers();
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
    questionnaireService.saveAnswers(state);
  }
}

final userInfoProvider =
    NotifierProvider<UserInfoNotifier, UserInfo>(UserInfoNotifier.new);
