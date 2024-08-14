import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import 'package:receipe_app/core/utils/app_icons.dart';
import 'package:receipe_app/core/utils/device_screen.dart';
import 'package:receipe_app/core/utils/user_constants.dart';
import 'package:receipe_app/ui/screens/home/widgets/all_recipes_widget.dart';

import '../../../logic/bloc/recipe/recipe_bloc.dart';
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

            // BlocBuilder<RecipeBloc, RecipeState>(
            //   builder: (context, state) {
            //     if (state is LoadingRecipeState) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (state is ErrorRecipeState) {
            //       return Center(child: Text(state.errorMessage));
            //     } else if (state is LoadedRecipeState) {
            //       return SizedBox(
            //         height: 280,
            //         child: ListView.separated(
            //           padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //           itemCount: state.recipes.length,
            //           scrollDirection: Axis.horizontal,
            //           separatorBuilder: (context, index) =>
            //               const SizedBox(height: 20.0),
            //           itemBuilder: (context, index) {
            //             final recipe = state.recipes[index];
            //             return RecipeItemWidget(recipe: recipe, index: index);
            //           },
            //         ),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => showSearch(
                context: context,
                delegate: SearchDelegateWidget([
                  'item1',
                  'item2',
                  'item3',
                  'item4',
                  'item5',
                  'item6',
                  'item7',
                  'item8',
                  'item9',
                ]),
              ),
              child: Container(
                width: DeviceScreen.w(context) / 1.5,
                height: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.searchInactive,
                      colorFilter: const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Retsept qidirish',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.primary100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.filter_9_plus,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
