import 'dart:developer';

import 'package:carbon_footprint_tracker/models/carbon_tracker/events/walking_event.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';

import '../carbon_tracker/events/in_vehicle_event.dart';
import '../carbon_tracker/events/on_bicycle_event.dart';
import '../carbon_tracker/events/running_event.dart';
import '../carbon_tracker/events/still_event.dart';
import '../carbon_tracker/events/tracker_event.dart';

final activityRecognition = FlutterActivityRecognition.instance;

class ActivityRecognition {
  static Stream<TrackerEvent> get stream {
    final Stream<TrackerEvent> activityStream = activityRecognition
        .activityStream
        .where((activity) =>
            activity.type != ActivityType.UNKNOWN &&
            activity.confidence == ActivityConfidence.HIGH)
        .map((activity) => toTrackerEvent(activity));

    return activityStream;
  }

  static Future<bool> requestPermissions() async {
    PermissionRequestResult reqResult;
    reqResult = await activityRecognition.checkPermission();
    if (reqResult == PermissionRequestResult.PERMANENTLY_DENIED) {
      log('Activity Recognition Permission: Permanently denied.');
      return false;
    } else if (reqResult == PermissionRequestResult.DENIED) {
      reqResult = await activityRecognition.requestPermission();
      if (reqResult != PermissionRequestResult.GRANTED) {
        log('Activity Recognition Permission: Permission is denied.');
        return false;
      }
    }

    log("Activity Recognition Permission:  Permission granted.");
    return true;
  }

  static final Map<ActivityType, TrackerEvent> _activityTypeToEvent = {
    ActivityType.STILL: StillEvent(),
    ActivityType.IN_VEHICLE: InVehicleEvent(),
    ActivityType.ON_BICYCLE: OnBicycleEvent(),
    ActivityType.RUNNING: RunningEvent(),
    ActivityType.WALKING: WalkingEvent(),
  };

  static TrackerEvent toTrackerEvent(Activity activity) {
    return _activityTypeToEvent[activity.type]!;
  }
}
