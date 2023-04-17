import 'package:carbon_footprint_tracker/ui/views/home/widgets/create_activity_bottom_sheet.dart';

import 'package:carbon_footprint_tracker/ui/views/home/widgets/current_state_card.dart';
import 'package:carbon_footprint_tracker/ui/views/home/widgets/latest_event_tile.dart';
import 'package:carbon_footprint_tracker/ui/views/home/widgets/todays_emissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            TodaysEmissions(),
            SizedBox(height: 10),
            LatestEventTile(),
            SizedBox(height: 10),
            CurrentStateCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (context) {
              return const CreateActivityBottomSheet();
            },
          );
        },
      ),
    );
  }
}
