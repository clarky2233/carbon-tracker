import 'package:carbon_footprint_tracker/models/carbon_tracker/events/position_update_event.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class TrackerContext {
  DateTime startTime;
  Placemark? startPlacemark;
  Position? startPosition;
  Position? latestPosition;
  double distance;

  TrackerContext({
    DateTime? currentActivityStartTime,
    this.distance = 0,
  }) : startTime = currentActivityStartTime ?? DateTime.now();

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
}
