import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../tracking_settings_view_controller.dart';

class LocationPermissionTile extends ConsumerWidget {
  const LocationPermissionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionFuture = ref.watch(locationPermissionStatusProvider);

    final baseTile = ListTile(
      tileColor: Theme.of(context).colorScheme.secondaryContainer,
      leading: const Icon(Icons.location_on),
      title: const Text("Location"),
      trailing: const Switch(value: false, onChanged: null),
    );

    return permissionFuture.when(
      data: (status) {
        final isGranted = status == PermissionStatus.granted;
        return ListTile(
          tileColor: Theme.of(context).colorScheme.secondaryContainer,
          leading: const Icon(Icons.location_on),
          title: const Text("Location"),
          trailing: IgnorePointer(
            child: Switch(value: isGranted, onChanged: (_) {}),
          ),
          onTap: () async {
            final newStatus = await Permission.location.request();

            if (newStatus == PermissionStatus.permanentlyDenied || isGranted) {
              await openAppSettings();
            }
          },
        );
      },
      error: (error, stackTrace) {
        log(error.toString(), stackTrace: stackTrace);
        return baseTile;
      },
      loading: () => baseTile,
    );
  }
}
