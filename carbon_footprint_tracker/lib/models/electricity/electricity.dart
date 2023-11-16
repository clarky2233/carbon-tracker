import 'package:carbon_footprint_tracker/models/carbon_activity/electricity_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';
import 'package:carbon_footprint_tracker/services/questionnaire/questionnaire_service.dart';
import 'package:dart_date/dart_date.dart';

import '../../objectbox.g.dart';
import '../carbon_activity/carbon_activity_schema.dart';
import '../object_box/object_box.dart';

class Electricity {
  void predict() {
    final userInfo = QuestionnaireService.instance.getAnswers();

    final box = store.box<CarbonActivitySchema>();

    final query = box
        .query(CarbonActivitySchema_.type.equals("electricity"))
        .order(CarbonActivitySchema_.startedAt, flags: Order.descending)
        .build();

    final recent = (query.findFirst()?.toActivity() as ElectricityActivity?);

    final allReadyDone = recent?.date.isToday ?? false;

    if (userInfo.electricityUsage != null && !allReadyDone) {
      ActivityService.instance.saveActivity(
        ElectricityActivity(
          date: DateTime.now(),
          kiloWatts: userInfo.electricityUsage!,
        ),
      );
    }
  }
}
