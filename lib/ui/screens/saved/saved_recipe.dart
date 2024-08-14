import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/logic/bloc/recipe/recipe_bloc.dart';

class SavedRecipes extends StatelessWidget {
  const SavedRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Recipes')),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state is LoadedSavedRecipesState) {
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
                                  offset: const Offset(2, 2),
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
                                  offset: const Offset(2, 2),
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
          } else {
            context.read<RecipeBloc>().add(GetSavedRecipesEvent());
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
