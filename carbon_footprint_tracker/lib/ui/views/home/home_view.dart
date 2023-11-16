import 'package:carbon_footprint_tracker/ui/views/home/widgets/chart_time_selector.dart';
import 'package:carbon_footprint_tracker/ui/views/home/widgets/create_activity_bottom_sheet.dart';

import 'package:carbon_footprint_tracker/ui/views/home/widgets/emissions_chart.dart';
import 'package:carbon_footprint_tracker/ui/views/home/widgets/todays_emissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                TodaysEmissions(),
                EmissionsChart(),
                ChartTimeSelector(),
              ],
            ),
          ),
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
