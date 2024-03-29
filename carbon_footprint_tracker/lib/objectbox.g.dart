// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/carbon_activity/carbon_activity_schema.dart';
import 'models/event_log/event_log.dart';
import 'models/user_info/user_info.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(2, 8869421646804938704),
      name: 'EventLog',
      lastPropertyId: const IdUid(3, 6076984115426153339),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4791199626963107493),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3483469293835683808),
            name: 'dateTime',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6076984115426153339),
            name: 'event',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 8697253885172152997),
      name: 'UserInfo',
      lastPropertyId: const IdUid(5, 7693781914797803169),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3577101806362542237),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5304096574407515361),
            name: 'dbFuelType',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1467616384368605671),
            name: 'electricityUsage',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 4850971290598768803),
            name: 'dbTransportMode',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7693781914797803169),
            name: 'dbFoodConsumption',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(8, 2844881390421948169),
      name: 'CarbonActivitySchema',
      lastPropertyId: const IdUid(24, 5780599889388550771),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8491492394133401012),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8396949639387904276),
            name: 'startedAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2053464790039945951),
            name: 'endedAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 9016157672478142450),
            name: 'type',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7837932648662856610),
            name: 'startStreet',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2113470997562665707),
            name: 'startAdministrativeArea',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 6960000837750088992),
            name: 'startCountry',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 3612671993068936124),
            name: 'startPostcode',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7573065429484548386),
            name: 'startSubLocality',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 8051991507302334507),
            name: 'startLat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(11, 7093976677212661110),
            name: 'startLong',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(12, 6314343575496310274),
            name: 'endStreet',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(13, 7823479091256768093),
            name: 'endAdministrativeArea',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(14, 2146864974079077387),
            name: 'endCountry',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(15, 3412348717661291019),
            name: 'endPostcode',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(16, 7905445629403739606),
            name: 'endSubLocality',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(17, 5855804365724853109),
            name: 'endLat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(18, 7682914791348042108),
            name: 'endLong',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(19, 6573214611696650478),
            name: 'distance',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(20, 8269407204990478686),
            name: 'dbFuelType',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(21, 9082272971350715689),
            name: 'dbVehicleSize',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(22, 540465606795856046),
            name: 'dbTransportMode',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(23, 4292925692117170474),
            name: 'dbFoodConsumption',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(24, 5780599889388550771),
            name: 'kiloWatts',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(8, 2844881390421948169),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [
        4608326756445144575,
        5994355788629986286,
        1456642151988845519,
        2159185856962692406,
        7292721406146125265
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        1799402235900616859,
        8748533480636356525,
        9091625615608921959,
        2180398695039165150,
        6112181393171412097,
        4916882122303638406,
        970581979879465098,
        938621711941265422,
        4690160562483975372,
        2556923748346507973,
        3092496745499608451,
        3338419488097379889,
        8674042375178587912,
        7316249529924829245,
        784099982364794067,
        7427581536060477353,
        1214668913600638488,
        2162915921798281844,
        6499278007178329742,
        5640584617936083988,
        8971397736353572204,
        541326768221711052,
        3569442119013286730,
        2370145059827723983,
        2841855114280038898,
        9153924864983031550,
        3032290418871891447,
        8862997192602082157,
        6763285235403505911,
        491714385783593884,
        7139961272000505858,
        3331517637736533726,
        1091512867312273571,
        414702381036443573,
        2981318257694714794,
        5972020751089411600,
        7979883068020727878,
        3970033228747383716,
        3830037193228460726,
        5968213173951786933,
        579172358538623065,
        3104286596353710580,
        1145312620296988094,
        4453644992985982955,
        3346164696164664013,
        4592910464645553332,
        5703462706641101870,
        6850879952447337500,
        6625950134772725231,
        8442125498061865170,
        4529644793083588380,
        212024590261414613,
        7339134596328951361,
        4722776702317516307,
        7443285065933017941,
        6033474204387752641,
        4639499019651332823,
        1978532525565513076,
        215026859046256473,
        210173426268022955,
        4767799953563814479,
        847093365318121093,
        2256459619923659894,
        3051003341836422804,
        6574180721021542712,
        6576293660283213547,
        2404021936240527709,
        5315556805651885935,
        7948617055936216347,
        1238340902853105292
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    EventLog: EntityDefinition<EventLog>(
        model: _entities[0],
        toOneRelations: (EventLog object) => [],
        toManyRelations: (EventLog object) => {},
        getId: (EventLog object) => object.id,
        setId: (EventLog object, int id) {
          object.id = id;
        },
        objectToFB: (EventLog object, fb.Builder fbb) {
          final eventOffset = fbb.writeString(object.event);
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.dateTime.millisecondsSinceEpoch);
          fbb.addOffset(2, eventOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = EventLog(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              dateTime: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0)),
              event: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''));

          return object;
        }),
    UserInfo: EntityDefinition<UserInfo>(
        model: _entities[1],
        toOneRelations: (UserInfo object) => [],
        toManyRelations: (UserInfo object) => {},
        getId: (UserInfo object) => object.id,
        setId: (UserInfo object, int id) {
          object.id = id;
        },
        objectToFB: (UserInfo object, fb.Builder fbb) {
          final dbFuelTypeOffset = object.dbFuelType == null
              ? null
              : fbb.writeString(object.dbFuelType!);
          final dbTransportModeOffset = object.dbTransportMode == null
              ? null
              : fbb.writeString(object.dbTransportMode!);
          final dbFoodConsumptionOffset = object.dbFoodConsumption == null
              ? null
              : fbb.writeString(object.dbFoodConsumption!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, dbFuelTypeOffset);
          fbb.addInt64(2, object.electricityUsage);
          fbb.addOffset(3, dbTransportModeOffset);
          fbb.addOffset(4, dbFoodConsumptionOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = UserInfo(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              electricityUsage: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 8))
            ..dbFuelType = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 6)
            ..dbTransportMode = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 10)
            ..dbFoodConsumption = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 12);

          return object;
        }),
    CarbonActivitySchema: EntityDefinition<CarbonActivitySchema>(
        model: _entities[2],
        toOneRelations: (CarbonActivitySchema object) => [],
        toManyRelations: (CarbonActivitySchema object) => {},
        getId: (CarbonActivitySchema object) => object.id,
        setId: (CarbonActivitySchema object, int id) {
          object.id = id;
        },
        objectToFB: (CarbonActivitySchema object, fb.Builder fbb) {
          final typeOffset = fbb.writeString(object.type);
          final startStreetOffset = object.startStreet == null
              ? null
              : fbb.writeString(object.startStreet!);
          final startAdministrativeAreaOffset =
              object.startAdministrativeArea == null
                  ? null
                  : fbb.writeString(object.startAdministrativeArea!);
          final startCountryOffset = object.startCountry == null
              ? null
              : fbb.writeString(object.startCountry!);
          final startPostcodeOffset = object.startPostcode == null
              ? null
              : fbb.writeString(object.startPostcode!);
          final startSubLocalityOffset = object.startSubLocality == null
              ? null
              : fbb.writeString(object.startSubLocality!);
          final endStreetOffset = object.endStreet == null
              ? null
              : fbb.writeString(object.endStreet!);
          final endAdministrativeAreaOffset =
              object.endAdministrativeArea == null
                  ? null
                  : fbb.writeString(object.endAdministrativeArea!);
          final endCountryOffset = object.endCountry == null
              ? null
              : fbb.writeString(object.endCountry!);
          final endPostcodeOffset = object.endPostcode == null
              ? null
              : fbb.writeString(object.endPostcode!);
          final endSubLocalityOffset = object.endSubLocality == null
              ? null
              : fbb.writeString(object.endSubLocality!);
          final dbFuelTypeOffset = object.dbFuelType == null
              ? null
              : fbb.writeString(object.dbFuelType!);
          final dbVehicleSizeOffset = object.dbVehicleSize == null
              ? null
              : fbb.writeString(object.dbVehicleSize!);
          final dbTransportModeOffset = object.dbTransportMode == null
              ? null
              : fbb.writeString(object.dbTransportMode!);
          final dbFoodConsumptionOffset = object.dbFoodConsumption == null
              ? null
              : fbb.writeString(object.dbFoodConsumption!);
          fbb.startTable(25);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.startedAt.millisecondsSinceEpoch);
          fbb.addInt64(2, object.endedAt?.millisecondsSinceEpoch);
          fbb.addOffset(3, typeOffset);
          fbb.addOffset(4, startStreetOffset);
          fbb.addOffset(5, startAdministrativeAreaOffset);
          fbb.addOffset(6, startCountryOffset);
          fbb.addOffset(7, startPostcodeOffset);
          fbb.addOffset(8, startSubLocalityOffset);
          fbb.addFloat64(9, object.startLat);
          fbb.addFloat64(10, object.startLong);
          fbb.addOffset(11, endStreetOffset);
          fbb.addOffset(12, endAdministrativeAreaOffset);
          fbb.addOffset(13, endCountryOffset);
          fbb.addOffset(14, endPostcodeOffset);
          fbb.addOffset(15, endSubLocalityOffset);
          fbb.addFloat64(16, object.endLat);
          fbb.addFloat64(17, object.endLong);
          fbb.addFloat64(18, object.distance);
          fbb.addOffset(19, dbFuelTypeOffset);
          fbb.addOffset(20, dbVehicleSizeOffset);
          fbb.addOffset(21, dbTransportModeOffset);
          fbb.addOffset(22, dbFoodConsumptionOffset);
          fbb.addInt64(23, object.kiloWatts);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final endedAtValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8);
          final object = CarbonActivitySchema(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              type: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              startedAt: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0)),
              endedAt: endedAtValue == null
                  ? null
                  : DateTime.fromMillisecondsSinceEpoch(endedAtValue),
              distance:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 40, 0),
              startLat: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 22),
              startLong: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 24),
              endLat: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 36),
              endLong: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 38),
              startStreet: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              startAdministrativeArea: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 14),
              startCountry: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 16),
              startPostcode: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 18),
              startSubLocality: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 20),
              endStreet: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 26),
              endAdministrativeArea: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 28),
              endCountry: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 30),
              endPostcode: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 32),
              endSubLocality: const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 34),
              kiloWatts: const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 50))
            ..dbFuelType = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 42)
            ..dbVehicleSize = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 44)
            ..dbTransportMode = const fb.StringReader(asciiOptimization: true)
                .vTableGetNullable(buffer, rootOffset, 46)
            ..dbFoodConsumption = const fb.StringReader(asciiOptimization: true).vTableGetNullable(buffer, rootOffset, 48);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [EventLog] entity fields to define ObjectBox queries.
class EventLog_ {
  /// see [EventLog.id]
  static final id = QueryIntegerProperty<EventLog>(_entities[0].properties[0]);

  /// see [EventLog.dateTime]
  static final dateTime =
      QueryIntegerProperty<EventLog>(_entities[0].properties[1]);

  /// see [EventLog.event]
  static final event =
      QueryStringProperty<EventLog>(_entities[0].properties[2]);
}

/// [UserInfo] entity fields to define ObjectBox queries.
class UserInfo_ {
  /// see [UserInfo.id]
  static final id = QueryIntegerProperty<UserInfo>(_entities[1].properties[0]);

  /// see [UserInfo.dbFuelType]
  static final dbFuelType =
      QueryStringProperty<UserInfo>(_entities[1].properties[1]);

  /// see [UserInfo.electricityUsage]
  static final electricityUsage =
      QueryIntegerProperty<UserInfo>(_entities[1].properties[2]);

  /// see [UserInfo.dbTransportMode]
  static final dbTransportMode =
      QueryStringProperty<UserInfo>(_entities[1].properties[3]);

  /// see [UserInfo.dbFoodConsumption]
  static final dbFoodConsumption =
      QueryStringProperty<UserInfo>(_entities[1].properties[4]);
}

/// [CarbonActivitySchema] entity fields to define ObjectBox queries.
class CarbonActivitySchema_ {
  /// see [CarbonActivitySchema.id]
  static final id =
      QueryIntegerProperty<CarbonActivitySchema>(_entities[2].properties[0]);

  /// see [CarbonActivitySchema.startedAt]
  static final startedAt =
      QueryIntegerProperty<CarbonActivitySchema>(_entities[2].properties[1]);

  /// see [CarbonActivitySchema.endedAt]
  static final endedAt =
      QueryIntegerProperty<CarbonActivitySchema>(_entities[2].properties[2]);

  /// see [CarbonActivitySchema.type]
  static final type =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[3]);

  /// see [CarbonActivitySchema.startStreet]
  static final startStreet =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[4]);

  /// see [CarbonActivitySchema.startAdministrativeArea]
  static final startAdministrativeArea =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[5]);

  /// see [CarbonActivitySchema.startCountry]
  static final startCountry =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[6]);

  /// see [CarbonActivitySchema.startPostcode]
  static final startPostcode =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[7]);

  /// see [CarbonActivitySchema.startSubLocality]
  static final startSubLocality =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[8]);

  /// see [CarbonActivitySchema.startLat]
  static final startLat =
      QueryDoubleProperty<CarbonActivitySchema>(_entities[2].properties[9]);

  /// see [CarbonActivitySchema.startLong]
  static final startLong =
      QueryDoubleProperty<CarbonActivitySchema>(_entities[2].properties[10]);

  /// see [CarbonActivitySchema.endStreet]
  static final endStreet =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[11]);

  /// see [CarbonActivitySchema.endAdministrativeArea]
  static final endAdministrativeArea =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[12]);

  /// see [CarbonActivitySchema.endCountry]
  static final endCountry =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[13]);

  /// see [CarbonActivitySchema.endPostcode]
  static final endPostcode =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[14]);

  /// see [CarbonActivitySchema.endSubLocality]
  static final endSubLocality =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[15]);

  /// see [CarbonActivitySchema.endLat]
  static final endLat =
      QueryDoubleProperty<CarbonActivitySchema>(_entities[2].properties[16]);

  /// see [CarbonActivitySchema.endLong]
  static final endLong =
      QueryDoubleProperty<CarbonActivitySchema>(_entities[2].properties[17]);

  /// see [CarbonActivitySchema.distance]
  static final distance =
      QueryDoubleProperty<CarbonActivitySchema>(_entities[2].properties[18]);

  /// see [CarbonActivitySchema.dbFuelType]
  static final dbFuelType =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[19]);

  /// see [CarbonActivitySchema.dbVehicleSize]
  static final dbVehicleSize =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[20]);

  /// see [CarbonActivitySchema.dbTransportMode]
  static final dbTransportMode =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[21]);

  /// see [CarbonActivitySchema.dbFoodConsumption]
  static final dbFoodConsumption =
      QueryStringProperty<CarbonActivitySchema>(_entities[2].properties[22]);

  /// see [CarbonActivitySchema.kiloWatts]
  static final kiloWatts =
      QueryIntegerProperty<CarbonActivitySchema>(_entities[2].properties[23]);
}
