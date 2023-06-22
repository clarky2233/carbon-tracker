import 'package:carbon_footprint_tracker/models/event_log/event_log.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:carbon_footprint_tracker/services/logging/logging_service.dart';

class LoggingServiceObjectBox implements LoggingService {
  final Store store;

  const LoggingServiceObjectBox({
    required this.store,
  });

  @override
  List<EventLog> getLogs() {
    // TODO: implement getLogs
    throw UnimplementedError();
  }

  @override
  void logEvent(EventLog eventLog) {
    final box = store.box<EventLog>();
    box.put(eventLog);
  }
}
