import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/carbon_footprint/carbon_footprint_service.dart';

final todaysEmissionsProvider = StreamProvider<double>((ref) async* {
  yield* CarbonFootprintService.instance.getTodaysEmissions();
});
