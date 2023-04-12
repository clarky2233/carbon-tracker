import 'dart:math';

import 'package:carbon_footprint_tracker/models/carbon_tracker/events/accelerometer_event.dart';
import 'package:carbon_footprint_tracker/models/sensors/tmd_features.dart';
import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:collection/collection.dart';
import 'package:stream_transform/stream_transform.dart';
import '../carbon_tracker/events/tracker_event.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:statistics/statistics.dart';

class Sensors {
  static Stream<TrackerEvent> stream(Duration windowSize) {
    return accelerometerStream(windowSize).combineLatest<Map<String, double>, TrackerEvent>(
        gyroscopeStream(windowSize), (accMap, gyroMap) {
      return TMDSensorEvent(TMDFeatures(
        accelerometerMin: accMap['min']!,
        accelerometerMax: accMap['max']!,
        accelerometerMean: accMap['mean']!,
        accelerometerStd: accMap['std']!,
        gyroscopeMin: gyroMap['min']!,
        gyroscopeMax: gyroMap['max']!,
        gyroscopeMean: gyroMap['mean']!,
        gyroscopeStd: gyroMap['std']!,
      ));
    }).throttle(windowSize);
  }

  static Stream<Map<String, double>> accelerometerStream(Duration windowSize) {
    return accelerometerEvents
        .map((data) => sqrt(pow(data.x, 2) + pow(data.y, 2) + pow(data.z, 2)))
        .window(windowSize)
        .map((window) {
      // print("Accelerometer Window Done");
      return {
        "min": window.min,
        "max": window.max,
        "mean": window.average,
        "std": window.standardDeviation,
      };
    });
  }

  static Stream<Map<String, double>> gyroscopeStream(Duration windowSize) {
    return gyroscopeEvents
        .map((data) => sqrt(pow(data.x, 2) + pow(data.y, 2) + pow(data.z, 2)))
        .window(windowSize)
        .map((window) {
      // print("Gyroscope Window Done");
      return {
        "min": window.min,
        "max": window.max,
        "mean": window.average,
        "std": window.standardDeviation,
      };
    });
  }
}
