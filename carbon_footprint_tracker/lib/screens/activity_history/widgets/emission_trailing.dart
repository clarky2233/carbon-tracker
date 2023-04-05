import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:flutter/material.dart';

class EmissionTrailing extends StatelessWidget {
  final CarbonActivity activity;

  const EmissionTrailing({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        activity.emissions != null ?
        Text(
          "${activity.emissions!.toStringAsFixed(1)} kg",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ): Text(
          "N/A",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        Text(
          "CO\u{2082}e",
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Theme.of(context).textTheme.bodySmall!.color),
        ),
      ],
    );
  }
}
