import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:receipe_app/data/repositories/recipe_repository.dart';
import 'package:receipe_app/data/model/recipe/ingredient.dart';
import 'package:receipe_app/data/model/recipe/instruction.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository _recipeRepository;
  final Box<Recipe> _savedRecipesBox;

  RecipeBloc({
    required RecipeRepository recipeRepository,
    required Box<Recipe> savedRecipesBox,
  })  : _recipeRepository = recipeRepository,
        _savedRecipesBox = savedRecipesBox,
        super(InitialRecipeState()) {
    on<AddRecipeEvent>(_addEvent);
    on<GetRecipesEvent>(_onGetRecipe);
    on<SaveRecipeEvent>(_onSaveRecipe);
    on<GetSavedRecipesEvent>(_onGetSavedRecipes);
  }

  void _addEvent(AddRecipeEvent event, Emitter<RecipeState> emit) async {
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

  void _onGetRecipe(GetRecipesEvent event, Emitter<RecipeState> emit) async {
    emit(LoadingRecipeState());
    try {
      emit(LoadedRecipeState(recipes: await _recipeRepository.fetchRecipes()));
    } catch (e) {
      emit(ErrorRecipeState(errorMessage: e.toString()));
    }
  }

  void _onSaveRecipe(SaveRecipeEvent event, Emitter<RecipeState> emit) async {
    try {
      await _savedRecipesBox.put(event.recipe.id, event.recipe);
      emit(RecipeSavedState(recipe: event.recipe));
    } catch (e) {
      emit(ErrorRecipeState(
          errorMessage: 'Failed to save recipe: ${e.toString()}'));
    }
  }

  void _onGetSavedRecipes(
      GetSavedRecipesEvent event, Emitter<RecipeState> emit) {
    final savedRecipes = _savedRecipesBox.values.toList();
    emit(LoadedSavedRecipesState(recipes: savedRecipes));
  }
}
