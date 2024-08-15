part of 'liked_recipe_bloc.dart';

@immutable
sealed class LikedRecipeEvent {
  const LikedRecipeEvent();
}

final class GetUserLikedRecipesEvent extends LikedRecipeEvent {
  const GetUserLikedRecipesEvent();
}

final class ToggleLikedRecipeEvent extends LikedRecipeEvent {
  final Recipe recipe;

  const ToggleLikedRecipeEvent({required this.recipe});
}