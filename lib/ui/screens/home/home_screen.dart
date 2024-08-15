import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import 'package:receipe_app/core/utils/app_icons.dart';
import 'package:receipe_app/core/utils/user_constants.dart';
import 'package:receipe_app/logic/bloc/liked_recipe/liked_recipe_bloc.dart';
import 'package:receipe_app/ui/screens/home/widgets/all_recipes_widget.dart';
import 'package:receipe_app/ui/screens/home/widgets/new_recipes_only_widget.dart';

import '../../../logic/bloc/recipe/recipe_bloc.dart';
import '../../../logic/bloc/saved_recipe/saved_recipe_bloc.dart';
import 'widgets/serach_view_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeBloc>().add(const GetRecipesEvent());
    context.read<LikedRecipeBloc>().add(const GetUserLikedRecipesEvent());
    context.read<SavedRecipeBloc>().add(const GetUserSavedRecipesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async =>
            context.read<RecipeBloc>().add(const GetRecipesEvent()),
        child: ListView(
          children: [
            _buildAppBar(),
            const SizedBox(height: 15),
            _buildSearchFilterField(),
            const SizedBox(height: 20),
            BlocBuilder<RecipeBloc, RecipeState>(
              bloc: context.read<RecipeBloc>()..add(const GetRecipesEvent()),
              builder: (context, state) {
                if (state is LoadingRecipeState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ErrorRecipeState) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is LoadedRecipeState) {
                  return AllRecipesWidget(recipes: state.recipes);
                }
                return const SizedBox.shrink();
              },
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'New Recipes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            BlocBuilder<RecipeBloc, RecipeState>(
              builder: (context, state) {
                if (state is LoadingRecipeState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ErrorRecipeState) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is LoadedRecipeState) {
                  return NewRecipesOnlyWidget(recipes: state.recipes);
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Salom, ${UserConstants.name}!",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            Text(
              'Bugun nima tayyorlamoqchisiz?',
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );

  Widget _buildSearchFilterField() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: state is LoadedRecipeState
                  ? () => showSearch(
                        context: context,
                        delegate: SearchDelegateWidget(state.recipes),
                      )
                  : null,
              child: Container(
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: state is LoadedRecipeState
                        ? AppColors.primary100
                        : Colors.grey,
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.searchInactive,
                      colorFilter: ColorFilter.mode(
                        state is LoadedRecipeState
                            ? AppColors.primary100
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Retsept qidirish',
                      style: TextStyle(
                        color: state is LoadedRecipeState
                            ? AppColors.primary100
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
