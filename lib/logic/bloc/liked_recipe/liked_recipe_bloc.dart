import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:receipe_app/main.dart';

import '../../../data/model/recipe/recipe.dart';
import '../../../data/repositories/user_repository.dart';

part 'liked_recipe_event.dart';

part 'liked_recipe_state.dart';

class LikedRecipeBloc extends Bloc<LikedRecipeEvent, LikedRecipeState> {
  final UserRepository _userRepository;

  LikedRecipeBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const InitialLikedRecipeState()) {
    on<GetUserLikedRecipesEvent>(_onGetUserSavedRecipes);
    on<ToggleLikedRecipeEvent>(_onToggleSavedRecipe);
  }

  void _onGetUserSavedRecipes(
    GetUserLikedRecipesEvent event,
    Emitter<LikedRecipeState> emit,
  ) {
    emit(const LoadingLikedRecipeState());
    try {
      final List<dynamic>? data = recipeBox.get('likedRecipes');
      final List<Recipe> recipes = data?.cast<Recipe>() ?? [];

      emit(LoadedLikedRecipeState(recipes: recipes));
    } catch (e) {
      emit(ErrorLikedRecipeState(errorMessage: e.toString()));
    }
  }

  void _onToggleSavedRecipe(
    ToggleLikedRecipeEvent event,
    Emitter<LikedRecipeState> emit,
  ) async {
    emit(const LoadingLikedRecipeState());

    try {
      final List<dynamic>? data = recipeBox.get('likedRecipes');
      List<Recipe> recipes = data?.cast<Recipe>() ?? [];

      final int index = recipes.indexWhere(
        (element) => element.id == event.recipe.id,
      );

      if (index == -1) {
        recipes.add(event.recipe);
      } else {
        recipes.removeAt(index);
      }

      await recipeBox.put('likedRecipes', recipes);
      emit(LoadedLikedRecipeState(recipes: recipes));
    } catch (e) {
      debugPrint("likedRecipes: ${e.toString()}");
      emit(ErrorLikedRecipeState(errorMessage: e.toString()));
    }
  }
}
