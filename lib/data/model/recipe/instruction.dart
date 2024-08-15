import 'package:hive_flutter/adapters.dart';
part 'instruction.g.dart';

@HiveType(typeId: 2)
class Instruction {
  @HiveField(0)
  int stepNumber;
  @HiveField(1)
  String description;

  Instruction({
    required this.stepNumber,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'stepNumber': stepNumber,
      'description': description,
    };
  }

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      stepNumber: json['stepNumber'] as int,
      description: json['description'] as String,
    );
  }

  @override
  String toString() {
    return 'Instruction{stepNumber: $stepNumber, description: $description}';
  }
}
