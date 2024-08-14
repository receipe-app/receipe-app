import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipe_app/core/utils/extensions/sizedbox_extension.dart';

import '../../data/model/models.dart';
import '../../logic/bloc/recipe/recipe_bloc.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  int _currentPage = 0;

  // Example Data Fields
  String _title = '';
  int _prepTime = 20;
  int _cookTime = 20;
  String _difficulty = 'Easy';
  String _type = 'Breakfast';
  final List<Ingredient> _ingredients = [];
  final List<String> _directions = [];

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset(
              'assets/images/add_background.svg',
              fit: BoxFit.fill,
            ),
          ),
          Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                children: [
                  /// CUSTOM APPBAR
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: const BoxDecoration(
                              color: Color(0xffD5EEEE),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: const Icon(CupertinoIcons.chevron_back),
                          ),
                        ),
                        const Text("Add recipe"),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: const Color(0xffD5EEEE),
                            borderRadius: BorderRadius.circular(11.r),
                          ),
                          alignment: Alignment.center,
                          child: Text("${_currentPage + 1}/4"),
                        ),
                      ],
                    ),
                  ),
                  40.height,

                  /// BODY
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: [
                        _buildTitleStep(),
                        _buildInformationStep(),
                        _buildIngredientsStep(),
                        _buildDirectionsStep(),
                      ],
                    ),
                  ),

                  /// BOTTOM NAVIGATION
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _currentPage > 0
                            ? GestureDetector(
                                onTap: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                                child: Container(
                                  height: 60.h,
                                  width: 60.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffD5EEEE),
                                      borderRadius:
                                          BorderRadius.circular(12.r)),
                                  alignment: Alignment.center,
                                  child:
                                      const Icon(CupertinoIcons.chevron_back),
                                ),
                              )
                            : const SizedBox(),
                        37.width,
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (_currentPage < 3) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              } else {
                                // Submit the recipe data
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  // Extract and validate ingredient data
                                  if (_ingredients.any((ingredient) =>
                                      ingredient.name.isEmpty)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please fill in all ingredient fields.')),
                                    );
                                    return;
                                  }

                                  context.read<RecipeBloc>().add(AddRecipeEvent(
                                        title: _title,
                                        ingredients: _ingredients,
                                        instructions: _directions
                                            .map((desc) => Instruction(
                                                  stepNumber: _directions
                                                          .indexOf(desc) +
                                                      1,
                                                  description: desc,
                                                ))
                                            .toList(),
                                        preparationTime: _prepTime,
                                        cookingTime: _cookTime,
                                        cuisineType: _type,
                                        difficultyLevel: _difficulty,
                                        imageFile: imageFile!,
                                      ));
                                  Navigator.pop(context);
                                  /*recipeService.addEvent(
                                    title: _title,
                                    ingredients: _ingredients,
                                    instructions: _directions.map((desc) => Instruction(
                                      stepNumber: _directions.indexOf(desc) + 1,
                                      description: desc,
                                    )).toList(),
                                    preparationTime: _prepTime,
                                    cookingTime: _cookTime,
                                    cuisineType: _type,
                                    difficultyLevel: _difficulty,
                                    imageFile: imageFile!,
                                  );*/
                                  print('Recipe Submitted');
                                }
                              }
                            },
                            child: Container(
                              height: 60.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xff3FB4B1),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                _currentPage < 3 ? 'Next' : 'Submit',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// INPUT TITLE AND IMAGE
  Widget _buildTitleStep() {
    void openGallery() async {
      final imagePicker = ImagePicker();
      final XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        requestFullMetadata: false,
      );

      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
          // print(pickedImage.path);
        });
      }
    }

    void openCamera() async {
      final imagePicker = ImagePicker();
      final XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        requestFullMetadata: false,
      );

      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
        });
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Title', style: Theme.of(context).textTheme.headlineSmall),
          25.height,
          Container(
            padding: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: const Color(0xffD5EEEE)),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: '',
                border: InputBorder.none,
              ),
              onSaved: (value) {
                _title = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
          ),
          15.height,
          imageFile == null
              ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                      color: const Color(0xffA9DDDC),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Upload your recipe photo'),
                        20.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: openCamera,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    const Icon(CupertinoIcons.camera, size: 30),
                                    6.height,
                                    const Text("From Camera"),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: openGallery,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    const Icon(Icons.image_outlined, size: 30),
                                    6.height,
                                    const Text("From Gallery"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Image.file(imageFile!, height: 200),
        ],
      ),
    );
  }

  /// INPUT TIME AND CATEGORY
  Widget _buildInformationStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Information',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24.0),
          _buildTimeInput('Preparation Time (minute)', _prepTime, (value) {
            setState(() {
              _prepTime = value;
            });
          }),
          const SizedBox(height: 16.0),
          _buildTimeInput('Cooking Time (minute)', _cookTime,
              (value) => setState(() => _cookTime = value)),
          const SizedBox(height: 16.0),

          /// DIFFICULTY
          Row(
            children: [
              const Expanded(child: Text("Difficulty")),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _difficulty,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffD5EEEE),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: ['Easy', 'Medium', 'Hard']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _difficulty = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          16.height,

          /// TYPE
          Row(
            children: [
              const Expanded(child: Text("Type")),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _type,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffD5EEEE),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: ['Breakfast', 'Lunch', 'Supper', 'Dessert']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _type = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInput(String label, int value, Function(int) onChange) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (value > 0) onChange(value - 1);
              },
              icon: const Icon(Icons.remove),
              color: Colors.black,
              padding: EdgeInsets.all(12.r),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Text(
                  '$value',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                onChange(value + 1);
              },
              icon: const Icon(Icons.add),
              color: Colors.black,
              padding: EdgeInsets.all(12.r),
            ),
          ],
        ),
      ],
    );
  }

  /// INPUT INGREDIENTS
  Widget _buildIngredientsStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24.0),
          Column(
            children: _ingredients.map((ingredient) {
              int index = _ingredients.indexOf(ingredient);
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    // Ingredient Name Input
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        initialValue: ingredient.name,
                        decoration: InputDecoration(
                          labelText: 'Ingredient ${index + 1}',
                          filled: true,
                          fillColor: Colors.blueGrey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onSaved: (value) {
                          _ingredients[index] = Ingredient(
                            name: value!,
                            quantity: _ingredients[index].quantity,
                            unit: _ingredients[index].unit,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    // Ingredient Quantity Input
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: ingredient.quantity != 0
                            ? ingredient.quantity.toString()
                            : '',
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          filled: true,
                          fillColor: Colors.blueGrey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _ingredients[index] = Ingredient(
                              name: _ingredients[index].name,
                              quantity: double.tryParse(value) ?? 0,
                              unit: _ingredients[index].unit,
                            );
                          });
                        },
                        onSaved: (value) {
                          _ingredients[index] = Ingredient(
                            name: _ingredients[index].name,
                            quantity: double.tryParse(value!) ?? 0,
                            unit: _ingredients[index].unit,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    // Ingredient Unit Dropdown
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: ingredient.unit,
                        decoration: InputDecoration(
                          labelText: 'Unit',
                          filled: true,
                          fillColor: Colors.blueGrey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: ['g', 'kg', 'ml', 'l', 'cup', 'tbsp', 'tsp']
                            .map((label) => DropdownMenuItem(
                                  value: label,
                                  child: Text(label),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _ingredients[index] = Ingredient(
                              name: _ingredients[index].name,
                              quantity: _ingredients[index].quantity,
                              unit: value!,
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _ingredients.add(Ingredient(name: '', quantity: 0, unit: 'g'));
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Ingredient'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blueGrey[50],
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              textStyle: const TextStyle(fontSize: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// INPUT DIRECTIONS
  Widget _buildDirectionsStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(
            'Directions',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: _directions.map((ingredient) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: TextFormField(
                  initialValue: ingredient,
                  decoration: InputDecoration(
                    labelText:
                        'Direction ${_directions.indexOf(ingredient) + 1}',
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (value) {
                    final index = _directions.indexOf(ingredient);
                    _directions[index] = value!;
                  },
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _directions.add('');
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Direction'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blueGrey[50],
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              textStyle: const TextStyle(fontSize: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
