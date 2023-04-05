import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/movement_activity_notifier.dart';
import 'package:carbon_footprint_tracker/screens/transport_input/widgets/date_and_time_selection.dart';
import 'package:carbon_footprint_tracker/screens/transport_input/widgets/details_input.dart';
import 'package:carbon_footprint_tracker/screens/transport_input/widgets/transport_mode_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/carbon_activity/carbon_activity_schema.dart';
import '../../models/object_box/object_box.dart';

final newTripProvider = StateNotifierProvider.autoDispose<
    MovementActivityNotifier, MovementActivity>((ref) {
  return MovementActivityNotifier();
});

class TransportInputScreen extends ConsumerWidget {
  const TransportInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newTrip = ref.watch(newTripProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              pinned: true,
              title: const Text("Trip Entry"),
              actions: [
                FilledButton.icon(
                  onPressed: () {
                    newTrip.estimateDistance();

                    final box = store.box<CarbonActivitySchema>();

                    box.put(newTrip.toDB());

                    context.pop();
                  },
                  icon: const Icon(Icons.done),
                  label: const Text("Save"),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.only(top: 16),
          children: const [
            TransportModeSelection(),
            Divider(height: 32, indent: 16, endIndent: 16),
            DateAndTimeSelection(),
            Divider(height: 32, indent: 16, endIndent: 16),
            DetailsInput(),
          ],
        ),
      ),
    );
  }
}
