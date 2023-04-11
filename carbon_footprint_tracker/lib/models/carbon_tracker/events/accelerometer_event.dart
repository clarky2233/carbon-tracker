import 'package:carbon_footprint_tracker/models/carbon_tracker/events/tracker_event.dart';

class AccelerometerDataEvent extends TrackerEvent {
  @override
  final String name = "accelerometer";

  double min;
  double max;
  double mean;
  double std;

  AccelerometerDataEvent([
    this.min = 0,
    this.max = 0,
    this.mean = 0,
    this.std = 0,
  ]);
}
