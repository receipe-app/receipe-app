import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/data/model/models.dart';
import 'package:receipe_app/logic/bloc/liked_recipe/liked_recipe_bloc.dart';

import '../../../../core/utils/app_colors.dart';

class LikeRecipeWidget extends StatelessWidget {
  final Recipe recipe;

  const LikeRecipeWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedRecipeBloc, LikedRecipeState>(
      builder: (context, state) {
        if (state is LoadedLikedRecipeState) {
          int index =
              state.recipes.indexWhere((element) => element.id == recipe.id);
          bool isSaved = index != -1;

          return IconButton(
            onPressed: () {
              context.read<LikedRecipeBloc>().add(ToggleLikedRecipeEvent(
                    recipe: recipe,
                  ));
            },
            icon:  Icon( isSaved ? Icons.favorite :Icons.favorite_border, color: AppColors.white),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
