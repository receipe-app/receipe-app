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
      final recipes = await _recipeRepository.fetchRecipes();
      emit(LoadedRecipeState(recipes: recipes));
    } catch (e) {
      emit(ErrorRecipeState(errorMessage: e.toString()));
    }
  }
}
