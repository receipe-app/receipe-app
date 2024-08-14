import 'package:flutter/material.dart';
import 'package:receipe_app/ui/screens/home/widgets/category_item_widget.dart';

import '../../../../data/model/recipe/recipe.dart';
import 'recipe_item_widget.dart';

class AllRecipesWidget extends StatefulWidget {
  final List<Recipe> recipes;
  const AllRecipesWidget({super.key, required this.recipes});

  @override
  State<AllRecipesWidget> createState() => _AllRecipesWidgetState();
}

class _AllRecipesWidgetState extends State<AllRecipesWidget> {
  late List<Recipe> _filteredRecipes;
  int _tappedIndex = 0;

  final List<String> _categoryNames = [
    'Barchasi',
    'Ertalabki nonushta',
    'Tushlik',
    'Kechki nonushta',
    'Desert',
  ];

  final List<String> _categoryNamesEn = [
    'all',
    'breakfast',
    'lunch',
    'supper',
    'dessert',
  ];

  @override
  void initState() {
    super.initState();
    _filteredRecipes = widget.recipes;
  }

  void _filterRecipesByName(int index) {
    _tappedIndex = index;
    if (index == 0) {
      _filteredRecipes = widget.recipes;
    } else {
      _filteredRecipes = widget.recipes
          .where((element) =>
              element.cuisineType.toLowerCase() ==
              _categoryNamesEn[_tappedIndex].toLowerCase())
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(height: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _categoryNames.length,
            itemBuilder: (context, index) {
              return CategoryItemWidget(
                isTapped: _tappedIndex == index,
                categoryName: _categoryNames[index],
                onTap: () => _filterRecipesByName(index),
              );
            },
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: _filteredRecipes.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 20.0),
            itemBuilder: (context, index) {
              final recipe = _filteredRecipes[index];
              return RecipeItemWidget(recipe: recipe, index: index);
            },
          ),
        ),
      ],
    );
  }
}
