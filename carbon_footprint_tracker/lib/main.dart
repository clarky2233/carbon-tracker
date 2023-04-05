import 'dart:developer';

import 'package:carbon_footprint_tracker/config/theme/system_theme.dart';
import 'package:carbon_footprint_tracker/models/activity_recognition/activity_recognition.dart';
import 'package:carbon_footprint_tracker/models/geo/geo.dart';
import 'package:carbon_footprint_tracker/models/object_box/object_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';
import 'app.dart';
import 'config/theme/theme_controller.dart';
import 'config/theme/theme_service.dart';
import 'package:provider/provider.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    log("Background task: $task STARTING");

    // final container = ProviderContainer();

    // container.listen(activityStreamProvider, (previous, next) {
    //   log("Previous: ${previous?.value?.type.name} (${previous?.value?.confidence.name})\nNext: ${next.value?.type.name} (${next.value?.confidence.name})");
    //   log("--------");
    // });

    await Future.delayed(const Duration(minutes: 1));

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemTheme.setSystemTheme();

  final storePath = await ObjectBox.storePath();
  store = await ObjectBox.getStore(storePath);

  final themeController = ThemeController(ThemeService());
  await themeController.load();

  await ActivityRecognition.requestPermissions();
  await Geo.requestPermission();

  // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  // Workmanager().registerOneOffTask(
  //   "task-identifier",
  //   "simpleTask",
  //   inputData: {'storePath': storePath},
  // );

  runApp(
    ProviderScope(
      child: InheritedProvider<ThemeController>(
        create: (_) => themeController,
        child: MyApp(themeMode: themeController.themeMode),
      ),
    ),
  );
}
