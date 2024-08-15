part of 'liked_recipe_bloc.dart';

@immutable
sealed class LikedRecipeState {
  const LikedRecipeState();
}

final class InitialLikedRecipeState extends LikedRecipeState {
  const InitialLikedRecipeState();
}

final class LoadingLikedRecipeState extends LikedRecipeState {
  const LoadingLikedRecipeState();
}

final class LoadedLikedRecipeState extends LikedRecipeState {
  final List<Recipe> recipes;

  const LoadedLikedRecipeState({required this.recipes});
}

final class ErrorLikedRecipeState extends LikedRecipeState {
  final String errorMessage;

  const ErrorLikedRecipeState({required this.errorMessage});
}
