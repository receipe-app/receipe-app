import 'package:flutter/material.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';

class AllAboutRecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const AllAboutRecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
        ],
      ),
      body: Column(
        children: [Text(recipe.title)],
      ),
    );
  }
}
