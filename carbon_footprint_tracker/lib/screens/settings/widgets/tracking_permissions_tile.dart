import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routing/named_route.dart';

class TrackingPermissionsTile extends StatelessWidget {
  const TrackingPermissionsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.my_location_outlined),
      title: const Text("Tracking"),
      subtitle: const Text("Location, Activity, Sensors"),
      onTap: () {
        context.pushNamed(NamedRoute.trackingSettings.name);
      },
    );
  }
}
