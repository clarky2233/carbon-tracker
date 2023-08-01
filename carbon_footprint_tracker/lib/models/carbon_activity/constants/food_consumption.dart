import 'package:flutter/material.dart';

enum FoodConsumption {
  highMeat("High Meat", "Over 100 grams of meat", Icons.lunch_dining),
  mediumMeat("Medium Meat", "Between 50-99 grams of meat", Icons.lunch_dining),
  lowMeat("Low Meat", "Less than 50 grams of meat", Icons.lunch_dining),
  pescatarian("Pescatarian", "Fish is included in your diet but no other meats", Icons.set_meal),
  vegetarian("Vegetarian", "No meats", Icons.eco),
  vegan("Vegan", "No meats or animal products", Icons.eco);

  final String text;
  final String description;
  final IconData icon;

  const FoodConsumption(this.text, this.description, this.icon);
}
