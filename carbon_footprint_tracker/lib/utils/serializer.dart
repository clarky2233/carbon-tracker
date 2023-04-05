import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';

abstract class Serializer<T> {
  const Serializer();

  CarbonActivitySchema toDB(T activity);

  T toActivity(CarbonActivitySchema schema);
}
