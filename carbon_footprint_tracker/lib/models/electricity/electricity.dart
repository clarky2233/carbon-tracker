import 'package:carbon_footprint_tracker/models/carbon_activity/electricity_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';
import 'package:carbon_footprint_tracker/services/questionnaire/questionnaire_service.dart';

class Electricity {
  void predict() {
    final userInfo = QuestionnaireService.instance.getAnswers();

    if (userInfo.electricityUsage != null) {
      ActivityService.instance.saveActivity(
        ElectricityActivity(
          date: DateTime.now(),
          kiloWatts: userInfo.electricityUsage!,
        ),
      );
    }
  }
}
