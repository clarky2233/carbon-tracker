import 'package:carbon_footprint_tracker/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/carbon_tracker/providers/state_machine_providers.dart';

class CurrentStateCard extends ConsumerWidget {
  const CurrentStateCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currentState = ref.watch(currentStateProvider);
    final currentState = ref.watch(carbonTrackerProvider
        .select((value) => value.machine.current?.identifier));

    if (currentState == null) return const SizedBox();

    return ListTile(
      tileColor: Theme.of(context).colorScheme.tertiaryContainer,
      iconColor: Theme.of(context).colorScheme.onTertiaryContainer,
      leading: Icon(currentState.icon),
      title: const Text("Current State"),
      subtitle: Text(currentState.name.capitalize()),
    );
  }
}
