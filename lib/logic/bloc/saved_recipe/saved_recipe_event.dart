part of 'saved_recipe_bloc.dart';

@immutable
sealed class SavedRecipeEvent {
  const SavedRecipeEvent();
}

final class GetUserSavedRecipesEvent extends SavedRecipeEvent {
  const GetUserSavedRecipesEvent();
}

final class ToggleSavedRecipeEvent extends SavedRecipeEvent {
  final Recipe recipe;

  const ToggleSavedRecipeEvent({required this.recipe});
}