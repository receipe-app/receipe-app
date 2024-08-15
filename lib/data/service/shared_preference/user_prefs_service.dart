import 'dart:convert';
import 'package:receipe_app/data/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';

class UserPrefsService {
  Future<void> updateUserData({required UserModel user}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final data = preferences.getString('userData');

    if (data == null) return;

    final decodedData = jsonDecode(data) as Map<String, dynamic>;
    decodedData['name'] = user.name;
    decodedData['imageUrl'] = user.imageUrl;

    preferences.setStringList('likedRecipesId', user.likedRecipesId);
    preferences.setStringList('savedRecipesId', user.savedRecipesId);

    preferences.setString('userData', jsonEncode(decodedData));
  }

  static Future<String?> _getUserByData({required String dataName}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final data = preferences.getString('userData');

    if (data == null) return null;

    final decodedData = jsonDecode(data) as Map<String, dynamic>;

    return decodedData[dataName] as String?;
  }

  static Future<String?> get userId async =>
      await _getUserByData(dataName: 'localId');

  static Future<String?> get email async =>
      await _getUserByData(dataName: 'email');

  static Future<String?> get name async =>
      await _getUserByData(dataName: 'name');

  static Future<String?> get imageUrl async =>
      await _getUserByData(dataName: 'imageUrl');

  static Future<List<String>> _getUserByDataList({
    required String dataName,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final List<String>? data = preferences.getStringList(dataName);

    if (data == null) return [];

    return data;
  }

  static Future<List<String>> get likedRecipesId async {
    return await _getUserByDataList(dataName: 'likedRecipesId');
  }

  static Future<List<String>?> get savedRecipesId async =>
      await _getUserByDataList(dataName: 'savedRecipesId');

  static Future<void> setSavedRecipesId(List<String> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList('savedRecipesId', data);
  }
}
