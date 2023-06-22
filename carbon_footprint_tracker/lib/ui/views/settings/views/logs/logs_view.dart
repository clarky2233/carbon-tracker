import 'package:carbon_footprint_tracker/services/logging/logging_service.dart';
import 'package:carbon_footprint_tracker/ui/views/settings/views/logs/controllers/logs_future_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statistics/statistics.dart';

class LogsView extends ConsumerWidget {
  const LogsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(logsProvider);
    final logger = ref.watch(loggingServiceProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Logs"),
        actions: [
          IconButton(
            onPressed: () {
              logger.clearLogs();
              ref.invalidate(logsProvider);
            },
            icon: const Icon(Icons.delete_forever_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(logs[i].event),
            subtitle: Text(logs[i].dateTime.formatToYMDHms()),
          );
        },
      ),
    );
  }
}
