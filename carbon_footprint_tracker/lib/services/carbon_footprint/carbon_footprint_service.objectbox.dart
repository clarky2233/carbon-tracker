import 'package:carbon_footprint_tracker/services/carbon_footprint/carbon_footprint_service.dart';
import 'package:dart_date/dart_date.dart';
import '../../models/carbon_activity/carbon_activity.dart';
import '../../models/carbon_activity/carbon_activity_schema.dart';
import '../../objectbox.g.dart';

class CarbonFootprintServiceObjectBox implements CarbonFootprintService {
  final Store store;

  const CarbonFootprintServiceObjectBox({
    required this.store,
  });

  @override
  Stream<double> getTodaysEmissions() async* {
    final box = store.box<CarbonActivitySchema>();

    final query = box.query(
      CarbonActivitySchema_.startedAt.between(
          DateTime.now().startOfDay.millisecondsSinceEpoch,
          DateTime.now().endOfDay.millisecondsSinceEpoch),
    );

    yield* query.watch(triggerImmediately: true).map((query) => query
        .find()
        .map<CarbonActivity>((dbObject) => dbObject.toActivity())
        .fold<double>(0, (sum, activity) => sum += activity.emissions ?? 0));
  }
}
