import 'package:carbon_footprint_tracker/services/logging/logging_service.objectbox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/event_log/event_log.dart';

final loggingServiceProvider = Provider<LoggingService>((ref) {
  return LoggingServiceObjectBox();
});

abstract class LoggingService {
  List<EventLog> getLogs();

  void logEvent(EventLog eventLog);
}
