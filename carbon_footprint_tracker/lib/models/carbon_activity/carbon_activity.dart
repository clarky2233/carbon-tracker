import 'package:flutter/material.dart';

import '../../utils/serializer.dart';
import 'carbon_activity_schema.dart';

abstract class CarbonActivity {
  abstract int id;

  abstract Serializer serializer;

  double? get emissions;

  String get title;

  DateTime getDate();

  Widget buildTile();

  Widget buildScreen();

  CarbonActivitySchema toDB();
}
