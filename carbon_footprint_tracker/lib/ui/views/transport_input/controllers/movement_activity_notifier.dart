import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../models/carbon_activity/constants/fuel_type.dart';
import '../../../../models/carbon_activity/constants/transport_mode.dart';
import '../../../../models/carbon_activity/constants/vehicle_size.dart';

class MovementActivityNotifier extends AutoDisposeNotifier<MovementActivity> {
  late ActivityService activityService;

  @override
  MovementActivity build() {
    activityService = ref.watch(activityServiceProvider);

    return MovementActivity(
      startedAt: DateTime.now().startOfHour,
      endedAt: DateTime.now().startOfHour.add(const Duration(minutes: 30)),
      distance: 0,
      startLat: 0,
      startLong: 0,
      endLat: 0,
      endLong: 0,
      startStreet: null,
      startAdministrativeArea: null,
      startCountry: null,
      startPostcode: null,
      startSubLocality: null,
      endStreet: null,
      endAdministrativeArea: null,
      endCountry: null,
      endPostcode: null,
      endSubLocality: null,
      vehicleSize: VehicleSize.medium,
      fuelType: FuelType.petroleum,
      transportMode: TransportMode.car,
    );
  }

  void setTransportMode(TransportMode mode) {
    state = state.copyWith(
      transportMode: mode,
      fuelType: mode.defaultFuelType,
      vehicleSize: mode.defaultVehicleSize,
    );
  }

  void setDate(DateTime dateTime) {
    final startDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      state.startedAt.hour,
      state.startedAt.minute,
    );
    final endDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      state.endedAt.hour,
      state.endedAt.minute,
    );

    state = state.copyWith(startedAt: startDate, endedAt: endDate);
  }

  void setStartTime(TimeOfDay timeOfDay) {
    final startDate = DateTime(
      state.startedAt.year,
      state.startedAt.month,
      state.startedAt.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    state = state.copyWith(startedAt: startDate);
  }

  void setEndTime(TimeOfDay timeOfDay) {
    DateTime endDate = DateTime(
      state.endedAt.year,
      state.endedAt.month,
      state.endedAt.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    if (endDate.isBefore(state.startedAt)) {
      endDate = endDate.addDays(1);
    }

    state = state.copyWith(endedAt: endDate);
  }

  void setVehicleSize(VehicleSize size) {
    state = state.copyWith(vehicleSize: size);
  }

  void setFuelType(FuelType fuelType) {
    state = state.copyWith(fuelType: fuelType);
  }

  void setStartStreet(String startLocation) {
    state = state.copyWith(startStreet: startLocation);
  }

  void setEndStreet(String destination) {
    state = state.copyWith(endStreet: destination);
  }

  Future<bool> setStartPosition() async {
    List<Location> startLocations =
        await locationFromAddress(state.startStreet!);
    if (startLocations.isEmpty) return false;
    state
      ..startLat = startLocations.first.latitude
      ..startLong = startLocations.first.longitude;

    List<Placemark> startPlacemarks = await placemarkFromCoordinates(
      state.startLat,
      state.startLong,
    ).onError((error, stackTrace) => []);

    Placemark? startPlacemark;
    if (startPlacemarks.isNotEmpty) startPlacemark = startPlacemarks.first;
    state
      ..startStreet = startPlacemark?.street
      ..startAdministrativeArea = startPlacemark?.administrativeArea
      ..startCountry = startPlacemark?.country
      ..startPostcode = startPlacemark?.postalCode
      ..startSubLocality = startPlacemark?.subLocality;

    return true;
  }

  Future<bool> setEndPosition() async {
    List<Location> destinations = await locationFromAddress(state.endStreet!);
    if (destinations.isEmpty) return false;
    state
      ..endLat = destinations.first.latitude
      ..endLong = destinations.first.longitude;

    List<Placemark> endPlacemarks = await placemarkFromCoordinates(
      state.endLat,
      state.endLong,
    ).onError((error, stackTrace) => []);

    Placemark? endPlacemark;
    if (endPlacemarks.isNotEmpty) endPlacemark = endPlacemarks.first;
    state
      ..endStreet = endPlacemark?.street
      ..endAdministrativeArea = endPlacemark?.administrativeArea
      ..endCountry = endPlacemark?.country
      ..endPostcode = endPlacemark?.postalCode
      ..endSubLocality = endPlacemark?.subLocality;

    state.distance = Geolocator.distanceBetween(
      state.startLat,
      state.startLong,
      state.endLat,
      state.endLong,
    );

    return true;
  }

  Future<bool> saveActivity() async {
    bool check = false;

    check = await setStartPosition();
    if (!check) return check;

    check = await setEndPosition();
    if (!check) return check;

    activityService.saveActivity(state);

    return true;
  }
}

final newTripProvider =
    NotifierProvider.autoDispose<MovementActivityNotifier, MovementActivity>(
        MovementActivityNotifier.new);
