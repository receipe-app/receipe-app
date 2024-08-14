part of 'recipe_bloc.dart';

sealed class RecipeEvent {
  const RecipeEvent();
}

final class GetRecipesEvent extends RecipeEvent {
  const GetRecipesEvent();
}

final class AddRecipeEvent extends RecipeEvent {
  final String title;
  final List<Ingredient> ingredients;
  final List<Instruction> instructions;
  final int preparationTime;
  final int cookingTime;
  final String cuisineType;
  final String difficultyLevel;
  final File imageFile;

  const AddRecipeEvent({
    required this.title,
    required this.ingredients,
    required this.instructions,
    required this.preparationTime,
    required this.cookingTime,
    required this.cuisineType,
    required this.difficultyLevel,
    required this.imageFile,
  });
}
