import 'package:carbon_footprint_tracker/models/carbon_tracker/events/tracker_event.dart';

class OnBicycleEvent extends TrackerEvent {
  @override
  final String name = "onBicycle";

  OnBicycleEvent();
}