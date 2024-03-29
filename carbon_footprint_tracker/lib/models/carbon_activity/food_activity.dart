import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/serializer.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

import '../../ui/views/activity/widgets/food_activity/food_activity_view.dart';
import '../../ui/views/activity_history/widgets/food_activity_tile.dart';
import '../emission_factor/emission_factor.dart';
import 'constants/food_consumption.dart';

class FoodActivity implements CarbonActivity {
  @override
  String type = "food";

  @override
  int id;

  @override
  @Transient()
  Serializer serializer;

  DateTime date;

  FoodConsumption foodConsumption;

  FoodActivity({
    this.id = 0,
    this.serializer = const FoodActivitySerializer(),
    required this.date,
    required this.foodConsumption,
  });

  @override
  double? get emissions {
    return EmissionFactor.get(EmissionDetails(
      category: EmissionCategory.food,
      foodConsumption: foodConsumption,
    ));
  }

  @override
  Widget buildTile() {
    return FoodActivityTile(activity: this);
  }

  @override
  DateTime getDate() => date;

  @override
  Widget buildScreen() {
    return FoodActivityView(activity: this);
  }

  @override
  String get title => "Food";

  @override
  CarbonActivitySchema toDB() {
    return serializer.toDB(this);
  }

  FoodActivity copyWith({
    int? id,
    Serializer? serializer,
    DateTime? date,
    FoodConsumption? foodConsumption,
  }) {
    return FoodActivity(
      id: id ?? this.id,
      serializer: serializer ?? this.serializer,
      date: date ?? this.date,
      foodConsumption: foodConsumption ?? this.foodConsumption,
    );
  }
}

class FoodActivitySerializer extends Serializer<FoodActivity> {
  const FoodActivitySerializer();

  @override
  FoodActivity toActivity(CarbonActivitySchema schema) {
    return FoodActivity(
      id: schema.id,
      date: schema.startedAt,
      foodConsumption: schema.foodConsumption!,
    );
  }

  @override
  CarbonActivitySchema toDB(FoodActivity activity) {
    return CarbonActivitySchema(
      id: activity.id,
      type: activity.type,
      startedAt: activity.date,
      foodConsumption: activity.foodConsumption,
    );
  }
}
