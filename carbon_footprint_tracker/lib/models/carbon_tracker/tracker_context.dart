import 'package:carbon_footprint_tracker/models/carbon_tracker/events/accelerometer_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/position_update_event.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../carbon_activity/constants/transport_mode.dart';

class TrackerContext {
  DateTime startTime;
  Placemark? startPlacemark;
  Position? startPosition;
  Position? latestPosition;
  double distance;
  List<TransportMode> vehicleHistory;
  List<double> accelerometerWindow;
  DateTime accelerometerWindowStartTime;
  int accelerometerWindowSize;

  TrackerContext({
    DateTime? currentActivityStartTime,
    List<TransportMode>? vehicleHistory,
    List<double>? accelerometerWindow,
    DateTime? accelerometerWindowStartTime,
    this.distance = 0,
    this.accelerometerWindowSize = 1,
  })  : startTime = currentActivityStartTime ?? DateTime.now(),
        vehicleHistory = vehicleHistory ?? [],
        accelerometerWindow = accelerometerWindow ?? [],
        accelerometerWindowStartTime =
            accelerometerWindowStartTime ?? DateTime.now();

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

  void handleAcc(TMDSensorEvent event) {
    print("*********");
    print(DateTime.now());
    print(event.features);
    print("-----------");
  }
}
