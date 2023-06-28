import 'package:carbon_footprint_tracker/models/carbon_tracker/states/tracker_state.dart';
import 'package:flutter/material.dart';

import '../../carbon_activity/carbon_activity_schema.dart';
import '../../carbon_activity/constants/transport_mode.dart';

class WalkingState extends TrackerState {
  @override
  final IconData icon = Icons.directions_walk;

  @override
  final String name = "walking";

  @override
  TransportMode? get transportMode => TransportMode.walking;

  @override
  bool filter(CarbonActivitySchema carbonActivitySchema) {
    const int minDuration = 5;
    const int minDistance = 50;

    final duration = carbonActivitySchema.endedAt
            ?.difference(carbonActivitySchema.startedAt)
            .inMinutes ??
        0;

    final distance = carbonActivitySchema.distance;

    return duration >= minDuration && distance >= minDistance;
  }

  const WalkingState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerState &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
