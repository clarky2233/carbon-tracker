import 'package:carbon_footprint_tracker/models/object_box/object_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'carbon_footprint_service.objectbox.dart';

final carbonFootprintServiceProvider = Provider<CarbonFootprintService>((ref) {
  return CarbonFootprintServiceObjectBox(store: store);
});

abstract class CarbonFootprintService {
  Stream<double> getTodaysEmissions();
}
