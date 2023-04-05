import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/vehicle_state.dart';
import 'package:carbon_footprint_tracker/models/event_log/event_log.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/cycling_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/flying_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/idle_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/tracker_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/walking_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/tracker_context.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:statemachine/statemachine.dart';
import 'events/tracker_event.dart';

class CarbonTracker {
  Machine<TrackerState> machine;
  TrackerContext context;
  Stream<TrackerEvent> eventStream;
  Store store;
  List<TrackerState> states;
  late Box<CarbonActivitySchema> activityBox;
  late Box<EventLog> eventBox;

  // Ref ref;
  // T Function<T>(ProviderListenable<T>) read;

  static const List<TrackerState> _defaultStates = [
    IdleState(),
    WalkingState(),
    CyclingState(),
    VehicleState(),
    FlyingState(),
  ];

  final Map<TrackerState, State<TrackerState>> _registeredStates = {};

  CarbonTracker({
    required this.machine,
    required this.context,
    required this.eventStream,
    required this.store,
    this.states = _defaultStates,
  }) {
    activityBox = store.box<CarbonActivitySchema>();
    eventBox = store.box<EventLog>();

    // Initialize states in state machine
    for (TrackerState state in states) {
      State<TrackerState> newState = machine.newState(state);
      _registeredStates[state] = newState;
    }

    for (State<TrackerState> state in _registeredStates.values) {
      // Define transitions between states
      state.onStream(eventStream, (event) async {
        // _logEvent(event);
        await _transition(state, event);
      });

      // Define on entry into states
      state.onEntry(() => _onEntry());

      // Define on exit from states
      state.onExit(() async => await _onExit(state));
    }

    machine.start();
  }

  Future<void> _transition(
      State<TrackerState> state, TrackerEvent event) async {
    final transitionResult = state.identifier.transition(event);

    if (transitionResult == null) return;

    // Perform action
    if (transitionResult.action != null) {
      await transitionResult.action!(context, event);
    }

    // Create Activity
    if (transitionResult.autoCreateActivity &&
        state.identifier.filter(context)) {
      await createActivity(state.identifier);
    }

    // Reset Context
    if (transitionResult.resetContext) {
      context = TrackerContext();
    }

    // Change State
    if (transitionResult.nextState != state.identifier) {
      _registeredStates[transitionResult.nextState]?.enter();
    }
  }

  void _logEvent(TrackerEvent event) {
    eventBox.put(EventLog(event: event.name, dateTime: DateTime.now()));
  }

  Future<void> createActivity(TrackerState state) async {
    if (machine.current == null) return;

    // Get final location
    final endPosition = await Geolocator.getCurrentPosition();
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      endPosition.latitude,
      endPosition.longitude,
    ).onError((error, stackTrace) => []);

    Placemark? endPlacemark;
    if (placeMarks.isNotEmpty) endPlacemark = placeMarks.first;

    final activity = CarbonActivitySchema(
      // type: machine.current!.identifier.name,
      type: MovementActivity.type,
      startedAt: context.startTime,
      endedAt: DateTime.now(),
      startLat: context.startPosition!.latitude,
      startLong: context.startPosition!.longitude,
      startStreet: context.startPlacemark?.street,
      startAdministrativeArea: context.startPlacemark?.administrativeArea,
      startCountry: context.startPlacemark?.country,
      startPostcode: context.startPlacemark?.postalCode,
      startSubLocality: context.startPlacemark?.subLocality,
      endLat: endPosition.latitude,
      endLong: endPosition.longitude,
      endStreet: endPlacemark?.street,
      endAdministrativeArea: endPlacemark?.administrativeArea,
      endCountry: endPlacemark?.country,
      endPostcode: endPlacemark?.postalCode,
      endSubLocality: endPlacemark?.subLocality,
      distance: context.distance,
      transportMode: state.transportMode,
    );

    // Combine Activity
    if (_combineActivity(activity)) return;

    // Save activity to database
    activityBox.put(activity);
  }

  bool _combineActivity(CarbonActivitySchema activity) {
    final query = activityBox
        .query(CarbonActivitySchema_.type.equals(MovementActivity.type))
        .order(CarbonActivitySchema_.endedAt, flags: Order.descending)
        .build()
      ..limit = 1;

    List<CarbonActivitySchema> lastActivityList = query.find();

    // No last activity
    if (lastActivityList.isEmpty) return false;

    CarbonActivitySchema lastActivity = lastActivityList.last;

    // Last activity is a different type
    if (activity.type != lastActivity.type) return false;

    final timeDifference =
        activity.startedAt.difference(lastActivity.endedAt!).inMinutes;

    // Calculate distance between last activity
    double distanceBetween = Geolocator.distanceBetween(
      lastActivity.endLat!,
      lastActivity.endLong!,
      activity.startLat!,
      activity.startLong!,
    );

    /*
    Rules for combining activities.
    Combine if:
      - distance between activities is less than 50m
      and
      - time difference is less than 60 minutes
    */

    if (distanceBetween > 50 || timeDifference > 60) return false;

    // Combine the activities
    lastActivity
      ..endedAt = activity.endedAt
      ..distance += activity.distance
      ..endStreet = activity.endStreet
      ..endAdministrativeArea = activity.endAdministrativeArea
      ..endCountry = activity.endCountry
      ..endPostcode = activity.endPostcode
      ..endSubLocality = activity.endSubLocality;

    activityBox.put(lastActivity, mode: PutMode.update);

    return true;
  }

  void _onEntry() {}

  Future<void> _onExit(State<TrackerState> state) async {
    if (context.startPlacemark == null) {
      await context.setStartPosition();
    }
  }
}
