import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/activity_view_notifier.dart';

class DeleteActivityButton extends ConsumerWidget {
  final CarbonActivity activity;

  const DeleteActivityButton({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ref.watch(activityViewProvider(activity).notifier);

    return IconButton(
      onPressed: () async {
        final shouldDelete = await showDialog<bool?>(
              context: context,
              builder: (context) => const DeleteActivityAlertDialog(),
            ) ??
            false;

        if (shouldDelete) {
          controller.deleteActivity();
          if (context.mounted) context.pop();
        }
      },
      icon: const Icon(Icons.delete_outline),
    );
  }
}

class DeleteActivityAlertDialog extends StatelessWidget {
  const DeleteActivityAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.delete_outline),
      title: const Text("Delete Activity"),
      content:
          const Text("Are your sure you would like to delete this activity?"),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
