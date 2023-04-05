import 'dart:developer';

import 'package:async/async.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/high_altitude_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/position_update_event.dart';
import 'package:geolocator/geolocator.dart';

import '../carbon_tracker/events/tracker_event.dart';

class Geo {
  static Stream<TrackerEvent> get stream {
    const distanceFilter = 25; // meters
    const minPositionAccuracy = 10; // percent
    const flyingAltitude = 300; // meters
    const flyingSpeed = 55; // meters/second

    LocationSettings locationSettings = const LocationSettings(
      distanceFilter: distanceFilter,
    );

    final Stream<TrackerEvent> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .where((position) => position.accuracy > minPositionAccuracy)
            .map((position) {
      return PositionUpdateEvent(position);
    });

    final Stream<TrackerEvent> altitudeStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .where((position) =>
                position.accuracy > minPositionAccuracy &&
                position.altitude > flyingAltitude &&
                position.speed > flyingSpeed)
            .map((position) {
      return HighAltitudeAndSpeedEvent();
    });

    return StreamGroup.merge<TrackerEvent>([
      positionStream,
      altitudeStream,
    ]);
  }

  static Future<bool> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      log('Geo Permission: Location services are disabled.');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        log('Geo Permission: Location permissions are denied.');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      log('Geo Permission: Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }

    log('Geo Permission: Permission granted.');
    return true;
  }
}
