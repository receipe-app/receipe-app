import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/dio_client.dart';
import '../model/recipe/ingredient.dart';
import '../model/recipe/instruction.dart';
import '../model/recipe/recipe.dart';

class FirebaseRecipeService {
  final _dioClient = DioClient();
  final String _apiKey = dotenv.get("WEB_API_KEY");
  final _recipeImageStorage = FirebaseStorage.instance;

  /// FETCH RECIPES
  Future<List<Recipe>> fetchRecipes() async {
    final userToken = await _getUserToken();

    final response = await _dioClient.get(url: '/recipes.json?auth=$userToken');

    if (response.statusCode != 200) {
      final errorData = response.data;
      throw (errorData['error']);
    }

    if (response.data == null) return [];

    List<Recipe> allRecipes = [];

    response.data.forEach!((key, value) {
      value['id'] = key;
      allRecipes.add(Recipe.fromJson(value as Map<String, dynamic>));
    });

    return allRecipes;
  }

  /// ADD RECIPE
  Future<Recipe> addRecipe({
    required String title,
    required List<Ingredient> ingredients,
    required List<Instruction> instructions,
    required int preparationTime, // in minutes
    required int cookingTime, // in minutes
    required String cuisineType,
    required String difficultyLevel,
    required File imageFile,
  }) async {
    String imageUrl = await _uploadEventImage(imageFile);
    final userToken = await _getUserToken();
    final userId = await _getUserId();

    try {
      final response = await _dioClient.post(
        url: '/recipes.json?auth=$userToken',
        data: {
          'title': title,
          'ingredients': ingredients,
          'instructions': instructions,
          'preparationTime': preparationTime,
          'cookingTime': cookingTime,
          'cuisineType': cuisineType,
          'difficultyLevel': difficultyLevel,
          'imageUrl': imageUrl,
          'authorId': userId,
          'createdAt': DateTime.now().toString(),
        },
      );
      if (response.statusCode != 200) {
        final errorData = response.data;
        throw (errorData['error']);
      }

      final data = response.data;
      debugPrint("ADDED RECIPE: $data");

      final newAddedRecipe = Recipe(
        id: data['name'],
        title: title,
        ingredients: ingredients,
        instructions: instructions,
        preparationTime: preparationTime,
        cookingTime: cookingTime,
        cuisineType: cuisineType,
        difficultyLevel: difficultyLevel,
        imageUrl: imageUrl,
        authorId: userId,
      );

      return newAddedRecipe;
    } catch (e) {
      rethrow;
    }
  }

  /// EDIT RECIPE
  Future<void> editRecipe({
    required String id,
    required String newTitle,
    required int newCookingTime, // in minutes
    required String newCuisineType,
    required String newDifficultyLevel,
  }) async {
    final userToken = await _getUserToken();
    try {
      final response = await _dioClient.updateData(
        url: '/recipes/$id.json?auth=$userToken',
        data: {
          'title': newTitle,
          'cookingTime': newCookingTime,
          'cuisineType': newCuisineType,
          'difficultyLevel': newDifficultyLevel,
        },
      );
      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.data);
        debugPrint("ERROR DATA: $errorData");
        throw (errorData['error']);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE RECIPE
  Future<void> deleteRecipe({required String id}) async {
    final userToken = await _getUserToken();
    try {
      final response =
          await _dioClient.delete(url: 'recipes/$id.json?auth=$userToken');
      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.data);
        throw (errorData['error']);
      }
    } catch (e) {
      rethrow;
    }
  }

  /// UPLOAD IMAGE TO THE FIREBASE STORAGE AND GET DOWNLOAD URL
  Future<String> _uploadEventImage(
    File imageFile,
  ) async {
    final imageRef = _recipeImageStorage
        .ref()
        .child('eventImages')
        .child("${DateTime.now().microsecondsSinceEpoch}.jpg");

    final uploadTask = imageRef.putFile(imageFile);

    /// LISTENING TO UPLOAD PROGRESS
    uploadTask.snapshotEvents.listen(
      (status) {
        debugPrint("Uploading status: ${status.state}");
        double percentage =
            (status.bytesTransferred / imageFile.lengthSync()) * 100;
        debugPrint("Uploading percentage: $percentage");
      },
    );

    await uploadTask.whenComplete(() {});
    return imageRef.getDownloadURL();
  }

  /// GET USER TOKEN
  Future<String> _getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString("userData");

    if (userData == null) {
      // redirect to login
      debugPrint("NULL USERDATA: $userData");
    }

    Map<String, dynamic> user = jsonDecode(userData!);
    bool isTokenExpired = DateTime.now().isAfter(
      DateTime.parse(user['expiresIn']),
    );

    if (isTokenExpired) {
      // refresh token
      user = await _refreshToken(user);
      prefs.setString("userData", jsonEncode(user));
    }

    return user['idToken'];
  }

  /// GET NEW TOKEN with REFRESH TOKEN
  Future<Map<String, dynamic>> _refreshToken(Map<String, dynamic> user) async {
    try {
      Dio dio = Dio();

      final response = await dio.post(
        "https://securetoken.googleapis.com/v1/token?key=$_apiKey",
        data: {
          "grant_type": "refresh_token",
          "refresh_token": user['refreshToken'],
        },
      );

      if (response.statusCode != 200) {
        final errorData = response.data;
        throw (errorData['error']);
      }

      final data = response.data;

      user['refreshToken'] = data['refresh_token'];
      user['idToken'] = data['id_token'];
      user['expiresIn'] = DateTime.now()
          .add(
            Duration(
              seconds: int.parse(
                data['expires_in'],
              ),
            ),
          )
          .toString();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  /// GET USER ID
  Future<String> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final userData = prefs.getString("userData");
      if (userData == null) {
        throw ("Error getting userData");
      }
      Map<String, dynamic> user = jsonDecode(userData);
      return user['localId'];
    } catch (e) {
      rethrow;
    }
  }
}
