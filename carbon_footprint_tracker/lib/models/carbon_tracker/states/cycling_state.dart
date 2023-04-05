import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/tracker_state.dart';
import 'package:flutter/material.dart';

import '../tracker_context.dart';

class CyclingState extends TrackerState {
  @override
  final IconData icon = Icons.directions_bike;

  @override
  final String name = "cycling";

  @override
  TransportMode? get transportMode => TransportMode.cycling;

  @override
  bool filter(TrackerContext context) {
    return true;
  }

  const CyclingState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerState &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
