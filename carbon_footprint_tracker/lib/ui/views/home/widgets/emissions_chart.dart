import 'dart:developer';

import 'package:carbon_footprint_tracker/extensions/string_extensions.dart';
import 'package:carbon_footprint_tracker/ui/views/home/controllers/emissions_chart_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EmissionsChart extends ConsumerWidget {
  const EmissionsChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emissionStream = ref.watch(emissionChartDataProvider);

    return emissionStream.when(
      skipLoadingOnReload: true,
      data: (data) {
        return Center(
          child: SfCartesianChart(
            // title: ChartTitle(text: "Emissions Breakdown"),
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0),
            series: <ChartSeries<MapEntry<String, double>, String>>[
              ColumnSeries<MapEntry<String, double>, String>(
                dataSource: data.entries.toList(),
                xValueMapper: (MapEntry<String, double> entry, _) {
                  if (entry.key == "movement") {
                    return "Transport";
                  }
                  return entry.key.capitalize();
                },
                yValueMapper: (MapEntry<String, double> entry, _) {
                  return entry.value;
                },
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                dataLabelMapper: (entry, _) =>
                    "${entry.value.toStringAsFixed(2)} kg",
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        log(error.toString(), stackTrace: stackTrace);
        return const Text("error");
      },
      loading: () {
        return const SizedBox();
      },
    );
  }
}
