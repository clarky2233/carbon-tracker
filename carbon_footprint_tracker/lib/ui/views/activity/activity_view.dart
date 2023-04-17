import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/loading_screen.dart';
import '../error/error_view.dart';
import 'activity_view_controller.dart';

class ActivityView extends ConsumerWidget {
  final int id;

  const ActivityView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityStream = ref.watch(activityProvider(id));

    const errorScreen = ErrorView(msg: "Unable to load activity");

    return activityStream.when(
      data: (activity) => activity?.buildScreen() ?? errorScreen,
      error: (err, stackTrace) {
        log(err.toString(), stackTrace: stackTrace);
        return errorScreen;
      },
      loading: () => const LoadingScreen(),
    );
  }
}
