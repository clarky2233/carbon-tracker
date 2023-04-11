import 'dart:math';

import 'package:carbon_footprint_tracker/models/carbon_tracker/events/accelerometer_event.dart';
import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:collection/collection.dart';
import '../carbon_tracker/events/tracker_event.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:statistics/statistics.dart';

class Sensors {
  static Stream<TrackerEvent> get accelerometerStream {
    return accelerometerEvents
        .map((data) => sqrt(pow(data.x, 2) + pow(data.y, 2) + pow(data.z, 2)))
        .window(const Duration(seconds: 5))
        .map((window) => AccelerometerDataEvent(
              window.min,
              window.max,
              window.average,
              window.standardDeviation,
            ));
  }
}
