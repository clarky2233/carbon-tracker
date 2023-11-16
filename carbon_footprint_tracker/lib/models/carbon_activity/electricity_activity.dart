import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/serializer.dart';
import 'package:carbon_footprint_tracker/objectbox.g.dart';
import 'package:carbon_footprint_tracker/ui/views/activity/widgets/electricity_activity/electricity_activity_view.dart';
import 'package:carbon_footprint_tracker/ui/views/activity_history/widgets/electricity_activity_tile.dart';
import 'package:flutter/material.dart';

import '../emission_factor/emission_factor.dart';

class ElectricityActivity implements CarbonActivity {
  @override
  String type = "electricity";

  @override
  int id;

  @override
  @Transient()
  Serializer serializer;

  DateTime date;

  int kiloWatts;

  ElectricityActivity({
    this.id = 0,
    this.serializer = const ElectricityActivitySerializer(),
    required this.date,
    required this.kiloWatts,
  });

  @override
  Widget buildScreen() {
    return ElectricityActivityView(activity: this);
  }

  @override
  Widget buildTile() {
    return ElectricityActivityTile(activity: this);
  }

  @override
  double? get emissions {
    return EmissionFactor.get(EmissionDetails(
          category: EmissionCategory.electricity,
        ))! *
        kiloWatts;
  }

  @override
  DateTime getDate() => date;

  @override
  String get title => "Electricity";

  @override
  CarbonActivitySchema toDB() {
    return serializer.toDB(this);
  }

  ElectricityActivity copyWith({
    int? id,
    Serializer? serializer,
    DateTime? date,
    int? kiloWatts,
  }) {
    return ElectricityActivity(
      id: id ?? this.id,
      serializer: serializer ?? this.serializer,
      date: date ?? this.date,
      kiloWatts: kiloWatts ?? this.kiloWatts,
    );
  }
}

class ElectricityActivitySerializer extends Serializer<ElectricityActivity> {
  const ElectricityActivitySerializer();

  @override
  ElectricityActivity toActivity(CarbonActivitySchema schema) {
    return ElectricityActivity(
      id: schema.id,
      date: schema.startedAt,
      kiloWatts: schema.kiloWatts!,
    );
  }

  @override
  CarbonActivitySchema toDB(ElectricityActivity activity) {
    return CarbonActivitySchema(
      id: activity.id,
      type: activity.type,
      startedAt: activity.date,
      kiloWatts: activity.kiloWatts,
    );
  }
}
