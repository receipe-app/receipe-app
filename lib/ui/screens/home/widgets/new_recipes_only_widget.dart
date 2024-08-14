import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';
import 'package:receipe_app/ui/screens/all_about_recipe/all_about_recipe_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NewRecipesOnlyWidget extends StatefulWidget {
  final List<Recipe> recipes;
  const NewRecipesOnlyWidget({super.key, required this.recipes});

  @override
  State<NewRecipesOnlyWidget> createState() => _NewRecipesOnlyWidgetState();
}

class _NewRecipesOnlyWidgetState extends State<NewRecipesOnlyWidget> {
  late List<Recipe> _filteredNewRecipes;

  @override
  void initState() {
    super.initState();

    final DateTime now = DateTime.now();
    final DateTime threeDaysAgo = now.subtract(const Duration(days: 3));

    _filteredNewRecipes = widget.recipes.where((recipe) {
      return recipe.createdAt.isAfter(threeDaysAgo) &&
          recipe.createdAt.isBefore(now);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: _filteredNewRecipes.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 20.0),
        itemBuilder: (context, index) {
          final recipe = _filteredNewRecipes[index];
          return ZoomTapAnimation(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    AllAboutRecipeScreen(recipe: _filteredNewRecipes[index]),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  width: 300,
                  height: 120,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Text(
                                recipe.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.teal,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "By James Milner",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "${recipe.cookingTime} mins",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height: 100,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      recipe.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
