import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/logic/bloc/saved_liked_local_storage/recipelocal_bloc.dart';

class SavedRecipes extends StatelessWidget {
  const SavedRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Recipes')),
      body: BlocBuilder<RecipelocalBloc, RecipelocalState>(
        builder: (context, state) {
          if (state is LoadedLocalSavedRecipesState) {
            if (state.recipes.isEmpty) {
              return const Center(child: Text('No saved recipes'));
            } else {
              return ListView.builder(
                itemCount: state.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = state.recipes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(recipe.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.7),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${recipe.cookingTime} mins",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.7),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is RecipelocalState ||
              state is ErroLocalRecipeState) {
            // Make sure to handle these states appropriately if needed
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErroLocalRecipeState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            // Handle unexpected states
            return const Center(child: Text('Unexpected State'));
          }
        },
      ),
    );
  }
}
