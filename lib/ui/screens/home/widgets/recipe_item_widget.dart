import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:receipe_app/core/utils/app_icons.dart';
import 'package:receipe_app/data/model/recipe/recipe.dart';
import 'package:receipe_app/logic/bloc/saved_liked_local_storage/recipelocal_bloc.dart';

class RecipeItemWidget extends StatelessWidget {
  final int index;
  final Recipe recipe;

  const RecipeItemWidget({
    Key? key,
    required this.recipe,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RecipelocalBloc(savedRecipesBox: Hive.box<Recipe>('savedRecipesBox'))
            ..add(GetSavedRecipesEvent()),
      child: Stack(
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
                    recipe.title,
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
                            "${recipe.cookingTime} Mins",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<RecipelocalBloc, RecipelocalState>(
                        builder: (context, state) {
                          bool isSaved = false;
                          if (state is LoadedLocalSavedRecipesState) {
                            isSaved = state.recipes.any(
                              (savedRecipe) => savedRecipe.id == recipe.id,
                            );
                          }

                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<RecipelocalBloc>()
                                  .add(ToggleRecipeSavedEvent(recipe));
                            },
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
                          );
                        },
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
          ),
        ],
      ),
    );
  }
}
