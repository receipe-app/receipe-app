import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import 'package:receipe_app/core/utils/user_constants.dart';
import 'package:receipe_app/data/model/models.dart';
import 'package:receipe_app/logic/bloc/auth/auth_bloc.dart';
import 'package:receipe_app/logic/bloc/recipe/recipe_bloc.dart';
import 'package:receipe_app/ui/screens/all_about_recipe/all_about_recipe_screen.dart';
import 'package:receipe_app/ui/widgets/edit_recipe.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.primary100,
        actions: [
          IconButton(
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthEvent.logout()),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(UserConstants.name),
            const Text(
              'Men yaratgan retseptlar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: BlocBuilder<RecipeBloc, RecipeState>(
                builder: (context, state) {
                  if (state is LoadingRecipeState) {
                    return _buildRecipeGrid(true);
                  } else if (state is ErrorRecipeState) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is LoadedRecipeState) {
                    return _buildRecipeGrid(
                        false, _getUserRecipes(state.recipes));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeGrid(bool isLoading, [List<Recipe>? allRecipe]) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: isLoading ? 10 : allRecipe!.length,
      itemBuilder: (BuildContext context, int index) {
        if (isLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          );
        } else {
          final recipe = allRecipe![index];
          return _buildRecipeCard(recipe: recipe);
        }
      },
    );
  }

  Widget _buildRecipeCard({required Recipe recipe}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => AllAboutRecipeScreen(recipe: recipe),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.network(
                    recipe.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  const Text('By me',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.cookingTime} min',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// DELETE RECIPE BUTTON
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.warning,
                          size: 20,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Deleting ${recipe.title}"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.read<RecipeBloc>().add(
                                          DeleteRecipeEvent(id: recipe.id));
                                    },
                                    child: const Text(
                                      "Yes, delete it!",
                                      style: TextStyle(
                                        color: AppColors.warning,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style:
                                          TextStyle(color: AppColors.success),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),

                      /// EDIT RECIPE BUTTON
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: AppColors.primary100,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => EditRecipe(recipe: recipe),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Recipe> _getUserRecipes(List<Recipe> allRecipes) => allRecipes
      .where((element) => element.authorId == UserConstants.uid)
      .toList();
}
