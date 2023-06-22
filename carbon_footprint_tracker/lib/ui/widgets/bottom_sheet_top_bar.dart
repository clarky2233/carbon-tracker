import 'package:flutter/material.dart';

class BottomSheetTopBar extends StatelessWidget {
  const BottomSheetTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 40,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }
}
