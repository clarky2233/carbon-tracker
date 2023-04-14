import 'package:carbon_footprint_tracker/models/carbon_activity/constants/fuel_type.dart';
import 'package:carbon_footprint_tracker/models/carbon_activity/constants/vehicle_size.dart';
import 'package:flutter/material.dart';

enum TransportMode {
  car(
    icon: Icons.directions_car,
    iconOutlined: Icons.directions_car_outlined,
    defaultFuelType: FuelType.petroleum,
    defaultVehicleSize: VehicleSize.medium,
  ),
  bus(
    icon: Icons.directions_bus,
    iconOutlined: Icons.directions_bus_outlined,
    defaultFuelType: FuelType.diesel,
  ),
  train(
    icon: Icons.directions_subway,
    iconOutlined: Icons.directions_subway_outlined,
  ),
  motorbike(
    icon: Icons.motorcycle,
    iconOutlined: Icons.motorcycle_outlined,
    defaultVehicleSize: VehicleSize.medium,
  ),
  walking(
    icon: Icons.directions_walk,
    iconOutlined: Icons.directions_walk_outlined,
  ),
  cycling(
    icon: Icons.directions_bike,
    iconOutlined: Icons.directions_bike_outlined,
  ),
  flying(
    icon: Icons.airplanemode_active,
    iconOutlined: Icons.airplanemode_active_outlined,
  );

  final IconData icon;
  final IconData iconOutlined;
  final FuelType defaultFuelType;
  final VehicleSize defaultVehicleSize;

  static List<TransportMode> groundVehicles = const [
    car,
    bus,
    train,
    motorbike,
    walking,
    cycling,
  ];

  const TransportMode({
    required this.icon,
    required this.iconOutlined,
    this.defaultFuelType = FuelType.none,
    this.defaultVehicleSize = VehicleSize.none,
  });
}
