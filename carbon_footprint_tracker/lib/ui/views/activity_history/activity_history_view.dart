import 'dart:developer';

import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/ui/views/activity_history/controllers/activity_history_view_stream.dart';
import 'package:carbon_footprint_tracker/ui/views/activity_history/widgets/date_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/object_box/object_box.dart';

class ActivityHistoryView extends ConsumerWidget {
  const ActivityHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityStream = ref.watch(activityHistoryProvider);

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
            onRefresh: () async => ref.refresh(activityHistoryProvider),
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
