import 'package:carbon_footprint_tracker/ui/views/transport_input/widgets/date_and_time_selection.dart';
import 'package:carbon_footprint_tracker/ui/views/transport_input/widgets/details_input.dart';
import 'package:carbon_footprint_tracker/ui/views/transport_input/widgets/transport_input_save_button.dart';
import 'package:carbon_footprint_tracker/ui/views/transport_input/widgets/transport_mode_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransportInputScreen extends ConsumerWidget {
  const TransportInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            const SliverAppBar(
              pinned: true,
              title: Text("Trip Entry"),
              actions: [
                TransportInputSaveButton(),
                SizedBox(width: 16),
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
