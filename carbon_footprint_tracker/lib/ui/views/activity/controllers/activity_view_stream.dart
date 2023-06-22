import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/carbon_activity/carbon_activity.dart';
import '../../../../services/activity/activity_service.dart';

final activityProvider =
    StreamProvider.autoDispose.family<CarbonActivity?, int>((ref, id) async* {
  final activityService = ref.watch(activityServiceProvider);
  yield* activityService.getActivityStream(id);
});
