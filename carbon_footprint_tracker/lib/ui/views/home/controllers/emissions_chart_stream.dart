import 'package:carbon_footprint_tracker/services/carbon_footprint/carbon_footprint_service.dart';
import 'package:carbon_footprint_tracker/ui/views/home/controllers/chart_time_period.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emissionChartDataProvider =
    StreamProvider<Map<String, double>>((ref) async* {
  final range = ref.watch(chartTimePeriodProvider);

  yield* CarbonFootprintService.instance.getEmissionsByCategory(range);
});
