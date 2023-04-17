import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../tracking_settings_view_controller.dart';

class ActivityPermissionTile extends ConsumerWidget {
  const ActivityPermissionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionFuture = ref.watch(activityPermissionStatusProvider);

    final baseTile = ListTile(
      tileColor: Theme.of(context).colorScheme.secondaryContainer,
      leading: const Icon(Icons.directions_run),
      title: const Text("Activity Detection"),
      trailing: const Switch(value: false, onChanged: null),
    );

    return permissionFuture.when(
      data: (status) {
        final isGranted = status == PermissionStatus.granted;
        return ListTile(
          tileColor: Theme.of(context).colorScheme.secondaryContainer,
          leading: const Icon(Icons.directions_run),
          title: const Text("Activity Detection"),
          trailing: IgnorePointer(
            child: Switch(value: isGranted, onChanged: (_) {}),
          ),
          onTap: () async {
            final newStatus = await Permission.activityRecognition.request();

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
