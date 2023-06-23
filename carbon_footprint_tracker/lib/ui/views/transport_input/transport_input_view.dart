import 'package:carbon_footprint_tracker/ui/views/transport_input/widgets/date_and_time_selection.dart';
import 'package:carbon_footprint_tracker/ui/views/transport_input/widgets/details_input.dart';
import 'package:carbon_footprint_tracker/ui/views/transport_input/widgets/location_input.dart';
import 'package:carbon_footprint_tracker/ui/views/transport_input/widgets/transport_input_save_button.dart';
import 'package:carbon_footprint_tracker/ui/views/transport_input/widgets/transport_mode_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransportInputView extends ConsumerStatefulWidget {
  const TransportInputView({Key? key}) : super(key: key);

  @override
  ConsumerState<TransportInputView> createState() => _TransportInputViewState();
}

class _TransportInputViewState extends ConsumerState<TransportInputView> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverAppBar(
              pinned: true,
              title: const Text("Trip Entry"),
              actions: [
                TransportInputSaveButton(formKey: formKey),
                const SizedBox(width: 16),
              ],
            ),
          ];
        },
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.only(top: 16),
            children: const [
              TransportModeSelection(),
              Divider(height: 32, indent: 16, endIndent: 16),
              DateAndTimeSelection(),
              Divider(height: 32, indent: 16, endIndent: 16),
              LocationInput(),
              Divider(height: 32, indent: 16, endIndent: 16),
              DetailsInput(),
            ],
          ),
        ),
      ),
    );
  }
}
