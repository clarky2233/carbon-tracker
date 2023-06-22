import 'package:carbon_footprint_tracker/models/event_log/event_log.dart';
import 'package:carbon_footprint_tracker/services/logging/logging_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logsProvider = StateProvider.autoDispose<List<EventLog>>((ref) {
  return ref.watch(loggingServiceProvider).getLogs();
});
