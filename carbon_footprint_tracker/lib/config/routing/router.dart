import 'dart:async';

import 'package:carbon_footprint_tracker/config/routing/named_route.dart';
import 'package:carbon_footprint_tracker/screens/activity/activity_screen.dart';
import 'package:carbon_footprint_tracker/screens/activity_history/activity_history_screen.dart';
import 'package:carbon_footprint_tracker/screens/base/base_scaffold.dart';
import 'package:carbon_footprint_tracker/screens/food_input/food_input_screen.dart';
import 'package:carbon_footprint_tracker/screens/home/home_screen.dart';
import 'package:carbon_footprint_tracker/screens/questionnaire/questionnaire_screen.dart';
import 'package:carbon_footprint_tracker/screens/settings/screens/tracking_settings/tracking_settings_screen.dart';
import 'package:carbon_footprint_tracker/screens/settings/settings_screen.dart';
import 'package:carbon_footprint_tracker/screens/transport_input/transport_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/object_box/object_box.dart';
import '../../models/user_info/user_info.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

FutureOr<String?> _questionnaireRedirect(
    BuildContext context, GoRouterState state) async {
  final box = store.box<UserInfo>();
  final userInfoList = box.getAll();

  if (userInfoList.isEmpty) {
    return NamedRoute.questionnaire.path;
  }
  return null;
}

final router = GoRouter(
  initialLocation: NamedRoute.home.path,
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) =>
          BaseScaffold(key: state.pageKey, child: child),
      routes: [
        GoRoute(
          name: NamedRoute.home.name,
          path: NamedRoute.home.path,
          redirect: _questionnaireRedirect,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          name: NamedRoute.activityHistory.name,
          path: NamedRoute.activityHistory.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ActivityHistoryScreen(),
          ),
          routes: [
            GoRoute(
              name: NamedRoute.activity.name,
              path: NamedRoute.activity.path,
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                return ActivityScreen(
                  id: int.parse(state.params['id'] ?? "-1"),
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: NamedRoute.settings.name,
          path: NamedRoute.settings.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
          routes: [
            GoRoute(
              name: NamedRoute.trackingSettings.name,
              path: NamedRoute.trackingSettings.path,
              builder: (context, state) => const TrackingSettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: NamedRoute.questionnaire.name,
      path: NamedRoute.questionnaire.path,
      builder: (context, state) {
        return const QuestionnaireScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: NamedRoute.foodInput.name,
      path: NamedRoute.foodInput.path,
      builder: (context, state) {
        return const FoodInputScreen();
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      name: NamedRoute.transportInput.name,
      path: NamedRoute.transportInput.path,
      builder: (context, state) {
        return const TransportInputScreen();
      },
    ),
  ],
);
