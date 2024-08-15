import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:receipe_app/core/utils/app_icons.dart';
import 'package:receipe_app/core/utils/user_constants.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';
import 'package:receipe_app/logic/bloc/saved_recipe/saved_recipe_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeItemWidget extends StatefulWidget {
  final Recipe recipe;

  const RecipeItemWidget({
    super.key,
    required this.recipe,
  });

  @override
  State<RecipeItemWidget> createState() => _RecipeItemWidgetState();
}

class _RecipeItemWidgetState extends State<RecipeItemWidget> {
  void _onSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> box = prefs.getStringList('savedRecipesId') ?? [];

    final index = box.indexWhere((element) => element == widget.recipe.id);
    if (index != -1) {
      box.removeAt(index);
    } else {
      box.add(widget.recipe.id);
    }
    prefs.setStringList('savedRecipesId', box);
    UserConstants.savedRecipesId = box;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isSaved = false;

    print('WIDGET_RECIPE ${widget.recipe.id}');
    print("USER_CONSTANTS_SAVED: ${UserConstants.savedRecipesId}");
    print('---------------------------------------------------------');

    for (var each in UserConstants.savedRecipesId) {
      if (each == widget.recipe.id) {
        isSaved = true;
        break;
      }
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 80),
          width: 150,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xffD9D9D9).withOpacity(0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  widget.recipe.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Time",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${widget.recipe.cookingTime} min",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: _onSave,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          isSaved
                              ? AppIcons.bookmarksActive
                              : AppIcons.bookmarksInactive,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: Container(
            height: 110,
            width: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                widget.recipe.imageUrl,
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
        ),
      ],
    );
  }

// void test() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   print(preferences.getStringList('savedRecipesId'));
//   print('--------------------------------------------------');
// }
}
