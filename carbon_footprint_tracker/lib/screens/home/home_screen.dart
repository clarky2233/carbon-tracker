import 'package:carbon_footprint_tracker/screens/home/widgets/create_activity_bottom_sheet.dart';

import 'package:carbon_footprint_tracker/screens/home/widgets/current_state_card.dart';
import 'package:carbon_footprint_tracker/screens/home/widgets/latest_event_tile.dart';
import 'package:carbon_footprint_tracker/screens/home/widgets/todays_emissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            // isScrollControlled: true,
            useRootNavigator: true,
            builder: (context) {
              return const CreateActivityBottomSheet();
            },
          );
          // final box = store.box<CarbonActivitySchema>();
          //
          // final start = DateTime.now().subtract(const Duration(days: 0));
          //
          // box.put(MovementActivity(
          //   startedAt: start,
          //   endedAt: start.add(const Duration(minutes: 10)),
          //   type: "movement",
          //   distance: 5000,
          //   startLat: 0,
          //   startLong: 0,
          //   endLat: 0,
          //   endLong: 0,
          //   startStreet: '',
          //   startAdministrativeArea: '',
          //   startCountry: '',
          //   startPostcode: '',
          //   startSubLocality: '',
          //   endStreet: '',
          //   endCountry: '',
          //   endAdministrativeArea: '',
          //   endPostcode: '',
          //   endSubLocality: '',
          //   vehicleSize: null,
          //   fuelType: null,
          //   transportMode: TransportMode.walking,
          // ).toDB());
          //
          // box.put(FoodActivity(
          //   date: DateTime.now(),
          //   foodConsumption: FoodConsumption.vegan,
          // ).toDB());
        },
      ),
    );
  }
}
