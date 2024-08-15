import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:receipe_app/core/utils/user_constants.dart';
import 'package:receipe_app/data/service/shared_preference/user_prefs_service.dart';

part 'saved_recipe_state.dart';

part 'saved_recipe_event.dart';

class SavedRecipeBloc extends Bloc<SavedRecipeEvent, SavedRecipeState> {
  SavedRecipeBloc() : super(const InitialSavedRecipeState()) {
    on<GetUserSavedRecipesEvent>(_onGetUserSavedRecipes);
    on<ToggleSavedRecipeEvent>(_onToggleSavedRecipe);
  }

  void _onGetUserSavedRecipes(
    GetUserSavedRecipesEvent event,
    Emitter<SavedRecipeState> emit,
  ) {
    emit(const LoadingSavedRecipeState());
    try {} catch (e) {
      emit(ErrorSavedRecipeState(errorMessage: e.toString()));
    }
  }

  void _onToggleSavedRecipe(
    ToggleSavedRecipeEvent event,
    Emitter<SavedRecipeState> emit,
  ) async {
    emit(const LoadingSavedRecipeState());

    try {
      if (UserConstants.savedRecipesId.isNotEmpty) {
        final int index = UserConstants.savedRecipesId.indexWhere(
          (element) => element == event.recipeId,
        );
        if (index != -1) {
          UserConstants.savedRecipesId.removeAt(index);
        } else {
          UserConstants.savedRecipesId.add(event.recipeId);
        }
      }
      UserPrefsService.setSavedRecipesId(UserConstants.savedRecipesId);

      emit(const LoadedSavedRecipeState());
    } catch (e) {
      emit(ErrorSavedRecipeState(errorMessage: e.toString()));
    }
  }
}