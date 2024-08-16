import 'package:hive/hive.dart';

import 'comment.dart';
import 'ingredient.dart';
import 'instruction.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  List<Ingredient> ingredients;
  @HiveField(3)
  List<Instruction> instructions;
  @HiveField(4)
  int preparationTime; // in minutes
  @HiveField(5)
  int cookingTime; // in minutes
  @HiveField(6)
  String cuisineType;
  @HiveField(7)
  String difficultyLevel;
  @HiveField(8)
  String imageUrl;
  @HiveField(9)
  String authorId; // ID of the user who created the recipe
  @HiveField(10)
  DateTime createdAt;
  @HiveField(11)
  List<String> likedByUserIds; // List of user IDs who liked the recipe
  @HiveField(12)
  List<Comment> comments; // List of comments

  Recipe({
    required this.id,
    required this.title,
    this.ingredients = const [],
    this.instructions = const [],
    this.preparationTime = 0,
    this.cookingTime = 0,
    this.cuisineType = '',
    this.difficultyLevel = '',
    this.imageUrl = '',
    required this.authorId,
    DateTime? createdAt,
    this.likedByUserIds = const [],
    this.comments = const [],
  }) : createdAt = createdAt ?? DateTime.now();

  Recipe copyWith({
    String? id,
    String? title,
    List<Ingredient>? ingredients,
    List<Instruction>? instructions,
    int? preparationTime,
    int? cookingTime,
    String? cuisineType,
    String? difficultyLevel,
    String? imageUrl,
    String? authorId,
    DateTime? createdAt,
    List<String>? likedByUserIds,
    List<Comment>? comments,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      preparationTime: preparationTime ?? this.preparationTime,
      cookingTime: cookingTime ?? this.cookingTime,
      cuisineType: cuisineType ?? this.cuisineType,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      imageUrl: imageUrl ?? this.imageUrl,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      likedByUserIds: likedByUserIds ?? this.likedByUserIds,
      comments: comments ?? this.comments,
    );
  }

  @override
  String toString() {
    return 'Recipe{id: $id, title: $title, ingredients: $ingredients, instructions: $instructions, preparationTime: $preparationTime, cookingTime: $cookingTime, cuisineType: $cuisineType, difficultyLevel: $difficultyLevel, imageUrl: $imageUrl, authorId: $authorId, createdAt: $createdAt, likedByUserIds: $likedByUserIds, comments: $comments}';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions,
      'preparationTime': preparationTime,
      'cookingTime': cookingTime,
      'cuisineType': cuisineType,
      'difficultyLevel': difficultyLevel,
      'imageUrl': imageUrl,
      'authorId': authorId,
      'createdAt': createdAt.toIso8601String(),
      'likedByUserIds': likedByUserIds,
      'comments': comments,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
      ingredients: json['ingredients'] == null
          ? []
          : (json['ingredients'] as List<dynamic>)
              .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList(),
      instructions: json['instructions'] == null
          ? []
          : (json['instructions'] as List<dynamic>)
              .map((e) => Instruction.fromJson(e as Map<String, dynamic>))
              .toList(),
      preparationTime: json['preparationTime'] as int,
      cookingTime: json['cookingTime'] as int,
      cuisineType: json['cuisineType'] as String,
      difficultyLevel: json['difficultyLevel'] as String,
      imageUrl: json['imageUrl'] as String,
      authorId: json['authorId'] as String,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      likedByUserIds: json['likedByUserIds'] == null
          ? []
          : (json['likedByUserIds'] as List<dynamic>).cast<String>(),
      comments: json['comments'] == null
          ? []
          : (json['comments'] as List<dynamic>)
              .map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
