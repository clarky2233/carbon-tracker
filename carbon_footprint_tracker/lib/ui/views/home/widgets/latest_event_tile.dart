import 'dart:developer';

import 'package:carbon_footprint_tracker/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../models/carbon_tracker/providers/state_machine_providers.dart';

class LatestEventTile extends ConsumerWidget {
  const LatestEventTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventStream = ref.watch(eventsProvider);

    return ListTile(
      tileColor: Theme.of(context).colorScheme.tertiaryContainer,
      iconColor: Theme.of(context).colorScheme.onTertiaryContainer,
      leading: const Icon(Icons.input),
      title: const Text("Latest Event"),
      subtitle: eventStream.when(
        data: (event) {
          return Text(
            "${event.name.capitalize()} - ${DateFormat.jms().format(event.receivedAt)}",
          );
        },
        error: (err, stackTrace) {
          log(err.toString(), stackTrace: stackTrace);
          return const Text("Something went wrong!");
        },
        loading: () => const Text("Waiting for event..."),
      ),
    );
  }
}
