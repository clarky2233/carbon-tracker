import 'package:carbon_footprint_tracker/models/carbon_tracker/events/tracker_event.dart';

import '../../sensors/tmd_features.dart';

class TMDSensorEvent extends TrackerEvent {
  @override
  final String name = "TMD Sensor";

  TMDFeatures features;

  TMDSensorEvent([this.features = const TMDFeatures()]);
}
