import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:receipe_app/data/repositories/recipe_repository.dart';

import '../../../data/model/recipe/ingredient.dart';
import '../../../data/model/recipe/instruction.dart';
import '../../../data/model/recipe/recipe.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository _recipeRepository;

  RecipeBloc({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository,
        super(InitialRecipeState()) {}

  void _addEvent(
    AddRecipeEvent event,
    Emitter<RecipeState> emit,
  ) async {
    List<Recipe> existingRecipes = [];
    if (state is LoadedRecipeState) {
      existingRecipes = (state as LoadedRecipeState).recipes;
    }
    emit(LoadingRecipeState());
    try {
      final newRecipe = await _recipeRepository.addRecipe(
        title: event.title,
        ingredients: event.ingredients,
        instructions: event.instructions,
        preparationTime: event.preparationTime,
        cookingTime: event.cookingTime,
        cuisineType: event.cuisineType,
        difficultyLevel: event.difficultyLevel,
        imageFile: event.imageFile,
      );
      existingRecipes.add(newRecipe);
      emit(LoadedRecipeState(recipes: existingRecipes));
    } catch (e) {
      emit(ErrorRecipeState(errorMessage: e.toString()));
    }
  }
}
