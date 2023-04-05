import '../events/tracker_event.dart';
import '../states/tracker_state.dart';

class Transition {
  TrackerState currentState;
  TrackerEvent event;

  Transition({
    required this.currentState,
    required this.event,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Transition &&
              runtimeType == other.runtimeType &&
              currentState == other.currentState &&
              event == other.event;

  @override
  int get hashCode => currentState.hashCode ^ event.hashCode;
}