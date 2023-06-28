import 'dart:convert';

import 'package:carbon_footprint_tracker/extensions/map_extensions.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/accelerometer_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/position_update_event.dart';
import 'package:carbon_footprint_tracker/models/event_log/event_log.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sklite/ensemble/forest.dart';
import 'package:sklite/utils/io.dart';

import '../../services/logging/logging_service.dart';
import '../carbon_activity/constants/transport_mode.dart';

class TrackerContext {
  DateTime startTime;
  Placemark? startPlacemark;
  Position? startPosition;
  Position? latestPosition;
  double distance;
  double distanceThreshold;
  String? tmdModelPath;
  RandomForestClassifier? rf;
  Map<TransportMode, int> vehiclePrediction;
  TransportMode? transportMode;

  TrackerContext({
    DateTime? currentActivityStartTime,
    Map<TransportMode, int>? vehiclePrediction,
    this.distance = 0,
    this.distanceThreshold = 50,
    this.tmdModelPath,
    this.transportMode,
    this.rf,
  })  : startTime = currentActivityStartTime ?? DateTime.now(),
        vehiclePrediction = vehiclePrediction ?? {} {
    _loadModel();
  }

  Future<void> _loadModel() async {
    if (tmdModelPath == null) return;
    if (rf != null) return;
    try {
      final modelString = await loadModel(tmdModelPath!);
      rf = RandomForestClassifier.fromMap(json.decode(modelString));
    } catch (error) {
      LoggingService.instance.logEvent(EventLog(
        dateTime: DateTime.now(),
        event: "Unable to load model",
      ));
    }

    LoggingService.instance.logEvent(EventLog(
      dateTime: DateTime.now(),
      event: "Model Loaded!",
    ));

    LoggingService.instance.logEvent(EventLog(
      dateTime: DateTime.now(),
      event: "RF is not null: ${rf != null}",
    ));
    // tmdModel = await PyTorchMobile.loadModel(tmdModelPath!);
  }

  Future<void> setStartPosition() async {
    startPosition = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      startPosition!.latitude,
      startPosition!.longitude,
    ).onError((error, stackTrace) => []);

    latestPosition = startPosition;

    if (placemarks.isNotEmpty) {
      startPlacemark = placemarks.first;
    }
  }

  void updateDistance(PositionUpdateEvent event) {
    if (startPosition == null || latestPosition == null) return;

    Position start = latestPosition!;

    double newDistance = Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      event.position!.latitude,
      event.position!.longitude,
    );

    // if (newDistance < distanceThreshold) return;

    latestPosition = event.position;
    distance += newDistance;

    LoggingService.instance.logEvent(EventLog(
      dateTime: DateTime.now(),
      event:
          "Distance updated: +${newDistance.toInt()}m -> ${distance.toInt()}m",
    ));
  }

  void transportModeDetection(TMDSensorEvent event) {
    if (rf == null) {
      LoggingService.instance.logEvent(EventLog(
        dateTime: DateTime.now(),
        event: "Classifier is null",
      ));
      return;
    }

    final vehicles = [
      TransportMode.bus,
      TransportMode.car,
      TransportMode.train,
    ];

    final prediction = rf!.predict(event.features.input);

    LoggingService.instance.logEvent(EventLog(
      dateTime: DateTime.now(),
      event: "TMD prediction: ${vehicles[prediction].name}",
    ));

    vehiclePrediction.update(
      vehicles[prediction],
      (value) => ++value,
      ifAbsent: () => 1,
    );
  }

  void assignVehicle() {
    transportMode = vehiclePrediction.max();

    LoggingService.instance.logEvent(EventLog(
      dateTime: DateTime.now(),
      event: "Final TMD prediction: ${transportMode?.name}",
    ));
  }
}
