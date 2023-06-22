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
    final box = store.box<EventLog>();

    final query =
        box.query().order(EventLog_.dateTime, flags: Order.descending);

    return query.build().find();
  }

  @override
  void logEvent(EventLog eventLog) {
    final box = store.box<EventLog>();
    box.put(eventLog);
  }

  @override
  void clearLogs() {
    final box = store.box<EventLog>();
    box.removeAll();
  }
}
