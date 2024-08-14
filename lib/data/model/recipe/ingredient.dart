class Ingredient {
  String name;
  double quantity;
  String unit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'quantity': this.quantity,
      'unit': this.unit,
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
