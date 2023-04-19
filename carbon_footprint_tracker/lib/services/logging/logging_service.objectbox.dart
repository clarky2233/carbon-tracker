import 'package:carbon_footprint_tracker/models/event_log/event_log.dart';
import 'package:carbon_footprint_tracker/services/logging/logging_service.dart';

import '../../models/object_box/object_box.dart';

class LoggingServiceObjectBox implements LoggingService {
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