import 'package:hive/hive.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';

class SavedRecipesService {
  final Box<Recipe> _savedRecipesBox;

  SavedRecipesService({required Box<Recipe> savedRecipesBox})
      : _savedRecipesBox = savedRecipesBox;

  Future<void> saveRecipe(Recipe recipe) async {
    try {
      await _savedRecipesBox.put(recipe.id, recipe);
    } catch (e) {
      throw Exception('Failed to save recipe: ${e.toString()}');
    }
  }

  List<Recipe> getSavedRecipes() {
    try {
      return _savedRecipesBox.values.toList();
    } catch (e) {
      throw Exception('Failed to get saved recipes: ${e.toString()}');
    }
  }
}
