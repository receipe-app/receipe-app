part of 'saved_recipe_bloc.dart';

@immutable
sealed class SavedRecipeState {
  const SavedRecipeState();
}

final class InitialSavedRecipeState extends SavedRecipeState {
  const InitialSavedRecipeState();
}

final class LoadingSavedRecipeState extends SavedRecipeState {
  const LoadingSavedRecipeState();
}

final class LoadedSavedRecipeState extends SavedRecipeState {
  // final List<String> recipesId;

  const LoadedSavedRecipeState();
  // const LoadedSavedRecipeState({required this.recipes});
}

final class ErrorSavedRecipeState extends SavedRecipeState {
  final String errorMessage;

  const ErrorSavedRecipeState({required this.errorMessage});
}
