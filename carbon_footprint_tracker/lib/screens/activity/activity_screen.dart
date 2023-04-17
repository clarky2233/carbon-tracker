import 'dart:developer';

import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/object_box/object_box.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:carbon_footprint_tracker/screens/error/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../ui/widgets/loading_screen.dart';

final activityProvider =
    StreamProvider.autoDispose.family<CarbonActivity?, int>((ref, id) async* {
  yield* store
      .box<CarbonActivitySchema>()
      .query(CarbonActivitySchema_.id.equals(id))
      .watch(triggerImmediately: true)
      .map((query) {
    final activity = query.find().map((e) => e.toActivity());
    if (activity.isEmpty) return null;
    return activity.first;
  });
});

class ActivityScreen extends ConsumerWidget {
  final int id;

  const ActivityScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityStream = ref.watch(activityProvider(id));

    const errorScreen = ErrorScreen(msg: "Unable to load activity");

    return activityStream.when(
      data: (activity) => activity?.buildScreen() ?? errorScreen,
      error: (err, stackTrace) {
        log(err.toString(), stackTrace: stackTrace);
        return errorScreen;
      },
      loading: () => const LoadingScreen(),
    );
  }
}
