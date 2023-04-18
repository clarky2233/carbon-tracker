import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activityHistoryProvider =
    StreamProvider<List<CarbonActivity>>((ref) async* {
  final activityService = ref.watch(activityServiceProvider);
  yield* activityService.getActivityHistory();
});
