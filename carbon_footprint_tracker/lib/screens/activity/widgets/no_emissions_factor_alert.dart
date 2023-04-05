import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:flutter/material.dart';

class NoEmissionFactorAlert extends StatelessWidget {
  final CarbonActivity activity;

  const NoEmissionFactorAlert({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (activity.emissions != null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.errorContainer,
        iconColor: Theme.of(context).colorScheme.onErrorContainer,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        leading: const Icon(Icons.error_outline),
        title: const Text("Emission Calculation Error"),
        subtitle: const Text(
          "There is currently no emissions factor for this configuration of activity. Please double check the activity attributes.",
        ),
      ),
    );
  }
}
