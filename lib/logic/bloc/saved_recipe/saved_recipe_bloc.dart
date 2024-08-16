import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:receipe_app/data/model/models.dart';
import 'package:receipe_app/main.dart';

import '../../../data/repositories/user_repository.dart';

part 'saved_recipe_state.dart';

part 'saved_recipe_event.dart';

class SavedRecipeBloc extends Bloc<SavedRecipeEvent, SavedRecipeState> {
  final UserRepository _userRepository;

  SavedRecipeBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const InitialSavedRecipeState()) {
    on<GetUserSavedRecipesEvent>(_onGetUserSavedRecipes);
    on<ToggleSavedRecipeEvent>(_onToggleSavedRecipe);
  }

  void _onGetUserSavedRecipes(
    GetUserSavedRecipesEvent event,
    Emitter<SavedRecipeState> emit,
  ) {
    emit(const LoadingSavedRecipeState());
    try {
      final List<dynamic>? data = recipeBox.get('savedRecipes');
      final List<Recipe> recipes = data?.cast<Recipe>() ?? [];

      emit(LoadedSavedRecipeState(recipes: recipes));
    } catch (e) {
      emit(ErrorSavedRecipeState(errorMessage: e.toString()));
    }
  }

  void _onToggleSavedRecipe(ToggleSavedRecipeEvent event,
      Emitter<SavedRecipeState> emit,) async {
    emit(const LoadingSavedRecipeState());

    try {
      final List<dynamic>? data = recipeBox.get('savedRecipes');
      List<Recipe> recipes = data?.cast<Recipe>() ?? [];

      final int index = recipes.indexWhere(
        (element) => element.id == event.recipe.id,
      );

      if (index == -1) {
        recipes.add(event.recipe);
      } else {
        recipes.removeAt(index);
      }

      await recipeBox.put('savedRecipes', recipes);
      emit(LoadedSavedRecipeState(recipes: recipes));
    } catch (e) {
      debugPrint("SavedRecipeBloc: ${e.toString()}");
      emit(ErrorSavedRecipeState(errorMessage: e.toString()));
    }
  }
}
