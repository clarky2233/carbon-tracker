import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'carbon_footprint_service.objectbox.dart';

final carbonFootprintServiceProvider =
    StateProvider<CarbonFootprintService>((ref) {
  return CarbonFootprintServiceObjectBox();
});

abstract class CarbonFootprintService {
  Stream<double> getTodaysEmissions();
}
