import 'package:flutter/material.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';
import 'package:receipe_app/ui/screens/profile/widgets/recipe_card.dart';
import 'package:receipe_app/ui/screens/profile/widgets/shimmer_card.dart';

class RecipeGrid extends StatelessWidget {
  final bool isLoading;
  final List<Recipe>? allRecipe;

  const RecipeGrid({super.key, required this.isLoading, this.allRecipe});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: isLoading ? 10 : allRecipe!.length,
      itemBuilder: (BuildContext context, int index) {
        if (isLoading) {
          return const ShimmerCard();
        } else {
          final recipe = allRecipe![index];
          return RecipeCard(recipe: recipe);
        }
      },
    );
  }
}
