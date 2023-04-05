import 'package:carbon_footprint_tracker/models/carbon_tracker/events/tracker_event.dart';
import 'package:carbon_footprint_tracker/models/carbon_tracker/tracker_context.dart';
import '../states/tracker_state.dart';

class TransitionResult {
  TrackerState nextState;
  bool resetContext;
  bool autoCreateActivity;
  Function(TrackerContext context, TrackerEvent event)? action;

  TransitionResult({
    required this.nextState,
    this.resetContext = true,
    this.autoCreateActivity = true,
    this.action,
  });
}
