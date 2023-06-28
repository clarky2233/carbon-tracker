import 'package:carbon_footprint_tracker/models/carbon_tracker/states/tracker_state.dart';
import 'package:flutter/material.dart';

import '../../carbon_activity/carbon_activity_schema.dart';
import '../../carbon_activity/constants/transport_mode.dart';

class FlyingState extends TrackerState {
  @override
  final IconData icon = Icons.airplanemode_active;

  @override
  final String name = "flying";

  @override
  TransportMode? get transportMode => TransportMode.flying;

  @override
  bool filter(CarbonActivitySchema carbonActivitySchema) {
    const int minDuration = 30;

    final duration = carbonActivitySchema.endedAt
            ?.difference(carbonActivitySchema.startedAt)
            .inMinutes ??
        0;

    return duration >= minDuration;
  }

  const FlyingState();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerState &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
