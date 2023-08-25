import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/electricity_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/food_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/serializer.dart';
import 'package:objectbox/objectbox.dart';

import 'constants/food_consumption.dart';
import 'constants/fuel_type.dart';
import 'constants/transport_mode.dart';
import 'constants/vehicle_size.dart';
import 'movement_activity.dart';

@Entity()
class CarbonActivitySchema {
  @Id()
  int id;

  @Property(type: PropertyType.date)
  DateTime startedAt;

  @Property(type: PropertyType.date)
  DateTime? endedAt;

  String type;

  String? startStreet;
  String? startAdministrativeArea;
  String? startCountry;
  String? startPostcode;
  String? startSubLocality;
  double? startLat;
  double? startLong;

  String? endStreet;
  String? endAdministrativeArea;
  String? endCountry;
  String? endPostcode;
  String? endSubLocality;
  double? endLat;
  double? endLong;

  double distance;

  @Transient()
  FuelType? fuelType;

  @Transient()
  VehicleSize? vehicleSize;

  @Transient()
  TransportMode? transportMode;

  @Transient()
  FoodConsumption? foodConsumption;

  int? kiloWatts;

  CarbonActivitySchema({
    this.id = 0,
    required this.type,
    required this.startedAt,
    this.endedAt,
    this.distance = 0,
    this.startLat,
    this.startLong,
    this.endLat,
    this.endLong,
    this.startStreet,
    this.startAdministrativeArea,
    this.startCountry,
    this.startPostcode,
    this.startSubLocality,
    this.endStreet,
    this.endAdministrativeArea,
    this.endCountry,
    this.endPostcode,
    this.endSubLocality,
    this.vehicleSize,
    this.fuelType,
    this.transportMode,
    this.foodConsumption,
    this.kiloWatts,
  });

  String? get dbFuelType {
    return fuelType?.name;
  }

  set dbFuelType(String? name) {
    if (name == null) {
      fuelType = null;
    } else {
      fuelType = FuelType.values.byName(name);
    }
  }

  String? get dbVehicleSize {
    return vehicleSize?.name;
  }

  set dbVehicleSize(String? name) {
    if (name == null) {
      vehicleSize = null;
    } else {
      vehicleSize = VehicleSize.values.byName(name);
    }
  }

  String? get dbTransportMode {
    return transportMode?.name;
  }

  set dbTransportMode(String? name) {
    if (name == null) {
      transportMode = null;
    } else {
      transportMode = TransportMode.values.byName(name);
    }
  }

  String? get dbFoodConsumption {
    return foodConsumption?.name;
  }

  set dbFoodConsumption(String? name) {
    if (name == null) {
      foodConsumption = null;
    } else {
      foodConsumption = FoodConsumption.values.byName(name);
    }
  }

  CarbonActivity toActivity() {
    final Map<String, Serializer> serializers = {
      "food": const FoodActivitySerializer(),
      "movement": const MovementActivitySerializer(),
      "electricity": const ElectricityActivitySerializer(),
    };

    if (!serializers.containsKey(type)) {
      throw Exception("Could not convert $type to CarbonActivity");
    }

    final serializer = serializers[type]!;
    return serializer.toActivity(this);
  }
}
