// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 1;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as String,
      title: fields[1] as String,
      ingredients: (fields[2] as List).cast<Ingredient>(),
      instructions: (fields[3] as List).cast<Instruction>(),
      preparationTime: fields[4] as int,
      cookingTime: fields[5] as int,
      cuisineType: fields[6] as String,
      difficultyLevel: fields[7] as String,
      imageUrl: fields[8] as String,
      authorId: fields[9] as String,
      createdAt: fields[10] as DateTime?,
      likedByUserIds: (fields[11] as List).cast<String>(),
      comments: (fields[12] as List).cast<Comment>(),
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.ingredients)
      ..writeByte(3)
      ..write(obj.instructions)
      ..writeByte(4)
      ..write(obj.preparationTime)
      ..writeByte(5)
      ..write(obj.cookingTime)
      ..writeByte(6)
      ..write(obj.cuisineType)
      ..writeByte(7)
      ..write(obj.difficultyLevel)
      ..writeByte(8)
      ..write(obj.imageUrl)
      ..writeByte(9)
      ..write(obj.authorId)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.likedByUserIds)
      ..writeByte(12)
      ..write(obj.comments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
