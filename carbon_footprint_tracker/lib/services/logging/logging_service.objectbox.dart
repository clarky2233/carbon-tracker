import 'dart:developer';

import 'package:carbon_footprint_tracker/models/event_log/event_log.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:carbon_footprint_tracker/services/logging/logging_service.dart';

import '../../models/object_box/object_box.dart';

class LoggingServiceObjectBox implements LoggingService {
  LoggingServiceObjectBox._constructor();

  static final LoggingServiceObjectBox _instance =
      LoggingServiceObjectBox._constructor();

  static LoggingServiceObjectBox get instance => _instance;

  @override
  List<EventLog> getLogs() {
    final box = store.box<EventLog>();

    final query =
        box.query().order(EventLog_.dateTime, flags: Order.descending);

    return query.build().find();
  }

  @override
  void logEvent(EventLog eventLog) {
    log(eventLog.event);
    final box = store.box<EventLog>();
    box.put(eventLog);
  }

  @override
  void clearLogs() {
    final box = store.box<EventLog>();
    box.removeAll();
  }
}
