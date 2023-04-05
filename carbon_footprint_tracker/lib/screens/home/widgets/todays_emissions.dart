import 'dart:developer';
import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/carbon_activity/carbon_activity_schema.dart';
import '../../../models/object_box/object_box.dart';

final todaysEmissionsProvider = StreamProvider<double>((ref) async* {
  final box = store.box<CarbonActivitySchema>();

  final query = box.query(
    CarbonActivitySchema_.startedAt.between(
        DateTime.now().startOfDay.millisecondsSinceEpoch,
        DateTime.now().endOfDay.millisecondsSinceEpoch),
  );

  yield* query.watch(triggerImmediately: true).map((query) => query
      .find()
      .map<CarbonActivity>((dbObject) => dbObject.toActivity())
      .fold<double>(0, (sum, activity) => sum += activity.emissions ?? 0));
});

class TodaysEmissions extends ConsumerWidget {
  const TodaysEmissions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emissionsStream = ref.watch(todaysEmissionsProvider);

    return emissionsStream.when(
      data: (total) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Today",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 10,
              shadowColor: Colors.transparent,
              color: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(75),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.width * 0.60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${total.toStringAsFixed(2)} kg",
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "CO\u{2082}e",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        log(error.toString(), stackTrace: stackTrace);
        return const Text("N/A");
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
