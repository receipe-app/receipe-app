// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:receipe_app/data/model/recipe/recipe.dart';
// import 'package:receipe_app/logic/bloc/recipe/recipe_bloc.dart';

// part 'recipelocal_event.dart';
// part 'recipelocal_state.dart';

// class RecipelocalBloc extends Bloc<RecipelocalEvent, RecipeState> {
//   final Box<Recipe> _savedRecipesBox;

//   RecipelocalBloc({
//     required Box<Recipe> savedRecipesBox,
//   })  : _savedRecipesBox = savedRecipesBox,
//         super(InitialRecipeState()) {
//     on<SaveRecipeEvent>(_onSaveRecipe);
//     on<GetSavedRecipesEvent>(_onGetSavedRecipes);
//   }

//   Future<void> _onSaveRecipe(
//       SaveRecipeEvent event, Emitter<RecipeState> emit) async {
//     try {
//       await _savedRecipesBox.put(event.recipe.id, event.recipe);
//       emit(RecipeSavedState(recipe: event.recipe) as RecipeState);
//     } catch (e) {
//       print(e.toString());
//       emit(ErrorRecipeState(
//               errorMessage: 'Failed to save recipe: ${e.toString()}')
//           as RecipeState);
//     }
//   }

//   void _onGetSavedRecipes(
//       GetSavedRecipesEvent event, Emitter<RecipeState> emit) {
//     final savedRecipes = _savedRecipesBox.values.toList();
//     emit(LoadedSavedRecipesState(recipes: savedRecipes) as RecipeState);
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';

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
  }

  Future<void> _onSaveRecipe(
      SaveRecipeEvent event, Emitter<RecipelocalState> emit) async {
    try {
      await _savedRecipesBox.put(event.recipe.id, event.recipe);
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
}
