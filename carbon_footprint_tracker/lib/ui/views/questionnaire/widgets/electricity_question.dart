import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/user_info_notifier.dart';

class ElectricityQuestion extends ConsumerWidget {
  const ElectricityQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final electricityUsage =
        ref.watch(userInfoProvider.select((value) => value.electricityUsage));
    final electricityNotifier = ref.watch(userInfoProvider.notifier);

    return Column(
      children: [
        const Text(
          "What is your average daily kWh electricity usage from non\u2011green energy sources",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        Text(
          "${electricityUsage ?? 0}",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        Text(
          "kWh/day",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).textTheme.bodySmall!.color),
        ),
        const SizedBox(height: 16),
        Slider(
          min: 0,
          max: 50,
          label: electricityUsage.toString(),
          value: electricityUsage?.toDouble() ?? 0,
          onChanged: (val) {
            electricityNotifier.setElectricityUsage(val.toInt());
          },
        ),
      ],
    );
  }
}
