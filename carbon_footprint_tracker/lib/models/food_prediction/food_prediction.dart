import 'dart:developer' as dev;
import 'dart:math';

import 'package:carbon_footprint_tracker/extensions/list_extensions.dart';
import 'package:carbon_footprint_tracker/extensions/map_extensions.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/food_consumption.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';
import 'package:carbon_footprint_tracker/services/questionnaire/questionnaire_service.dart';
import 'package:dart_date/dart_date.dart';

import '../../objectbox.g.dart';
import '../carbon_activity/carbon_activity_schema.dart';

class FoodPrediction {
  final Store store;

  FoodPrediction({
    required this.store,
  });

  void predict() {
    List<FoodConsumption> votes = [];

    final mostCommon = getMostCommon();
    if (mostCommon != null) {
      dev.log("Most Common: $mostCommon");
      votes.add(mostCommon);
    }

    final mostRecent = getMostRecent();
    if (mostRecent != null) {
      dev.log("Most Recent: $mostRecent");
      votes.add(mostRecent);
    }

    final mostCommonWeekDay = getMostCommonForDayOfWeek();
    if (mostCommonWeekDay != null) {
      dev.log("Weekday: $mostCommonWeekDay");
      votes.add(mostCommonWeekDay);
    }

    final mostCommon30Days = getMostCommonLast30Days();
    if (mostCommon30Days != null) {
      dev.log("30 Days: $mostCommon30Days");
      votes.add(mostCommon30Days);
    }

    final questionnaire = getQuestionnaireAnswer();
    if (questionnaire != null) {
      dev.log("Questionnaire: $questionnaire");
      votes.add(questionnaire);
    }

    votes.add(getRandom());

    dev.log(votes.toString());

    final prediction = votes.mostCommon();

    dev.log("prediction: $prediction");

    if (prediction != null && !todayComplete()) {
      ActivityService.instance.saveActivity(
        FoodActivity(
          date: DateTime.now(),
          foodConsumption: prediction,
        ),
      );
    }
  }

  List<FoodActivity> getFoodHistory() {
    final box = store.box<CarbonActivitySchema>();

    final query = box
        .query(CarbonActivitySchema_.type.equals("food"))
        .order(CarbonActivitySchema_.startedAt, flags: Order.descending)
        .build();

    return query.find().map((e) => e.toActivity() as FoodActivity).toList();
  }

  FoodConsumption? getMostCommon() {
    final Map<FoodConsumption, int> data = {};

    final box = store.box<CarbonActivitySchema>();

    for (FoodConsumption foodConsumption in FoodConsumption.values) {
      final query = box
          .query(CarbonActivitySchema_.type.equals("food").and(
              CarbonActivitySchema_.dbFoodConsumption
                  .equals(foodConsumption.name)))
          .build();

      data[foodConsumption] = query.count();
    }

    return data.max();
  }

  FoodConsumption? getMostRecent() {
    final box = store.box<CarbonActivitySchema>();

    final query = box
        .query(CarbonActivitySchema_.type.equals("food"))
        .order(CarbonActivitySchema_.startedAt, flags: Order.descending)
        .build();

    return (query.findFirst()?.toActivity() as FoodActivity?)?.foodConsumption;
  }

  bool todayComplete() {
    final box = store.box<CarbonActivitySchema>();

    final query = box
        .query(CarbonActivitySchema_.type.equals("food"))
        .order(CarbonActivitySchema_.startedAt, flags: Order.descending)
        .build();

    final recent = (query.findFirst()?.toActivity() as FoodActivity?);

    if (recent == null) return false;

    return recent.date.isToday;
  }

  FoodConsumption? getMostCommonForDayOfWeek() {
    final foodData = getFoodHistory();

    Map<FoodConsumption, int> dayFoodFreq = {};
    for (FoodActivity activity in foodData) {
      if (activity.date.weekday == DateTime.now().weekday) {
        dayFoodFreq.update(
          activity.foodConsumption,
          (value) => ++value,
          ifAbsent: () => 1,
        );
      }
    }

    return dayFoodFreq.max();
  }

  FoodConsumption? getMostCommonLast30Days() {
    final foodData = getFoodHistory();

    Map<FoodConsumption, int> freq = {};

    final filtered = foodData.where(
      (activity) => DateTime.now().difference(activity.date).inDays < 30,
    );

    for (FoodActivity activity in filtered) {
      if (activity.date.weekday == DateTime.now().weekday) {
        freq.update(
          activity.foodConsumption,
          (value) => ++value,
          ifAbsent: () => 1,
        );
      }
    }

    return freq.max();
  }

  FoodConsumption getRandom() {
    final random = Random();
    final index = random.nextInt(FoodConsumption.values.length);
    return FoodConsumption.values[index];
  }

  FoodConsumption? getQuestionnaireAnswer() {
    final userInfo = QuestionnaireService.instance.getAnswers();

    return userInfo.foodConsumption;
  }
}
