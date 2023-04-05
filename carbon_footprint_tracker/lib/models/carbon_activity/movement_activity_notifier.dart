import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/fuel_type.dart';
import 'constants/transport_mode.dart';
import 'constants/vehicle_size.dart';

class MovementActivityNotifier extends StateNotifier<MovementActivity> {
  MovementActivityNotifier()
      : super(
          MovementActivity(
            startedAt: DateTime.now().startOfHour,
            endedAt:
                DateTime.now().startOfHour.add(const Duration(minutes: 30)),
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
          ),
        );

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
}
