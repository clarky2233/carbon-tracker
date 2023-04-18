import 'dart:async';

import 'package:carbon_footprint_tracker/navigation/named_route.dart';
import 'package:carbon_footprint_tracker/ui/views/food_input/food_input_view.dart';
import 'package:carbon_footprint_tracker/screens/questionnaire/questionnaire_screen.dart';
import 'package:carbon_footprint_tracker/screens/transport_input/transport_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/object_box/object_box.dart';
import '../../models/user_info/user_info.dart';
import '../ui/views/activity/activity_view.dart';
import '../ui/views/activity_history/activity_history_view.dart';
import '../ui/views/base/base_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/settings/settings_view.dart';
import '../ui/views/settings/views/tracking_settings/tracking_settings_view.dart';

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
          BaseView(key: state.pageKey, child: child),
      routes: [
        GoRoute(
          name: NamedRoute.home.name,
          path: NamedRoute.home.path,
          redirect: _questionnaireRedirect,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeView(),
          ),
        ),
        GoRoute(
          name: NamedRoute.activityHistory.name,
          path: NamedRoute.activityHistory.path,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ActivityHistoryView(),
          ),
          routes: [
            GoRoute(
              name: NamedRoute.activity.name,
              path: NamedRoute.activity.path,
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                return ActivityView(
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
            child: SettingsView(),
          ),
          routes: [
            GoRoute(
              name: NamedRoute.trackingSettings.name,
              path: NamedRoute.trackingSettings.path,
              builder: (context, state) => const TrackingSettingsView(),
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
        return const FoodInputView();
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
