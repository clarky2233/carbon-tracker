import 'dart:developer';

import 'package:carbon_footprint_tracker/models/carbon_activity/constants/fuel_type.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/vehicle_size.dart';

class EmissionFactor {
  static final Map<EmissionDetails, double> _emissionTable = {
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.walking,
    ): 0.055,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.cycling,
    ): 0.035,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
    ): 0.25,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.petroleum,
      vehicleSize: VehicleSize.small,
    ): 0.14946,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.petroleum,
      vehicleSize: VehicleSize.medium,
    ): 0.18785,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.petroleum,
      vehicleSize: VehicleSize.large,
    ): 0.27909,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.diesel,
      vehicleSize: VehicleSize.small,
    ): 0.13758,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.diesel,
      vehicleSize: VehicleSize.medium,
    ): 0.16496,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.diesel,
      vehicleSize: VehicleSize.large,
    ): 0.20721,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.electric,
      vehicleSize: VehicleSize.small,
    ): 0.0,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.electric,
      vehicleSize: VehicleSize.medium,
    ): 0.0,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.electric,
      vehicleSize: VehicleSize.large,
    ): 0.0,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.hybrid,
      vehicleSize: VehicleSize.small,
    ): 0.10494,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.hybrid,
      vehicleSize: VehicleSize.medium,
    ): 0.10957,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.hybrid,
      vehicleSize: VehicleSize.large,
    ): 0.15151,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.plugInHybrid,
      vehicleSize: VehicleSize.small,
    ): 0.02241,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.plugInHybrid,
      vehicleSize: VehicleSize.medium,
    ): 0.06944,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.car,
      fuelType: FuelType.plugInHybrid,
      vehicleSize: VehicleSize.large,
    ): 0.07674,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.motorbike,
      vehicleSize: VehicleSize.small,
    ): 0.08306,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.motorbike,
      vehicleSize: VehicleSize.medium,
    ): 0.10090,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.motorbike,
      vehicleSize: VehicleSize.large,
    ): 0.13245,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.bus,
      fuelType: FuelType.diesel,
    ): 0.137,
    // https://www.linkedin.com/pulse/greenhouse-emissions-from-travel-sydney-leon-arundell
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.bus,
      fuelType: FuelType.electric,
    ): 0,
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.train,
    ): 0.079,
    // https://www.linkedin.com/pulse/greenhouse-emissions-from-travel-sydney-leon-arundell
    EmissionDetails(
      category: EmissionCategory.transport,
      transportMode: TransportMode.flying,
    ): 0.115,
    EmissionDetails(
      category: EmissionCategory.electricity,
    ): 0.531,
    // https://ourworldindata.org/grapher/carbon-intensity-electricity
    EmissionDetails(
      category: EmissionCategory.food,
    ): -1,
  };

  static double? get(EmissionDetails details) {
    if (!_emissionTable.containsKey(details)) {
      log("Emission factor not found for details: $details");
      return null;
      // throw Exception("Emission factor not found for details: $details");
    }

    return _emissionTable[details]!;
  }
}

class EmissionDetails {
  final EmissionCategory category;
  final TransportMode? transportMode;
  final FuelType? fuelType;
  final VehicleSize? vehicleSize;

  const EmissionDetails({
    required this.category,
    this.transportMode,
    this.fuelType,
    this.vehicleSize,
  }) : assert(
            (category == EmissionCategory.transport && transportMode != null) ||
                category != EmissionCategory.transport);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmissionDetails &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          transportMode == other.transportMode &&
          fuelType == other.fuelType &&
          vehicleSize == other.vehicleSize;

  @override
  int get hashCode =>
      category.hashCode ^
      transportMode.hashCode ^
      fuelType.hashCode ^
      vehicleSize.hashCode;

  @override
  String toString() {
    return 'EmissionDetails{category: $category, transportMode: $transportMode, fuelType: $fuelType, vehicleSize: $vehicleSize}';
  }
}

enum EmissionCategory {
  transport,
  food,
  electricity;
}
