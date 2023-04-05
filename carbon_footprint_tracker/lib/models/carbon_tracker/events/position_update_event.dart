import 'package:carbon_footprint_tracker/models/carbon_tracker/events/tracker_event.dart';
import 'package:geolocator/geolocator.dart';

class PositionUpdateEvent extends TrackerEvent {
  @override
  final String name = "positionUpdate";

  final Position? position;

  PositionUpdateEvent([this.position]);
}
