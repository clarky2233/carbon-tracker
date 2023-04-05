import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dart_date/dart_date.dart';

class DateHeader extends StatelessWidget {
  final DateTime dateTime;

  const DateHeader({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat("EEEE, dd MMM").format(dateTime);

    if (dateTime.isToday) date = "Today";
    if (dateTime.isYesterday) date = "Yesterday";

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        date,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
