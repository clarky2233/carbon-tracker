import 'package:carbon_footprint_tracker/models/carbon_activity/constants/food_consumption.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/fuel_type.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserInfo {
  @Id()
  int id;

  @Transient()
  TransportMode? transportMode;

  @Transient()
  FuelType? fuelType;

  @Transient()
  FoodConsumption? foodConsumption;

  int? electricityUsage;

  UserInfo({
    this.id = 0,
    this.transportMode,
    this.fuelType,
    this.foodConsumption,
    this.electricityUsage,
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

  UserInfo copyWith({
    int? id,
    TransportMode? transportMode,
    FuelType? fuelType,
    FoodConsumption? foodConsumption,
    int? electricityUsage,
  }) {
    return UserInfo(
      id: id ?? this.id,
      transportMode: transportMode ?? this.transportMode,
      fuelType: fuelType ?? this.fuelType,
      foodConsumption: foodConsumption ?? this.foodConsumption,
      electricityUsage: electricityUsage ?? this.electricityUsage,
    );
  }
}
