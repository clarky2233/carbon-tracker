import 'package:carbon_footprint_tracker/models/carbon_tracker/events/accelerometer_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/high_altitude_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/on_bicycle_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/position_update_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/running_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/still_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/cycling_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/vehicle_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/flying_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/idle_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/walking_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/transition_table/transition.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/transition_table/transition_result.dart';
import '../events/in_vehicle_event.dart';
import '../events/walking_event.dart';


class TransitionTable {
  static final Map<Transition, TransitionResult> table = {
    // Idle
    Transition(currentState: const IdleState(),     event: WalkingEvent()):                 TransitionResult(nextState: const WalkingState(), autoCreateActivity: false),
    Transition(currentState: const IdleState(),     event: RunningEvent()):                 TransitionResult(nextState: const WalkingState(), autoCreateActivity: false),
    Transition(currentState: const IdleState(),     event: OnBicycleEvent()):               TransitionResult(nextState: const CyclingState(), autoCreateActivity: false),
    Transition(currentState: const IdleState(),     event: InVehicleEvent()):               TransitionResult(nextState: const VehicleState(), autoCreateActivity: false),
    // Transition(currentState: const IdleState(),     event: TMDSensorEvent()):               TransitionResult(nextState: const IdleState(), action: (context, event) => context.transportModeDetection(event as TMDSensorEvent), resetContext: false, autoCreateActivity: false),
    // Walking
    Transition(currentState: const WalkingState(),  event: StillEvent()):                   TransitionResult(nextState: const IdleState(), action: (context, _) => context.assignVehicle()),
    Transition(currentState: const WalkingState(),  event: RunningEvent()):                 TransitionResult(nextState: const WalkingState(), resetContext: false),
    Transition(currentState: const WalkingState(),  event: OnBicycleEvent()):               TransitionResult(nextState: const CyclingState()),
    Transition(currentState: const WalkingState(),  event: InVehicleEvent()):               TransitionResult(nextState: const VehicleState()),
    Transition(currentState: const WalkingState(),  event: PositionUpdateEvent()):          TransitionResult(nextState: const WalkingState(), action: (context, event) => context.updateDistance(event as PositionUpdateEvent), resetContext: false, autoCreateActivity: false),
    // Transition(currentState: const WalkingState(),  event: TMDSensorEvent()):               TransitionResult(nextState: const WalkingState(), action: (context, event) => context.transportModeDetection(event as TMDSensorEvent), resetContext: false, autoCreateActivity: false),
    // Cycling
    Transition(currentState: const CyclingState(),  event: StillEvent()):                   TransitionResult(nextState: const IdleState()),
    Transition(currentState: const CyclingState(),  event: WalkingEvent()):                 TransitionResult(nextState: const WalkingState()),
    Transition(currentState: const CyclingState(),  event: RunningEvent()):                 TransitionResult(nextState: const WalkingState()),
    Transition(currentState: const CyclingState(),  event: InVehicleEvent()):               TransitionResult(nextState: const VehicleState()),
    Transition(currentState: const CyclingState(),  event: PositionUpdateEvent()):          TransitionResult(nextState: const CyclingState(), action: (context, event) => context.updateDistance(event as PositionUpdateEvent), resetContext: false, autoCreateActivity: false),
    // Vehicle
    Transition(currentState: const VehicleState(),  event: StillEvent()):                   TransitionResult(nextState: const IdleState(),    action: (context, _) => context.assignVehicle()),
    Transition(currentState: const VehicleState(),  event: WalkingEvent()):                 TransitionResult(nextState: const WalkingState(), action: (context, _) => context.assignVehicle()),
    Transition(currentState: const VehicleState(),  event: RunningEvent()):                 TransitionResult(nextState: const WalkingState(), action: (context, _) => context.assignVehicle()),
    Transition(currentState: const VehicleState(),  event: OnBicycleEvent()):               TransitionResult(nextState: const CyclingState(), action: (context, _) => context.assignVehicle()),
    Transition(currentState: const VehicleState(),  event: HighAltitudeAndSpeedEvent()):    TransitionResult(nextState: const FlyingState(),  resetContext: false, autoCreateActivity: false),
    Transition(currentState: const VehicleState(),  event: PositionUpdateEvent()):          TransitionResult(nextState: const VehicleState(), action: (context, event) => context.updateDistance(event as PositionUpdateEvent), resetContext: false, autoCreateActivity: false),
    Transition(currentState: const VehicleState(),  event: TMDSensorEvent()):               TransitionResult(nextState: const VehicleState(), action: (context, event) => context.transportModeDetection(event as TMDSensorEvent), resetContext: false, autoCreateActivity: false),
    // Flying
    Transition(currentState: const FlyingState(),  event: StillEvent()):                    TransitionResult(nextState: const IdleState()),
    Transition(currentState: const FlyingState(),  event: WalkingEvent()):                  TransitionResult(nextState: const WalkingState()),
    Transition(currentState: const FlyingState(),  event: RunningEvent()):                  TransitionResult(nextState: const WalkingState()),
    Transition(currentState: const FlyingState(),  event: OnBicycleEvent()):                TransitionResult(nextState: const CyclingState()),
    Transition(currentState: const FlyingState(),  event: PositionUpdateEvent()):           TransitionResult(nextState: const FlyingState(),  action: (context, event) => context.updateDistance(event as PositionUpdateEvent), resetContext: false, autoCreateActivity: false),
  };
}

