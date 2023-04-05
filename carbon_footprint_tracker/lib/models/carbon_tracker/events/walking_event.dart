import 'package:carbon_footprint_tracker/models/carbon_tracker/events/tracker_event.dart';

class WalkingEvent extends TrackerEvent {
  @override
  final String name = "walking";

  WalkingEvent();
}