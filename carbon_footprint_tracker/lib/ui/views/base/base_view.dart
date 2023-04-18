import 'package:carbon_footprint_tracker/navigation/named_route.dart';
import 'package:carbon_footprint_tracker/ui/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../activity_history/activity_history_view.dart';
import '../settings/settings_view.dart';
import 'controllers/base_view_index.dart';

class BaseView extends ConsumerStatefulWidget {
  final Widget child;

  const BaseView({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  ConsumerState<BaseView> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends ConsumerState<BaseView> {
  final List<NamedRoute> _routes = [
    NamedRoute.home,
    NamedRoute.activityHistory,
    NamedRoute.settings,
  ];

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      selectedIcon: Icon(Icons.home_filled),
      icon: Icon(Icons.home_outlined),
      label: "Home",
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.stacked_line_chart),
      icon: Icon(Icons.stacked_line_chart),
      label: "Activity",
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.settings),
      icon: Icon(Icons.settings_outlined),
      label: "Settings",
    ),
  ];

  final List<Widget> _screens = const [
    HomeView(),
    ActivityHistoryView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    assert((_routes.length == _destinations.length) &&
        (_destinations.length == _screens.length));

    final selectedIndex = ref.watch(selectedIndexProvider);
    final selectedIndexNotifier = ref.watch(selectedIndexProvider.notifier);

    return Scaffold(
      body: widget.child,
      // body: IndexedStack(
      //   index: _selectedIndex(context),
      //   children: _screens,
      // ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: _destinations,
        onDestinationSelected: (newIndex) {
          selectedIndexNotifier.state = newIndex;
          final routeName = _routes[newIndex].name;
          context.goNamed(routeName);
        },
      ),
    );
  }

// int _selectedIndex(BuildContext context) {
//   final location = GoRouter.of(context).location;
//   return _routes
//       .indexWhere((namedRoute) => location.startsWith(namedRoute.path));
// }
}
