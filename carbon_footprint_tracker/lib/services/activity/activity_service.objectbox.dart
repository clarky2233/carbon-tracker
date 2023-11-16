import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';

import '../../models/carbon_activity/carbon_activity_schema.dart';
import '../../models/object_box/object_box.dart';
import '../../objectbox.g.dart';

class ActivityServiceObjectBox implements ActivityService {
  ActivityServiceObjectBox._constructor();

  static final ActivityServiceObjectBox _instance =
      ActivityServiceObjectBox._constructor();

  static ActivityServiceObjectBox get instance => _instance;

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
    if (id <= 0) return;

    final activityBox = store.box<CarbonActivitySchema>();
    activityBox.remove(id);
  }

  @override
  CarbonActivity? getActivity(int id) {
    if (id <= 0) return null;

    final box = store.box<CarbonActivitySchema>();
    final activity = box.get(id)?.toActivity();
    return activity;
  }

  @override
  void updateActivity(CarbonActivity activity) {
    if (activity.id <= 0) return;

    store.box<CarbonActivitySchema>().put(
          activity.toDB(),
          mode: PutMode.update,
        );
  }

  @override
  void saveActivity(CarbonActivity activity) {
    final box = store.box<CarbonActivitySchema>();
    box.put(activity.toDB());
  }

  @override
  CarbonActivitySchema? getLatestActivity() {
    final box = store.box<CarbonActivitySchema>();
    final query = box
        .query(CarbonActivitySchema_.type.equals("movement"))
        .order(CarbonActivitySchema_.endedAt, flags: Order.descending)
        .build()
      ..limit = 1;

    List<CarbonActivitySchema> lastActivityList = query.find();

    if (lastActivityList.isEmpty) return null;

    return lastActivityList.first;
  }
}
