import 'dart:developer';

import 'package:async/async.dart';
import 'package:carbon_footprint_tracker/models/event_log/event_log.dart';
import 'package:carbon_footprint_tracker/models/geo/geo.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/tracker_context.dart';
import 'package:carbon_footprint_tracker/models/sensors/sensors.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';
import 'package:carbon_footprint_tracker/services/logging/logging_service.dart';
import 'package:carbon_footprint_tracker/services/questionnaire/questionnaire_service.objectbox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:statemachine/statemachine.dart';
import '../../activity_recognition/activity_recognition.dart';
import '../carbon_tracker.dart';
import '../events/tracker_event.dart';
import '../states/tracker_state.dart';

// final eventsProvider = rp.StreamProvider<TrackerEvent>((ref) async* {
//   final logger = ref.watch(loggingServiceProvider);
//
//   yield* StreamGroup.merge<TrackerEvent>([
//     ActivityRecognition.stream,
//     Geo.stream,
//     Sensors.stream(const Duration(seconds: 5)),
//   ]).handleError((error, stackTrace) {
//     log(error.toString());
//     logger.logEvent(EventLog(
//       dateTime: DateTime.now(),
//       event: "Event stream error: ${error.toString()}",
//     ));
//   });
// });

final eventsProvider = rp.StateProvider<Stream<TrackerEvent>>((ref) {
  return StreamGroup.merge<TrackerEvent>([
    ActivityRecognition.stream,
    Geo.stream,
    Sensors.stream(const Duration(seconds: 5)),
  ]).handleError((error, stackTrace) {
    log(error.toString());
    LoggingService.instance.logEvent(EventLog(
      dateTime: DateTime.now(),
      event: "Event stream error: ${error.toString()}",
    ));
  }).asBroadcastStream();
});

final carbonTrackerProvider = rp.Provider<CarbonTracker>((ref) {
  // ignore: deprecated_member_use
  // final eventStream = ref.watch(eventsProvider.stream);
  final eventStream = ref.watch(eventsProvider);

  final activityService = ref.watch(activityServiceProvider);

  final tracker = CarbonTracker(
    machine: Machine<TrackerState>(),
    eventStream: eventStream,
    activityService: activityService,
    questionnaireService: QuestionnaireServiceObjectBox.instance,
    context: TrackerContext(tmdModelPath: 'assets/models/tmd_rf.json'),
  );

  // tracker.logFood();

  return tracker;
});

// final currentStateProvider = rp.StateProvider<TrackerState?>((ref) {
//   return ref.watch(carbonTrackerProvider).machine.current?.identifier;
// });
