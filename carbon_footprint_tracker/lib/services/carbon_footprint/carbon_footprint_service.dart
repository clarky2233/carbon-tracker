import '../../models/carbon_activity/carbon_activity.dart';
import 'carbon_footprint_service.objectbox.dart';

// final carbonFootprintServiceProvider = Provider<CarbonFootprintService>((ref) {
//   return CarbonFootprintServiceObjectBox(store: store);
// });

abstract class CarbonFootprintService {
  CarbonFootprintService._constructor();

  static final CarbonFootprintService _instance =
      CarbonFootprintServiceObjectBox.instance;

  static CarbonFootprintService get instance => _instance;

  Stream<double> getTodaysEmissions();

  Stream<Map<String, double>> getEmissionsByCategory(String range);
}
