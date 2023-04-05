import 'package:flutter/material.dart';

enum FoodConsumption {
  highMeat("High Meat", "Description", Icons.lunch_dining),
  mediumMeat("Medium Meat", "Description", Icons.lunch_dining),
  lowMeat("Low Meat", "Description", Icons.lunch_dining),
  pescatarian("Pescatarian", "Description", Icons.set_meal),
  vegetarian("Vegetarian", "Description", Icons.eco),
  vegan("Vegan", "Description", Icons.eco);

  final String text;
  final String description;
  final IconData icon;

  const FoodConsumption(this.text, this.description, this.icon);
}
