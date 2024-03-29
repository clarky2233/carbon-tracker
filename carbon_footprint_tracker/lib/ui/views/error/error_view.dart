import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String msg;

  const ErrorView({
    Key? key,
    required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Center(
        child: Text(
          msg,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
