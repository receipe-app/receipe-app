import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:receipe_app/data/model/models.dart';
import 'package:receipe_app/data/service/shared_preference/user_prefs_service.dart';
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

  void _onGetUserSavedRecipes(GetUserSavedRecipesEvent event,
      Emitter<SavedRecipeState> emit,) {
    emit(const LoadingSavedRecipeState());
    try {
      // recipeBox.delete('savedRecipes');
      final List<Recipe> allSavedRecipes = recipeBox.get('savedRecipes') ?? [];
      emit(LoadedSavedRecipeState(recipes: allSavedRecipes));
    } catch (e) {
      emit(ErrorSavedRecipeState(errorMessage: e.toString()));
    }
  }

  void _onToggleSavedRecipe(
    ToggleSavedRecipeEvent event,
    Emitter<SavedRecipeState> emit,
  ) async {
    emit(const LoadingSavedRecipeState());

    try {
      final List<Recipe>? data = recipeBox.get('savedRecipes');
      if (data == null) {
        recipeBox.put('savedRecipes', [event.recipe]);
        emit(LoadedSavedRecipeState(recipes: [event.recipe]));
        return;
      }

      final int index =
          data.indexWhere((element) => element.id == event.recipe.id);

      if (index == -1) {
        data.add(event.recipe);
      } else {
        data.removeAt(index);
      }

      // final List<String> dataIdString = [];

      // for (var each in data) {
      //   dataIdString.add(each.id);
      // }
      //
      // _userRepository.updateUserData(
      //   data: {'savedRecipesId': ['12345t']},
      //   userId: await UserPrefsService.uFirebaseId ?? '',
      // );

      recipeBox.put('savedRecipes', data);
      emit(LoadedSavedRecipeState(recipes: data));
    } catch (e) {
      debugPrint(e.toString());
      emit(ErrorSavedRecipeState(errorMessage: e.toString()));
    }
  }
}
