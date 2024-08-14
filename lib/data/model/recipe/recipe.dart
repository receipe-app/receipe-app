import 'comment.dart';
import 'ingredient.dart';
import 'instruction.dart';

class Recipe {
  String id;
  String title;
  List<Ingredient> ingredients;
  List<Instruction> instructions;
  int preparationTime; // in minutes
  int cookingTime; // in minutes
  String cuisineType;
  String difficultyLevel;
  String imageUrl;
  String authorId; // ID of the user who created the recipe
  DateTime createdAt;
  List<String> likedByUserIds; // List of user IDs who liked the recipe
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

  @override
  String toString() {
    return 'Recipe{id: $id, title: $title, ingredients: $ingredients, instructions: $instructions, preparationTime: $preparationTime, cookingTime: $cookingTime, cuisineType: $cuisineType, difficultyLevel: $difficultyLevel, imageUrl: $imageUrl, authorId: $authorId, createdAt: $createdAt, likedByUserIds: $likedByUserIds, comments: $comments}';
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
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
      ingredients: json['ingredients'] as List<Ingredient>,
      instructions: json['instructions'] as List<Instruction>,
      preparationTime: json['preparationTime'] as int,
      cookingTime: json['cookingTime'] as int,
      cuisineType: json['cuisineType'] as String,
      difficultyLevel: json['difficultyLevel'] as String,
      imageUrl: json['imageUrl'] as String,
      authorId: json['authorId'] as String,
      createdAt: json['createdAt'] as DateTime,
      likedByUserIds: json['likedByUserIds'] as List<String>,
      comments: json['comments'] as List<Comment>,
    );
  }
}
