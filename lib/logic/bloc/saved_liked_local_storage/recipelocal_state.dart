part of 'recipelocal_bloc.dart';

sealed class RecipelocalState {}

class RecipeLocalSavedState extends RecipelocalState {
  final Recipe recipe;
  RecipeLocalSavedState({required this.recipe});
}

class LoadedLocalSavedRecipesState extends RecipelocalState {
  final List<Recipe> recipes;
  LoadedLocalSavedRecipesState({required this.recipes});
}

class ErroLocalRecipeState extends RecipelocalState {
  final String errorMessage;
  ErroLocalRecipeState({required this.errorMessage});
}

class InitialLocalRecipeState extends RecipelocalState {}

class RecipeSavingState extends RecipelocalState {}

class RecipeSavedSuccessState extends RecipelocalState {
  final String message;
  RecipeSavedSuccessState({required this.message});
} 

class RecipeDeletingState extends RecipelocalState {}

class RecipeDeletedSuccessState extends RecipelocalState {
  final String message;
  RecipeDeletedSuccessState({required this.message});
}
