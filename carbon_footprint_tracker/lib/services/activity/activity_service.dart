import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.objectbox.dart';

// final activityServiceProvider = Provider<ActivityService>((ref) {
//   return ActivityServiceObjectBox(store: store);
// });

abstract class ActivityService {
  ActivityService._constructor();

  static final ActivityService _instance = ActivityServiceObjectBox.instance;

  static ActivityService get instance => _instance;

  Stream<List<CarbonActivity>> getActivityHistory();

  Stream<CarbonActivity?> getActivityStream(int id);

  CarbonActivity? getActivity(int id);

  void deleteActivity(int id);

  void updateActivity(CarbonActivity activity);

  void saveActivity(CarbonActivity activity);

  CarbonActivitySchema? getLatestActivity();
}
