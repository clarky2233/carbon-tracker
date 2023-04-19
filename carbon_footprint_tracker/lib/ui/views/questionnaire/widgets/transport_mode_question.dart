import 'package:carbon_footprint_tracker/extensions/string_extensions.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/user_info_notifier.dart';

class TransportModeQuestion extends ConsumerWidget {
  const TransportModeQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryTransport =
        ref.watch(userInfoProvider.select((value) => value.transportMode));
    final userInfoNotifier = ref.watch(userInfoProvider.notifier);

    final modes = [
      TransportMode.car,
      TransportMode.bus,
      TransportMode.train,
      TransportMode.motorbike
    ];

    return Column(
      children: [
        const Text("Select your primary transport mode"),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: modes.map((mode) {
            Color? color = mode == primaryTransport
                ? Theme.of(context).colorScheme.primary
                : null;

            return GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: mode == primaryTransport
                      ? Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        )
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(mode.icon, color: color),
                    Text(
                      mode.name.capitalize(),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: color),
                    ),
                  ],
                ),
              ),
              onTap: () {
                userInfoNotifier.setTransportMode(mode);
                // primaryTransportNotifier.state =
                // primaryTransport == mode ? null : mode;
                // final box = store.box<UserInfo>();
                // box.put(object)
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
