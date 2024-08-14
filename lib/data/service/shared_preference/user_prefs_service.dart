import 'dart:convert';
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
    decodedData['likedRecipesId'] = user.likedRecipesId;
    decodedData['savedRecipesId'] = user.savedRecipesId;

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

  static Future<List<String>?> get likedRecipesId async {}


  //  static Future<String?> get user async => await _getUserByData(dataName: dataName)
}
