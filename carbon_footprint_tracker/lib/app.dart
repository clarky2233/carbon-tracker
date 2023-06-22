import 'package:carbon_footprint_tracker/models/food_prediction/food_prediction.dart';
import 'package:carbon_footprint_tracker/models/object_box/object_box.dart';
import 'package:carbon_footprint_tracker/ui/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/router.dart';
import 'models/carbon_tracker/providers/state_machine_providers.dart';

class MyApp extends ConsumerStatefulWidget {
  final ThemeMode themeMode;

  const MyApp({
    Key? key,
    this.themeMode = ThemeMode.system,
  }) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late ValueNotifier<ThemeSettings> settings;

  @override
  void initState() {
    super.initState();
    settings = ValueNotifier(ThemeSettings(
      sourceColor: const Color(0x0000af6a),
      themeMode: widget.themeMode,
    ));
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    ref.watch(carbonTrackerProvider);

    FoodPrediction(store: store).getData();

    return ThemeProvider(
      settings: settings,
      child: NotificationListener<ThemeSettingChange>(
        onNotification: (notification) {
          settings.value = notification.settings;
          return true;
        },
        child: ValueListenableBuilder<ThemeSettings>(
          valueListenable: settings,
          builder: (context, value, _) {
            final theme = ThemeProvider.of(context);
            return MaterialApp.router(
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              title: "Carbon Tracker",
              theme: theme.light(settings.value.sourceColor),
              darkTheme: theme.dark(settings.value.sourceColor),
              themeMode: theme.themeMode(),
            );
          },
        ),
      ),
    );
  }
}
