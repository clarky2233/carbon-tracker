import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.objectbox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activityServiceProvider = Provider<ActivityService>((ref) {
  return ActivityServiceObjectBox();
});

abstract class ActivityService {
  Stream<List<CarbonActivity>> getActivityHistory();

  Stream<CarbonActivity?> getActivityStream(int id);

  CarbonActivity? getActivity(int id);

  void deleteActivity(int id);

  void updateActivity(CarbonActivity activity);

  void saveActivity(CarbonActivity activity);
}
