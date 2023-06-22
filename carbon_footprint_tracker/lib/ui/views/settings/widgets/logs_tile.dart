import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/named_route.dart';

class LogsTile extends StatelessWidget {
  const LogsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.list_alt),
      title: const Text("Logs"),
      subtitle: const Text("View logs"),
      onTap: () {
        context.pushNamed(NamedRoute.logs.name);
      },
    );
  }
}
