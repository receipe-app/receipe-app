part of 'recipelocal_bloc.dart';

sealed class RecipelocalState {}

final class RecipeLocalSavedState extends RecipelocalState {
  final Recipe recipe;

  RecipeLocalSavedState({required this.recipe});
}

final class LoadedLocalSavedRecipesState extends RecipelocalState {
  final List<Recipe> recipes;

  LoadedLocalSavedRecipesState({required this.recipes});
}

final class ErroLocalRecipeState extends RecipelocalState {
  final String errorMessage;

  ErroLocalRecipeState({required this.errorMessage});
}

final class InitialLocalRecipeState extends RecipelocalState {}
