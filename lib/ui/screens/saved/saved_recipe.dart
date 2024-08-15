import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/data/model/models.dart';
import 'package:receipe_app/logic/bloc/liked_recipe/liked_recipe_bloc.dart';
import 'package:receipe_app/logic/bloc/saved_recipe/saved_recipe_bloc.dart';

import '../../../core/utils/app_colors.dart';
import '../all_about_recipe/all_about_recipe_screen.dart';

class SavedRecipes extends StatefulWidget {
  final bool isSavedScreen;

  const SavedRecipes({super.key, required this.isSavedScreen});

  @override
  State<SavedRecipes> createState() => _SavedRecipesState();
}

class _SavedRecipesState extends State<SavedRecipes> {
  @override
  void initState() {
    super.initState();
    context.read<SavedRecipeBloc>().add(const GetUserSavedRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSavedScreen ? "Saved recipes" : 'Liked recipes'),
        backgroundColor: AppColors.primary60,
      ),
      body: widget.isSavedScreen
          ? BlocBuilder<SavedRecipeBloc, SavedRecipeState>(
              builder: (context, state) {
                if (state is LoadedSavedRecipeState) {
                  return _listViewWidget(state.recipes);
                }
                return const SizedBox.shrink();
              },
            )
          : BlocBuilder<LikedRecipeBloc, LikedRecipeState>(
              builder: (context, state) {
                if (state is LoadedLikedRecipeState) {
                  return _listViewWidget(state.recipes);
                }
                return const SizedBox.shrink();
              },
            ),
    );
  }

  Widget _listViewWidget(List<Recipe> recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => AllAboutRecipeScreen(recipe: recipe),
            ),
          ),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.network(
                        recipe.imageUrl,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.network(
                          'https://media.istockphoto.com/id/827247322/vector/danger-sign-vector-icon-attention-caution-illustration-business-concept-simple-flat-pictogram.jpg?s=612x612&w=0&k=20&c=BvyScQEVAM94DrdKVybDKc_s0FBxgYbu-Iv6u7yddbs=',
                        ),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recipe.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${recipe.cookingTime} min',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () => widget.isSavedScreen
                                ? context
                                    .read<SavedRecipeBloc>()
                                    .add(ToggleSavedRecipeEvent(recipe: recipe))
                                : context.read<LikedRecipeBloc>().add(
                                    ToggleLikedRecipeEvent(recipe: recipe)),
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.warning,
                            ),
                          ),
                        ],
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
}
