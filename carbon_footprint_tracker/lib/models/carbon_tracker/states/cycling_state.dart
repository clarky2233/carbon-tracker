import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/tracker_state.dart';
import 'package:flutter/material.dart';

import '../../carbon_activity/carbon_activity_schema.dart';

class CyclingState extends TrackerState {
  @override
  final IconData icon = Icons.directions_bike;

  @override
  final String name = "cycling";

  @override
  TransportMode? get transportMode => TransportMode.cycling;

  @override
  bool filter(CarbonActivitySchema carbonActivitySchema) {
    const int minDuration = 5;

    final duration = carbonActivitySchema.endedAt
        ?.difference(carbonActivitySchema.startedAt)
        .inMinutes ??
        0;

    return duration >= minDuration;
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
