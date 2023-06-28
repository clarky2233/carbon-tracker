import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrackingHelpDialog extends StatelessWidget {
  const TrackingHelpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.my_location_outlined),
      title: const Text("Tracking Help"),
      content: const SingleChildScrollView(
        child: ListBody(
          children: [
            Text("We need these on so we can track your every movement!"),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
