import 'package:carbon_footprint_tracker/extensions/string_extensions.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/cycling_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/vehicle_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/flying_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/idle_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/walking_state.dart';
import 'package:flutter/cupertino.dart';

import '../../carbon_activity/constants/transport_mode.dart';
import '../events/tracker_event.dart';
import '../transition_table/transition.dart';
import '../transition_table/transition_result.dart';
import '../transition_table/transition_table.dart';

abstract class TrackerState {
  abstract final String name;
  abstract final IconData icon;
  abstract final TransportMode? transportMode;

  const TrackerState();

  bool filter(CarbonActivitySchema carbonActivitySchema);

  TransitionResult? transition(TrackerEvent event) {
    final transition = Transition(currentState: this, event: event);
    return TransitionTable.table[transition];
  }

  static TrackerState byName(String name) {
    final Map<String, TrackerState> stateMap = {
      const IdleState().name: const IdleState(),
      const WalkingState().name: const WalkingState(),
      const CyclingState().name: const CyclingState(),
      const VehicleState().name: const VehicleState(),
      const FlyingState().name: const FlyingState(),
    };

    if (!stateMap.containsKey(name)) {
      throw Exception("Unknown name for TrackerState: $name");
    }

    return stateMap[name]!;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackerState &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name.capitalize();
  }
}
