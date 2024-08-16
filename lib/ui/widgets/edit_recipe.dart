import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/logic/bloc/blocs.dart';
import '../../data/model/recipe/recipe.dart';

class EditRecipeScreen extends StatefulWidget {
  const EditRecipeScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _cookingTimeController;
  late String _selectedCuisineType;
  late String _selectedDifficultyLevel;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.recipe.title);
    _cookingTimeController =
        TextEditingController(text: widget.recipe.cookingTime.toString());

    _selectedCuisineType = widget.recipe.cuisineType.isNotEmpty &&
            ['Breakfast', 'Lunch', 'Supper', 'Dessert']
                .contains(widget.recipe.cuisineType)
        ? widget.recipe.cuisineType
        : 'Breakfast';

    _selectedDifficultyLevel = widget.recipe.difficultyLevel.isNotEmpty &&
            ['Easy', 'Medium', 'Hard'].contains(widget.recipe.difficultyLevel)
        ? widget.recipe.difficultyLevel
        : 'Easy';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _cookingTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCFCF7),
      appBar: AppBar(
        backgroundColor: const Color(0xffFCFCF7),
        title: const Text('Edit Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildCustomTextField(
                controller: _titleController,
                label: 'Title',
                icon: Icons.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              _buildCustomTextField(
                controller: _cookingTimeController,
                label: 'Cooking Time (minutes)',
                icon: Icons.timer,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cooking time';
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 0) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              _buildDropdownField(
                value: _selectedCuisineType,
                label: 'Cuisine Type',
                icon: Icons.restaurant,
                items: ['Breakfast', 'Lunch', 'Supper', 'Dessert'],
                onChanged: (value) {
                  setState(() {
                    _selectedCuisineType = value!;
                  });
                },
              ),
              _buildDropdownField(
                value: _selectedDifficultyLevel,
                label: 'Difficulty Level',
                icon: Icons.emoji_events,
                items: ['Easy', 'Medium', 'Hard'],
                onChanged: (value) {
                  setState(() {
                    _selectedDifficultyLevel = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newData = widget.recipe.copyWith(
                        title: _titleController.text,
                        cookingTime: int.parse(_cookingTimeController.text),
                        cuisineType: _selectedCuisineType,
                        difficultyLevel: _selectedDifficultyLevel);
                    context.read<RecipeBloc>().add(
                          EditRecipe(recipe: newData),
                        );
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Custom TextField Widget
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xff5A5A5A)),
          filled: true,
          fillColor: const Color(0xffF0F0F0),
          prefixIcon: Icon(icon, color: const Color(0xff6C63FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xff6C63FF), width: 2.0),
          ),
        ),
      ),
    );
  }

  /// Custom DropdownField Widget
  Widget _buildDropdownField({
    required String value,
    required String label,
    required IconData icon,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xff5A5A5A)),
          filled: true,
          fillColor: const Color(0xffF0F0F0),
          prefixIcon: Icon(icon, color: const Color(0xff6C63FF)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xff6C63FF), width: 2.0),
          ),
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
