import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';

import 'package:flutter/material.dart';

class ActivityTitle extends StatelessWidget {
  final CarbonActivity activity;

  const ActivityTitle({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              activity.title,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              activity.emissions != null
                  ? Text(
                      "${activity.emissions!.toStringAsFixed(2)} kg",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    )
                  : Text(
                      "N/A",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
              Text(
                "CO\u{2082}",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).textTheme.bodySmall!.color),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
