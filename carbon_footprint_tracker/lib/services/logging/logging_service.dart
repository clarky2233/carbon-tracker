import 'package:carbon_footprint_tracker/services/logging/logging_service.objectbox.dart';

import '../../models/event_log/event_log.dart';

abstract class LoggingService {
  LoggingService._constructor();

  static final LoggingService _instance = LoggingServiceObjectBox.instance;

  static LoggingService get instance => _instance;

  List<EventLog> getLogs();

  void logEvent(EventLog eventLog);

  void clearLogs();
}
