part of 'saved_recipe_bloc.dart';

@immutable
sealed class SavedRecipeEvent {
  const SavedRecipeEvent();
}

final class GetUserSavedRecipesEvent extends SavedRecipeEvent {
  const GetUserSavedRecipesEvent();
}

final class ToggleSavedRecipeEvent extends SavedRecipeEvent {
  final String recipeId;
  final bool isSaved;

  const ToggleSavedRecipeEvent({
    required this.isSaved,
    required this.recipeId,
  });
}