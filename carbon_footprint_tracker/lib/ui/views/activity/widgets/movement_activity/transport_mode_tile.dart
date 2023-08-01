import 'package:carbon_footprint_tracker/extensions/string_extensions.dart';
import 'package:carbon_footprint_tracker/ui/views/activity/widgets/movement_activity/update_transport_mode_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/carbon_activity/movement_activity.dart';

class TransportModeTile extends ConsumerWidget {
  final MovementActivity activity;

  const TransportModeTile({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      // leading: const Icon(Icons.commute_outlined),
      title: Text("Transport mode: ${activity.transportMode.name.capitalize()}"),
      // subtitle: const Text("Transport Mode"),
      trailing: IgnorePointer(
        child: IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () {},
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return UpdateTransportModeBottomSheet(activity: activity);
          },
        );
      },
    );
  }
}
