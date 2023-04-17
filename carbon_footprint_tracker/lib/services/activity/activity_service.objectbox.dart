import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';

import '../../models/carbon_activity/carbon_activity_schema.dart';
import '../../models/object_box/object_box.dart';
import '../../objectbox.g.dart';

class ActivityServiceObjectBox implements ActivityService {
  @override
  Stream<List<CarbonActivity>> getActivityHistory() async* {
    final box = store.box<CarbonActivitySchema>();

    final query = box
        .query()
        .order(CarbonActivitySchema_.startedAt, flags: Order.descending);

    yield* query.watch(triggerImmediately: true).map((query) =>
        query.find().map<CarbonActivity>((e) => e.toActivity()).toList());
  }
}
