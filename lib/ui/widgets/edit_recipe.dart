import 'package:flutter/material.dart';

import '../../data/model/recipe/recipe.dart';

class EditRecipe extends StatefulWidget {
  const EditRecipe({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  @override
  Widget build(BuildContext context) {
    print(widget.recipe);
    return Scaffold(
      backgroundColor: const Color(0xffFCFCF7),
      appBar: AppBar(
        backgroundColor: const Color(0xffFCFCF7),
        title: const Text('Edit Recipe'),
      ),
      body: Column(

      ),
    );
  }
}
