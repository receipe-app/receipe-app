import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipe_app/ui/screens/profile/widgets/recipe_grid.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import 'package:receipe_app/core/utils/user_constants.dart';
import 'package:receipe_app/data/model/models.dart';
import 'package:receipe_app/logic/bloc/auth/auth_bloc.dart';
import 'package:receipe_app/logic/bloc/recipe/recipe_bloc.dart';
import 'package:receipe_app/ui/screens/all_about_recipe/all_about_recipe_screen.dart';
import 'package:receipe_app/ui/widgets/edit_recipe.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nameController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? 'null';
      UserConstants.name = _nameController.text;
      UserConstants.imageUrl = prefs.getString('imageUrl') ?? 'null';
    });
  } 

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    UserConstants.name = _nameController.text;
    if (_image != null) {
      await prefs.setString('imageUrl', _image!.path);
      UserConstants.imageUrl = _image!.path;
    }
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
            icon: const Icon(
              Icons.logout,
              color: AppColors.white,
            ),
          ),
          IconButton(
            onPressed: () => _showEditProfileBottomSheet(context),
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(UserConstants.name),
            const SizedBox(height: 20),
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
                    return const RecipeGrid(isLoading: true);
                  } else if (state is ErrorRecipeState) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is LoadedRecipeState) {
                    return RecipeGrid(
                      isLoading: false,
                      allRecipe: _getUserRecipes(state.recipes),
                    );
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


  void _showEditProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            top: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [

                      CircleAvatar(
                        radius: 55,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : UserConstants.imageUrl != 'null'
                                ? FileImage(File(UserConstants.imageUrl))
                                : const AssetImage('assets/default_avatar.png')
                                    as ImageProvider,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary100,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _saveUserData();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary100,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Recipe> _getUserRecipes(List<Recipe> allRecipes) => allRecipes
      .where((element) => element.authorId == UserConstants.uid)
      .toList();
}
