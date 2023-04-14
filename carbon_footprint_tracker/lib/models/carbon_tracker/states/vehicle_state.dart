import 'package:carbon_footprint_tracker/models/carbon_tracker/states/tracker_state.dart';
import 'package:flutter/material.dart';

import '../../carbon_activity/constants/transport_mode.dart';
import '../tracker_context.dart';

class VehicleState extends TrackerState {
  @override
  final IconData icon = Icons.directions_car;

  @override
  final String name = "vehicle";

  @override
  TransportMode get transportMode => TransportMode.car;

  @override
  bool filter(TrackerContext context) {
    return true;
  }

  const VehicleState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerState &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
