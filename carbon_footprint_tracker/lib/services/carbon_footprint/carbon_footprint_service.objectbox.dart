import 'package:carbon_footprint_tracker/services/carbon_footprint/carbon_footprint_service.dart';
import 'package:collection/collection.dart';
import 'package:dart_date/dart_date.dart';
import '../../models/carbon_activity/carbon_activity.dart';
import '../../models/carbon_activity/carbon_activity_schema.dart';
import '../../models/object_box/object_box.dart';
import '../../objectbox.g.dart';

class CarbonFootprintServiceObjectBox implements CarbonFootprintService {
  CarbonFootprintServiceObjectBox._constructor();

  static final CarbonFootprintServiceObjectBox _instance =
      CarbonFootprintServiceObjectBox._constructor();

  static CarbonFootprintServiceObjectBox get instance => _instance;

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

  @override
  Stream<Map<String, double>> getEmissionsByCategory(String range) async* {
    final box = store.box<CarbonActivitySchema>();

    int start = 0;

    if (range == "Past Week") {
      start = DateTime.now()
          .subtract(const Duration(days: 7))
          .startOfDay
          .millisecondsSinceEpoch;
    } else if (range == "Past Month") {
      start = DateTime.now()
          .subtract(const Duration(days: 30))
          .startOfDay
          .millisecondsSinceEpoch;
    }

    final query = box.query(
      CarbonActivitySchema_.startedAt.between(
        start,
        DateTime.now().endOfDay.millisecondsSinceEpoch,
      ),
    );

    yield* query
        .watch(triggerImmediately: true)
        .map((query) => query
            .find()
            .map<CarbonActivity>((dbObject) => dbObject.toActivity())
            .toList())
        .map((activities) => groupBy<CarbonActivity, String>(
              activities,
              (activity) => activity.type,
            ))
        .map(
          (groupedData) => groupedData.map(
            (key, value) => MapEntry<String, double>(
              key,
              value.fold(
                0.0,
                (previousValue, element) =>
                    previousValue + (element.emissions ?? 0),
              ),
            ),
          ),
        );
  }
}
