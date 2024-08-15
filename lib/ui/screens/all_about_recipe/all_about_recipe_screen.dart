import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';
import 'package:receipe_app/ui/screens/all_about_recipe/widgets/like_recipe_widget.dart';
import 'package:share_plus/share_plus.dart';

class AllAboutRecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const AllAboutRecipeScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black54, Colors.transparent],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          LikeRecipeWidget(recipe: recipe),
          IconButton(
            onPressed: () {
              _shareRecipe(recipe);
            },
            icon: const Icon(
              CupertinoIcons.share,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'recipeImage${recipe.id}',
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(recipe.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        recipe.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCookingTimeWidget(),
                  const SizedBox(height: 20),
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildIngredientsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareRecipe(Recipe recipe) {
    String recipeDetails = _formatRecipeForSharing(recipe);
    Share.share(recipeDetails, subject: "Watch this Recipe ");
  }

  String _formatRecipeForSharing(Recipe recipe) {
    StringBuffer buffer = StringBuffer();

    buffer.writeln("Recipe ${recipe.title}");
    buffer.writeln("Cooking Time ${recipe.preparationTime} minutes");
    buffer.writeln("Cooling time 2 ${recipe.cookingTime} minutes");
    buffer.writeln("🌍 Oshxona turi: ${recipe.cuisineType}");
    buffer.writeln("⚙️ Qiyinchilik darajasi: ${recipe.difficultyLevel}");
    buffer.writeln("\n📝 Ingredientlar:");

    for (var ingredients in recipe.ingredients) {
      buffer.writeln("-${ingredients.name}: ${ingredients.quantity}");
    }

    buffer.writeln("Created Ad ${recipe.createdAt}");
    buffer.write("Liked by users ${recipe.likedByUserIds}");

    return buffer.toString();
  }

  Widget _buildCookingTimeWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time, color: AppColors.success),
          const SizedBox(width: 8),
          Text(
            '${recipe.cookingTime} mins',
            style: const TextStyle(
              color: AppColors.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipe.ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = recipe.ingredients[index];
        return ListTile(
          leading: const Icon(Icons.fiber_manual_record, size: 12),
          title: Text(ingredient.name),
          trailing: Text(
            ingredient.unit,
            style: const TextStyle(color: AppColors.gray3),
          ),
        );
      },
    );
  }
}
