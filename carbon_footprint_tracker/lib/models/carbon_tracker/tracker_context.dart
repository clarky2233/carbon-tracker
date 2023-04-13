import 'dart:convert';

import 'package:carbon_footprint_tracker/models/carbon_tracker/events/accelerometer_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/position_update_event.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pytorch_mobile/model.dart';
import 'package:sklite/ensemble/forest.dart';
import 'package:sklite/utils/io.dart';

import '../carbon_activity/constants/transport_mode.dart';

class TrackerContext {
  DateTime startTime;
  Placemark? startPlacemark;
  Position? startPosition;
  Position? latestPosition;
  double distance;
  String? tmdModelPath;
  Model? tmdModel;
  RandomForestClassifier? rf;
  List<TransportMode> vehicleHistory;

  TrackerContext({
    DateTime? currentActivityStartTime,
    List<TransportMode>? vehicleHistory,
    this.distance = 0,
    this.tmdModelPath,
  })  : startTime = currentActivityStartTime ?? DateTime.now(),
        vehicleHistory = vehicleHistory ?? [] {
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

    distance += newDistance;
  }

  void transportModeDetection(TMDSensorEvent event) async {
    if (rf == null) return;

    final vehicles = [
      TransportMode.car,
      TransportMode.bus,
      TransportMode.train
    ];

    final prediction = rf!.predict(event.features.input);
    print(vehicles[prediction].name);
    vehicleHistory.add(vehicles[prediction]);

    // final prediction =
    //     await tmdModel!.getPrediction(event.features.input, [1, 12], DType.float32);
    // print(prediction);
  }
}
