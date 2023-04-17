import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.objectbox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activityServiceProvider = StateProvider<ActivityService>((ref) {
  return ActivityServiceObjectBox();
});


abstract class ActivityService {
  Stream<List<CarbonActivity>> getActivityHistory();
}