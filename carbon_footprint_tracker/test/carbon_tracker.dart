import 'dart:async';

import 'package:carbon_footprint_tracker/models/carbon_tracker/carbon_tracker.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/high_altitude_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/in_vehicle_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/tracker_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/events/walking_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/flying_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/idle_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/tracker_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/states/walking_state.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/tracker_context.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:carbon_footprint_tracker/services/activity/activity_service.dart';
import 'package:carbon_footprint_tracker/services/questionnaire/questionnaire_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:statemachine/statemachine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Store store;
  late MethodChannel channel;
  late StreamController<TrackerEvent> eventStreamController;

  void mockGetCurrentPosition() {
    channel = const MethodChannel('flutter.baseflow.com/geolocator');

    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getCurrentPosition') {
        return Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          isMocked: true,
        ).toJson();
      }
    });
  }

  setUpAll(() async {
    store = await openStore(directory: "test/object_box");
    mockGetCurrentPosition();
  });

  setUp(() {
    eventStreamController =
        StreamController<TrackerEvent>.broadcast(sync: true);
  });

  tearDown(() async {
    channel.setMockMethodCallHandler(null);
    eventStreamController.close();
    // store.close();
    // await File("test/object_box/data.mdb").delete();
    // await File("test/object_box/lock.mdb").delete();
  });

  test('State machine initial state', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final carbonTracker = CarbonTracker(
      machine: Machine<TrackerState>(),
      context: TrackerContext(),
      eventStream: const Stream<TrackerEvent>.empty(),
      activityService: ActivityService.instance,
      questionnaireService: QuestionnaireService.instance,
    );

    expect(carbonTracker.machine.current?.identifier, const IdleState());
  });

  test('State machine change state', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final carbonTracker = CarbonTracker(
      machine: Machine<TrackerState>(),
      context: TrackerContext(),
      eventStream: eventStreamController.stream,
      activityService: ActivityService.instance,
      questionnaireService: QuestionnaireService.instance,
    );

    eventStreamController.add(WalkingEvent());

    final currentState = carbonTracker.machine.current?.identifier;

    expect(currentState, const WalkingState());
  });

  test('State machine change state 2', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final carbonTracker = CarbonTracker(
      machine: Machine<TrackerState>(),
      context: TrackerContext(),
      eventStream: eventStreamController.stream,
      activityService: ActivityService.instance,
      questionnaireService: QuestionnaireService.instance,
    );

    eventStreamController.add(InVehicleEvent());
    eventStreamController.add(HighAltitudeAndSpeedEvent());

    final currentState = carbonTracker.machine.current?.identifier;

    expect(currentState, const FlyingState());
  });
}
