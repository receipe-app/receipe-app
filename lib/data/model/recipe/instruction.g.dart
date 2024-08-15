// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InstructionAdapter extends TypeAdapter<Instruction> {
  @override
  final int typeId = 2;

  @override
  Instruction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Instruction(
      stepNumber: fields[0] as int,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Instruction obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.stepNumber)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstructionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
