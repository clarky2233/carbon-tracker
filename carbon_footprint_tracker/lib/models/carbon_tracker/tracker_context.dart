import 'dart:convert';

import 'package:carbon_footprint_tracker/extensions/map_extensions.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/accelerometer_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/position_update_event.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sklite/ensemble/forest.dart';
import 'package:sklite/utils/io.dart';

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
  late TransportMode transportMode;

  TrackerContext({
    DateTime? currentActivityStartTime,
    Map<TransportMode, int>? vehiclePrediction,
    this.distance = 0,
    this.distanceThreshold = 50,
    this.tmdModelPath,
  })  : startTime = currentActivityStartTime ?? DateTime.now(),
        vehiclePrediction = vehiclePrediction ?? {} {
    _loadModel();
  }

  Future<void> _loadModel() async {
    if (tmdModelPath == null) return;
    await loadModel(tmdModelPath!).then((x) {
      rf = RandomForestClassifier.fromMap(json.decode(x));
    });
    // tmdModel = await PyTorchMobile.loadModel(tmdModelPath!);
  }

  Future<void> setStartPosition() async {
    startPosition = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      startPosition!.latitude,
      startPosition!.longitude,
    ).onError((error, stackTrace) => []);

    if (placemarks.isNotEmpty) {
      startPlacemark = placemarks.first;
    }
  }

  void updateDistance(PositionUpdateEvent event) {
    if (startPosition == null) return;

    Position start = latestPosition == null ? startPosition! : latestPosition!;

    double newDistance = Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      event.position!.latitude,
      event.position!.longitude,
    );

    if (newDistance < distanceThreshold) return;

    latestPosition = event.position;
    distance += newDistance;
  }

  void transportModeDetection(TMDSensorEvent event) {
    if (rf == null) return;

    final vehicles = [
      TransportMode.bus,
      TransportMode.car,
      TransportMode.train,
    ];

    final prediction = rf!.predict(event.features.input);

    vehiclePrediction.update(
      vehicles[prediction],
      (value) => ++value,
      ifAbsent: () => 1,
    );
  }

  void assignVehicle() {
    transportMode = vehiclePrediction.max() ?? TransportMode.car;
  }
}
