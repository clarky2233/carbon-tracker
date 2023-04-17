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

  @override
  Stream<CarbonActivity?> getActivityStream(int id) async* {
    yield* store
        .box<CarbonActivitySchema>()
        .query(CarbonActivitySchema_.id.equals(id))
        .watch(triggerImmediately: true)
        .map((query) {
      final activity = query.find().map((e) => e.toActivity());
      if (activity.isEmpty) return null;
      return activity.first;
    });
  }

  @override
  void deleteActivity(int id) {
    final activityBox = store.box<CarbonActivitySchema>();
    activityBox.remove(id);
  }

  @override
  CarbonActivity? getActivity(int id) {
    final box = store.box<CarbonActivitySchema>();
    final activity = box.get(id)?.toActivity();
    return activity;
  }

  @override
  void updateActivity(CarbonActivity activity) {
    store.box<CarbonActivitySchema>().put(
          activity.toDB(),
          mode: PutMode.update,
        );
  }
}
