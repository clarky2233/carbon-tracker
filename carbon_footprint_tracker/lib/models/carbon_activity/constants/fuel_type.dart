import 'package:flutter/material.dart';

enum FuelType {
  electric("Battery Electric Vehicle", Icons.electric_bolt),
  petroleum("Petroleum", Icons.local_gas_station_outlined),
  diesel("Diesel", Icons.local_gas_station_outlined),
  plugInHybrid("Plug-in Hybrid Electric", Icons.ev_station_outlined),
  hybrid("Hybrid Electric Vehicle", Icons.electric_car_outlined),
  none("None", Icons.error_outline);

  final String text;
  final IconData icon;

  const FuelType(this.text, this.icon);

  static List<FuelType> options = [
    FuelType.electric,
    FuelType.petroleum,
    FuelType.diesel,
    FuelType.plugInHybrid,
    FuelType.hybrid,
  ];
}
