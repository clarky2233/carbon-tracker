import 'package:carbon_footprint_tracker/models/carbon_tracker/events/tracker_event.dart';

class RunningEvent extends TrackerEvent {
  @override
  final String name = "running";

  RunningEvent();
}