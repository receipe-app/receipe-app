import 'package:hive/hive.dart';
import 'package:receipe_app/data/model/recipe/comment.dart';
import 'package:receipe_app/data/model/recipe/ingredient.dart';
import 'package:receipe_app/data/model/recipe/instruction.dart';

part 'recipe.g.dart';

@HiveType(typeId: 0)
class Recipe extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<Ingredient> ingredients;

  @HiveField(3)
  List<Instruction> instructions;

  @HiveField(4)
  int preparationTime;

  @HiveField(5)
  int cookingTime;

  @HiveField(6)
  String cuisineType;

  @HiveField(7)
  String difficultyLevel;

  @HiveField(8)
  String imageUrl;

  @HiveField(9)
  String authorId;

  @HiveField(10)
  DateTime createdAt;

  @HiveField(11)
  List<String> likedByUserIds;

  @HiveField(12)
  List<Comment> comments;

  @HiveField(13)
  bool isSaved;

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
    this.isSaved = false,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return 'Recipe{id: $id, title: $title, ingredients: $ingredients, instructions: $instructions, preparationTime: $preparationTime, cookingTime: $cookingTime, cuisineType: $cuisineType, difficultyLevel: $difficultyLevel, imageUrl: $imageUrl, authorId: $authorId, createdAt: $createdAt, likedByUserIds: $likedByUserIds, comments: $comments, isSaved: $isSaved}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions,
      'preparationTime': preparationTime,
      'cookingTime': cookingTime,
      'cuisineType': cuisineType,
      'difficultyLevel': difficultyLevel,
      'imageUrl': imageUrl,
      'authorId': authorId,
      'createdAt': createdAt,
      'likedByUserIds': likedByUserIds,
      'comments': comments,
      'isSaved': isSaved,
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
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now()),
      likedByUserIds: json['likedByUserIds'] == null
          ? []
          : json['likedByUserIds'] as List<String>,
      comments: json['comments'] == null
          ? []
          : (json['comments'] as List<dynamic>)
              .map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList(),
      isSaved: json['isSaved'] as bool? ?? false,
    );
  }
}
