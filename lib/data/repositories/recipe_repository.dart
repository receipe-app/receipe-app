import 'dart:io';

import 'package:receipe_app/data/service/dio/firebase_recipe_service.dart';

import '../model/recipe/ingredient.dart';
import '../model/recipe/instruction.dart';
import '../model/recipe/recipe.dart';

class RecipeRepository {
  final FirebaseRecipeService _firebaseRecipeService;

  RecipeRepository({required FirebaseRecipeService firebaseRecipeService})
      : _firebaseRecipeService = firebaseRecipeService;

  /// ADD RECIPE
  Future<Recipe> addRecipe({
    required String title,
    required List<Ingredient> ingredients,
    required List<Instruction> instructions,
    required int preparationTime, // in minutes
    required int cookingTime, // in minutes
    required String cuisineType,
    required String difficultyLevel,
    required File imageFile,
  }) async {
    return await _firebaseRecipeService.addRecipe(
      title: title,
      ingredients: ingredients,
      instructions: instructions,
      preparationTime: preparationTime,
      cookingTime: cookingTime,
      cuisineType: cuisineType,
      difficultyLevel: difficultyLevel,
      imageFile: imageFile,
    );
  }

  Future<List<Recipe>> fetchRecipes() async =>
      await _firebaseRecipeService.fetchRecipes();

  /// EDIT RECIPE
  Future<void> editRecipe({
    required String id,
    required String newTitle,
    required int newCookingTime, // in minutes
    required String newCuisineType,
    required String newDifficultyLevel,
  }) async {
    await _firebaseRecipeService.editRecipe(
      id: id,
      newTitle: newTitle,
      newCookingTime: newCookingTime,
      newCuisineType: newCuisineType,
      newDifficultyLevel: newDifficultyLevel,
    );
  }

  /// DELETE RECIPE
  Future<void> deleteRecipe({required String id}) async {
    await _firebaseRecipeService.deleteRecipe(id: id);
  }
}
