import 'package:carbon_footprint_tracker/extensions/string_extensions.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/transport_mode.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/carbon_activity_schema.dart';
import 'package:carbon_footprint_tracker/models/emission_factor/emission_factor.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/serializer.dart';
import 'package:flutter/material.dart';
import '../../ui/views/activity/widgets/movement_activity/movement_activity_view.dart';
import '../../ui/views/activity_history/widgets/movement_activity_tile.dart';
import 'constants/fuel_type.dart';
import 'constants/vehicle_size.dart';

class MovementActivity implements CarbonActivity {
  static const String type = "movement";

  @override
  int id;

  @override
  Serializer serializer;

  DateTime startedAt;

  DateTime endedAt;

  // String type;

  String? startStreet;
  String? startAdministrativeArea;
  String? startCountry;
  String? startPostcode;
  String? startSubLocality;
  double startLat;
  double startLong;

  String? endStreet;
  String? endAdministrativeArea;
  String? endCountry;
  String? endPostcode;
  String? endSubLocality;
  double endLat;
  double endLong;

  double distance;

  TransportMode transportMode;
  FuelType fuelType;
  VehicleSize vehicleSize;

  MovementActivity({
    this.id = 0,
    this.serializer = const MovementActivitySerializer(),
    required this.startedAt,
    required this.endedAt,
    // required this.type,
    required this.distance,
    required this.startLat,
    required this.startLong,
    required this.endLat,
    required this.endLong,
    required this.startStreet,
    required this.startAdministrativeArea,
    required this.startCountry,
    required this.startPostcode,
    required this.startSubLocality,
    required this.endStreet,
    required this.endAdministrativeArea,
    required this.endCountry,
    required this.endPostcode,
    required this.endSubLocality,
    this.vehicleSize = VehicleSize.none,
    this.fuelType = FuelType.none,
    required this.transportMode,
  });

  Duration get duration {
    return endedAt.difference(startedAt);
  }

  String get durationString {
    if (duration.inHours > 0 && duration.inMinutes % 60 == 0) {
      return "${duration.inHours} hr";
    } else if (duration.inHours > 0) {
      int minutes = duration.inMinutes - (duration.inHours * 60);
      return "${duration.inHours} hr $minutes min";
    } else if (duration.inMinutes == 0) {
      return "1 min";
    } else {
      return "${duration.inMinutes} min";
    }
  }

  String get distanceString {
    if (distance < 1000) {
      return "${distance.round()} m";
    }
    return "${(distance / 1000).toStringAsFixed(2)} km";
  }

  String get fullStartAddress {
    String address = "";

    List<String?> fields = [
      startStreet,
      startSubLocality,
      startPostcode,
      startAdministrativeArea,
      startCountry,
    ];

    for (String? field in fields) {
      if (field != null && field.isNotEmpty) {
        address += "$field ";
      }
    }

    address = address.trim();

    if (address.isEmpty) return "Unknown location";

    return address;
  }

  String get fullEndAddress {
    String address = "";

    List<String?> fields = [
      endStreet,
      endSubLocality,
      endPostcode,
      endAdministrativeArea,
      endCountry,
    ];

    for (String? field in fields) {
      if (field != null && field.isNotEmpty) {
        address += "$field ";
      }
    }

    address = address.trim();

    if (address.isEmpty) return "Unknown location";

    return address;
  }

  void estimateDistance() {
    distance = duration.inMinutes.toDouble();
  }

  @override
  double? get emissions {
    final Map<TransportMode, EmissionDetails> detailsMap = {
      TransportMode.walking: EmissionDetails(
        category: EmissionCategory.transport,
        transportMode: transportMode,
      ),
      TransportMode.cycling: EmissionDetails(
        category: EmissionCategory.transport,
        transportMode: transportMode,
      ),
      TransportMode.car: EmissionDetails(
        category: EmissionCategory.transport,
        transportMode: transportMode,
        fuelType: fuelType,
        vehicleSize: vehicleSize,
      ),
      TransportMode.motorbike: EmissionDetails(
        category: EmissionCategory.transport,
        transportMode: transportMode,
        vehicleSize: vehicleSize,
      ),
      TransportMode.bus: EmissionDetails(
        category: EmissionCategory.transport,
        transportMode: transportMode,
        fuelType: fuelType,
      ),
      TransportMode.train: EmissionDetails(
        category: EmissionCategory.transport,
        transportMode: transportMode,
      ),
    };

    EmissionDetails? details = detailsMap[transportMode];

    if (details == null) return null;

    final ef = EmissionFactor.get(details);

    if (ef == null) return null;

    if (distance == 0) return 0;

    return ef * (distance / 1000);
  }

  @override
  DateTime getDate() => startedAt;

  @override
  Widget buildTile() {
    return MovementActivityTile(activity: this);
  }

  @override
  Widget buildScreen() {
    return MovementActivityView(activity: this);
  }

  @override
  String get title => transportMode.name.capitalize();

  @override
  CarbonActivitySchema toDB() {
    return serializer.toDB(this);
  }

  MovementActivity copyWith({
    int? id,
    Serializer? serializer,
    DateTime? startedAt,
    DateTime? endedAt,
    String? startStreet,
    String? startAdministrativeArea,
    String? startCountry,
    String? startPostcode,
    String? startSubLocality,
    double? startLat,
    double? startLong,
    String? endStreet,
    String? endAdministrativeArea,
    String? endCountry,
    String? endPostcode,
    String? endSubLocality,
    double? endLat,
    double? endLong,
    double? distance,
    TransportMode? transportMode,
    FuelType? fuelType,
    VehicleSize? vehicleSize,
  }) {
    return MovementActivity(
      id: id ?? this.id,
      serializer: serializer ?? this.serializer,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      startStreet: startStreet ?? this.startStreet,
      startAdministrativeArea:
          startAdministrativeArea ?? this.startAdministrativeArea,
      startCountry: startCountry ?? this.startCountry,
      startPostcode: startPostcode ?? this.startPostcode,
      startSubLocality: startSubLocality ?? this.startSubLocality,
      startLat: startLat ?? this.startLat,
      startLong: startLong ?? this.startLong,
      endStreet: endStreet ?? this.endStreet,
      endAdministrativeArea:
          endAdministrativeArea ?? this.endAdministrativeArea,
      endCountry: endCountry ?? this.endCountry,
      endPostcode: endPostcode ?? this.endPostcode,
      endSubLocality: endSubLocality ?? this.endSubLocality,
      endLat: endLat ?? this.endLat,
      endLong: endLong ?? this.endLong,
      distance: distance ?? this.distance,
      transportMode: transportMode ?? this.transportMode,
      fuelType: fuelType ?? this.fuelType,
      vehicleSize: vehicleSize ?? this.vehicleSize,
    );
  }
}

class MovementActivitySerializer extends Serializer<MovementActivity> {
  const MovementActivitySerializer();

  @override
  MovementActivity toActivity(CarbonActivitySchema schema) {
    return MovementActivity(
      id: schema.id,
      startedAt: schema.startedAt,
      endedAt: schema.endedAt!,
      // type: schema.type,
      distance: schema.distance,
      startLat: schema.startLat!,
      startLong: schema.startLong!,
      endLat: schema.endLat!,
      endLong: schema.endLong!,
      startStreet: schema.startStreet,
      startAdministrativeArea: schema.startAdministrativeArea,
      startCountry: schema.startCountry,
      startPostcode: schema.startPostcode,
      startSubLocality: schema.startSubLocality,
      endStreet: schema.endStreet,
      endAdministrativeArea: schema.endAdministrativeArea,
      endCountry: schema.endCountry,
      endPostcode: schema.endPostcode,
      endSubLocality: schema.endSubLocality,
      vehicleSize: schema.vehicleSize ?? VehicleSize.none,
      fuelType: schema.fuelType ?? FuelType.none,
      transportMode: schema.transportMode!,
    );
  }

  @override
  CarbonActivitySchema toDB(MovementActivity activity) {
    return CarbonActivitySchema(
      id: activity.id,
      type: MovementActivity.type,
      startedAt: activity.startedAt,
      endedAt: activity.endedAt,
      distance: activity.distance,
      startLat: activity.startLat,
      startLong: activity.startLong,
      endLat: activity.endLat,
      endLong: activity.endLong,
      startStreet: activity.startStreet,
      startAdministrativeArea: activity.startAdministrativeArea,
      startCountry: activity.startCountry,
      startPostcode: activity.startPostcode,
      startSubLocality: activity.startSubLocality,
      endStreet: activity.endStreet,
      endAdministrativeArea: activity.endAdministrativeArea,
      endCountry: activity.endCountry,
      endPostcode: activity.endPostcode,
      endSubLocality: activity.endSubLocality,
      vehicleSize: activity.vehicleSize,
      fuelType: activity.fuelType,
      transportMode: activity.transportMode,
    );
  }
}
