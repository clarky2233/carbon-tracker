import 'package:carbon_footprint_tracker/models/carbon_tracker/events/tracker_event.dart';

class InVehicleEvent extends TrackerEvent {
  @override
  final String name = "inVehicle";

  InVehicleEvent();
}