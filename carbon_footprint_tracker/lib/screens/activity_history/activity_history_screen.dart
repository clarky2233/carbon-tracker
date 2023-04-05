import 'dart:developer';

import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:carbon_footprint_tracker/screens/activity_history/widgets/date_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/object_box/object_box.dart';

final activitiesProvider = StreamProvider<List<CarbonActivity>>((ref) async* {
  final box = store.box<CarbonActivitySchema>();

  final query = box
      .query()
      .order(CarbonActivitySchema_.startedAt, flags: Order.descending);

  yield* query.watch(triggerImmediately: true).map((query) =>
      query.find().map<CarbonActivity>((e) => e.toActivity()).toList());
});

class ActivityHistoryScreen extends ConsumerWidget {
  const ActivityHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityStream = ref.watch(activitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Activity"),
        actions: [
          IconButton(
            onPressed: () {
              final activityBox = store.box<CarbonActivitySchema>();
              activityBox.removeAll();
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: activityStream.when(
        data: (activities) {
          return RefreshIndicator(
            onRefresh: () async => ref.refresh(activitiesProvider),
            child: ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, i) {
                final activity = activities[i];

                final showDateHeader = i == 0 ||
                    _isDifferentDate(
                      activity.getDate(),
                      activities[i - 1].getDate(),
                    );

                // Date header
                if (showDateHeader) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DateHeader(dateTime: activity.getDate()),
                      activity.buildTile(),
                    ],
                  );
                }

                return activity.buildTile();
              },
            ),
          );
        },
        error: (err, stackTrace) {
          log(err.toString(), stackTrace: stackTrace);
          return Center(child: Text(err.toString()));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  bool _isDifferentDate(DateTime date, DateTime other) {
    return date.year != other.year ||
        date.month != other.month ||
        date.day != other.day;
  }
}
