import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'carbon_footprint_service.objectbox.dart';

final carbonFootprintServiceProvider = Provider<CarbonFootprintService>((ref) {
  return CarbonFootprintServiceObjectBox();
});

abstract class CarbonFootprintService {
  Stream<double> getTodaysEmissions();
}
