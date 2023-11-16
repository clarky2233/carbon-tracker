import 'package:flutter/material.dart';

import 'serializer.dart';
import 'carbon_activity_schema.dart';

abstract class CarbonActivity {
  abstract int id;

  abstract Serializer serializer;

  abstract final String type;

  double? get emissions;

  String get title;

  DateTime getDate();

  Widget buildTile();

  Widget buildScreen();

  CarbonActivitySchema toDB();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarbonActivity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
