import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'recipelocal_event.dart';
part 'recipelocal_state.dart';

class RecipelocalBloc extends Bloc<RecipelocalEvent, RecipelocalState> {
  final Box<Recipe> _savedRecipesBox;

  RecipelocalBloc({
    required Box<Recipe> savedRecipesBox,
  })  : _savedRecipesBox = savedRecipesBox,
        super(InitialLocalRecipeState()) {
    on<SaveRecipeEvent>(_onSaveRecipe);
    on<GetSavedRecipesEvent>(_onGetSavedRecipes);
    on<ToggleRecipeSavedEvent>(_onToggleRecipeSaved);
  }

  Future<void> _onSaveRecipe(
      SaveRecipeEvent event, Emitter<RecipelocalState> emit) async {
    try {
      emit(RecipeLocalSavedState(recipe: event.recipe));
    } catch (e) {
      print(e.toString());
      emit(ErroLocalRecipeState(
          errorMessage: 'Failed to save recipe: ${e.toString()}'));
    }
  }

  void _onGetSavedRecipes(
      GetSavedRecipesEvent event, Emitter<RecipelocalState> emit) {
    final savedRecipes = _savedRecipesBox.values.toList();
    emit(LoadedLocalSavedRecipesState(recipes: savedRecipes));
  }

  Future<void> _onToggleRecipeSaved(
      ToggleRecipeSavedEvent event, Emitter<RecipelocalState> emit) async {
    final recipe = event.recipe;
    final sharedPreferences = await SharedPreferences.getInstance();

    try {
      List<String> savedRecipesJson =
          sharedPreferences.getStringList('savedRecipes') ?? [];
      final recipeIndex = savedRecipesJson.indexWhere((recipeJson) =>
          Recipe.fromJson(jsonDecode(recipeJson)).id == recipe.id);

      if (recipeIndex != -1) {
        // Recipe found, remove it
        emit(RecipeDeletingState());
        await Future.delayed(const Duration(milliseconds: 500));
        savedRecipesJson.removeAt(recipeIndex);
        await sharedPreferences.setStringList('savedRecipes', savedRecipesJson);
        await _savedRecipesBox.delete(recipe.id);
        emit(RecipeDeletedSuccessState(
            message: "${recipe.title} Removed from Saved Recipes!"));
      } else {
        // Recipe not found, add it
        emit(RecipeSavingState());
        await Future.delayed(const Duration(milliseconds: 500));
        savedRecipesJson.add(jsonEncode(recipe.toJson()));
        await sharedPreferences.setStringList('savedRecipes', savedRecipesJson);
        await _savedRecipesBox.put(recipe.id, recipe);
        emit(RecipeSavedSuccessState(
            message: "${recipe.title} Saved to Saved Recipes!"));
      }
    } catch (e) {
      emit(ErroLocalRecipeState(
          errorMessage: "Failed to toggle saved recipe: ${e.toString()}"));
    }
  }
}
