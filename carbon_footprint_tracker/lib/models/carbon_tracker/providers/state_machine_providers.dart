import 'package:async/async.dart';
import 'package:carbon_footprint_tracker/models/geo/geo.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/tracker_context.dart';
import 'package:carbon_footprint_tracker/models/sensors/sensors.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';
import 'package:carbon_footprint_tracker/services/logging/logging_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:statemachine/statemachine.dart';
import '../../activity_recognition/activity_recognition.dart';
import '../carbon_tracker.dart';
import '../events/tracker_event.dart';
import '../states/tracker_state.dart';

final eventsProvider = rp.StreamProvider<TrackerEvent>((ref) async* {
  yield* StreamGroup.merge<TrackerEvent>([
    ActivityRecognition.stream,
    Geo.stream,
    Sensors.stream(const Duration(seconds: 5)),
  ]);
});

final carbonTrackerProvider = rp.Provider<CarbonTracker>((ref) {
  // ignore: deprecated_member_use
  final eventStream = ref.watch(eventsProvider.stream);

  final activityService = ref.watch(activityServiceProvider);
  final loggingService = ref.watch(loggingServiceProvider);

  final tracker = CarbonTracker(
    machine: Machine<TrackerState>(),
    context: TrackerContext(tmdModelPath: 'assets/models/tmd_rf.json'),
    eventStream: eventStream,
    activityService: activityService,
    loggingService: loggingService,
  );

  // tracker.logFood();

  return tracker;
});

// final currentStateProvider = rp.StateProvider<TrackerState?>((ref) {
//   return ref.watch(carbonTrackerProvider).machine.current?.identifier;
// });
