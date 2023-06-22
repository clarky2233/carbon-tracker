import 'dart:math';
import 'dart:developer' as dev;
import 'package:carbon_footprint_tracker/extensions/stream_extensions.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/accelerometer_event.dart';
import 'package:carbon_footprint_tracker/models/sensors/tmd_features.dart';
import 'package:collection/collection.dart';
import 'package:stream_transform/stream_transform.dart';
import '../carbon_tracker/events/tracker_event.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:statistics/statistics.dart';

class Sensors {
  static Stream<TrackerEvent> stream(Duration windowSize) {
    return accelerometerStream(windowSize)
        .combineLatestAll([
          gyroscopeStream(windowSize),
          magnetometerStream(windowSize),
        ])
        .handleError((error) {
          dev.log("1234567");
          dev.log(error.toString());
        })
        // .where((events) =>
        //     events.map((e) => (e['id'] ?? 0).toInt()).toSet().length == 1)
        .map(
          (events) {
            final accMap = events[0];
            final gyroMap = events[1];
            final magMap = events[2];

            dev.log("${accMap['id']} TMD Sensor Event!!!!");

            return TMDSensorEvent(TMDFeatures(
              accelerometerMin: accMap['min']!,
              accelerometerMax: accMap['max']!,
              accelerometerMean: accMap['mean']!,
              accelerometerStd: accMap['std']!,
              gyroscopeMin: gyroMap['min']!,
              gyroscopeMax: gyroMap['max']!,
              gyroscopeMean: gyroMap['mean']!,
              gyroscopeStd: gyroMap['std']!,
              magnetometerMin: magMap['min']!,
              magnetometerMax: magMap['max']!,
              magnetometerMean: magMap['mean']!,
              magnetometerStd: magMap['std']!,
            ));
          },
        );
  }

  static Stream<Map<String, double>> accelerometerStream(Duration windowSize) {
    double i = 0;
    return accelerometerEvents
        .handleError((error) {
          dev.log(error.toString());
        })
        .map((data) => sqrt(pow(data.x, 2) + pow(data.y, 2) + pow(data.z, 2)))
        .window(windowSize)
        .map((window) {
          final data = {
            "id": ++i,
            "min": window.min,
            "max": window.max,
            "mean": window.average,
            "std": window.standardDeviation,
          };
          // dev.log(data.toString());
          return data;
        });
  }

  static Stream<Map<String, double>> gyroscopeStream(Duration windowSize) {
    double i = 0;
    return gyroscopeEvents
        .handleError((error) {
          dev.log(error.toString());
        })
        .map((data) => sqrt(pow(data.x, 2) + pow(data.y, 2) + pow(data.z, 2)))
        .window(windowSize)
        .map((window) {
          final data = {
            "id": ++i,
            "min": window.min,
            "max": window.max,
            "mean": window.average,
            "std": window.standardDeviation,
          };
          // dev.log(data.toString());
          return data;
        });
  }

  static Stream<Map<String, double>> magnetometerStream(Duration windowSize) {
    double i = 0;
    return magnetometerEvents
        .handleError((error) {
          dev.log(error.toString());
        })
        .map((data) => sqrt(pow(data.x, 2) + pow(data.y, 2) + pow(data.z, 2)))
        .window(windowSize)
        .map((window) {
          final data = {
            "id": ++i,
            "min": window.min,
            "max": window.max,
            "mean": window.average,
            "std": window.standardDeviation,
          };
          // dev.log(data.toString());
          return data;
        });
  }
}
