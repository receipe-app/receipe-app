import 'package:hive_flutter/adapters.dart';

part 'ingredient.g.dart';

@HiveType(typeId: 4)
class Ingredient {
  @HiveField(0)
  String name;
  @HiveField(1)
  double quantity;
  @HiveField(2)
  String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] as String,
      quantity: json['quantity'] as double,
      unit: json['unit'] as String,
    );
  }

  @override
  String toString() {
    return 'Ingredient{name: $name, quantity: $quantity, unit: $unit}';
  }
}
