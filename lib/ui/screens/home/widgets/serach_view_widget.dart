import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../data/model/recipe/recipe.dart';
import '../../all_about_recipe/all_about_recipe_screen.dart';

class SearchDelegateWidget extends SearchDelegate {
  final List<Recipe> searchItems;

  SearchDelegateWidget(this.searchItems);

  @override
  Widget buildSuggestions(BuildContext context) => _buildFoundRecipes();

  @override
  Widget buildResults(BuildContext context) => _buildFoundRecipes();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Widget _buildFoundRecipes() {
    List<Recipe> suggestions = searchItems.where((item) {
      return item.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ZoomTapAnimation(
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => AllAboutRecipeScreen(
                recipe: suggestions[index],
              ),
            ),
          ),
          child: Container(
            height: 100,
            margin: const EdgeInsets.all(10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColors.primary100.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Image.network(
                  suggestions[index].imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(suggestions[index].title),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Preporation time',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      '${suggestions[index].preparationTime.toString()} minutes',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
