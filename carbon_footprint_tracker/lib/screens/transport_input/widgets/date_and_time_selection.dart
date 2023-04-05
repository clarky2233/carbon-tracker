import 'package:carbon_footprint_tracker/screens/transport_input/transport_input_screen.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateAndTimeSelection extends ConsumerWidget {
  const DateAndTimeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(newTripProvider.select((value) => value.startedAt));
    final startTime = ref.watch(newTripProvider
        .select((value) => TimeOfDay.fromDateTime(value.startedAt)));
    final endTime = ref.watch(newTripProvider
        .select((value) => TimeOfDay.fromDateTime(value.endedAt)));

    final notifier = ref.watch(newTripProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Date and Time",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.calendar_today_outlined),
          title: const Text("Date"),
          trailing: Text(date.format(DateFormat.YEAR_MONTH_DAY)),
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );

            if (selectedDate != null) {
              notifier.setDate(selectedDate);
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.timer_outlined),
          title: const Text("Departure Time"),
          trailing: Text(startTime.format(context)),
          onTap: () async {
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: startTime,
            );

            if (selectedTime != null) {
              notifier.setStartTime(selectedTime);
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.flag_outlined),
          title: const Text("Arrival Time"),
          trailing: Text(endTime.format(context)),
          onTap: () async {
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: endTime,
            );

            if (selectedTime != null) {
              notifier.setEndTime(selectedTime);
            }
          },
        ),
      ],
    );
  }
}
