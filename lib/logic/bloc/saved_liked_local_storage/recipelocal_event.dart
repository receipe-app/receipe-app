part of "recipelocal_bloc.dart";

sealed class RecipelocalEvent {
  const RecipelocalEvent();
}

final class SaveRecipeEvent extends RecipelocalEvent {
  final Recipe recipe;

  const SaveRecipeEvent(this.recipe);
}

final class GetSavedRecipesEvent extends RecipelocalEvent {}
