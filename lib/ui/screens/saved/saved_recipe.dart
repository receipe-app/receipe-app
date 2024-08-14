import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';
import 'package:receipe_app/logic/bloc/saved_liked_local_storage/recipelocal_bloc.dart';

class SavedRecipes extends StatelessWidget {
  const SavedRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RecipelocalBloc(savedRecipesBox: Hive.box<Recipe>('savedRecipesBox'))
            ..add(GetSavedRecipesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Saved Items"),
        ),
        body: BlocBuilder<RecipelocalBloc, RecipelocalState>(
          builder: (context, state) {
            if (state is InitialLocalRecipeState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedLocalSavedRecipesState) {
              final savedRecipes = state.recipes;
              return ListView.builder(
                itemCount: savedRecipes.length,
                itemBuilder: (context, index) {
                  Recipe recipe = savedRecipes[index];
                  return ListTile(
                    leading: Image.network(recipe.imageUrl),
                    title: Text(recipe.title),
                  );
                },
              );
            } else if (state is ErroLocalRecipeState) {
              return Center(
                child: Text("Error: ${state.errorMessage}"),
              );
            } else {
              return const Center(child: Text("No Recipes saved yet"));
            }
          },
        ),
      ),
    );
  }
}
