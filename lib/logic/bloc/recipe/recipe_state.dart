part of 'recipe_bloc.dart';

sealed class RecipeState {}

final class InitialRecipeState extends RecipeState {}

final class LoadingRecipeState extends RecipeState {}

final class LoadedRecipeState extends RecipeState {
  final List<Recipe> recipes;

  LoadedRecipeState({required this.recipes});
}

final class ErrorRecipeState extends RecipeState {
  final String errorMessage;

  ErrorRecipeState({required this.errorMessage});
}

final class RecipeSavedState extends RecipeState {
  final Recipe recipe;

  RecipeSavedState({required this.recipe});
}

final class LoadedSavedRecipesState extends RecipeState {
  final List<Recipe> recipes;

  LoadedSavedRecipesState({required this.recipes});
}
