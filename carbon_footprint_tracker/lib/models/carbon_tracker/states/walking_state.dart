import 'package:carbon_footprint_tracker/models/carbon_tracker/states/tracker_state.dart';
import 'package:flutter/material.dart';

import '../../carbon_activity/constants/transport_mode.dart';
import '../tracker_context.dart';

class WalkingState extends TrackerState {
  @override
  final IconData icon = Icons.directions_walk;

  @override
  final String name = "walking";

  @override
  TransportMode? get transportMode => TransportMode.walking;

  @override
  bool filter(TrackerContext context) {
    const int minWalkDuration = 0;

    final walkDuration = DateTime.now().difference(context.startTime).inMinutes;

    return walkDuration >= minWalkDuration;
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
