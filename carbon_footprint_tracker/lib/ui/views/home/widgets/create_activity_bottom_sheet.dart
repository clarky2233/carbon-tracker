import 'package:carbon_footprint_tracker/navigation/named_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateActivityBottomSheet extends StatelessWidget {
  const CreateActivityBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "New Activity",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.close, size: 32),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            leading: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(
                Icons.restaurant,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            title: Text(
              "Food",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            onTap: () {
              context.pop();
              context.pushNamed(NamedRoute.foodInput.name);
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            leading: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(
                Icons.directions_car,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            title: Text(
              "Transport",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            onTap: () {
              context.pop();
              context.pushNamed(NamedRoute.transportInput.name);
            },
          ),
        ],
      ),
    );
  }
}
