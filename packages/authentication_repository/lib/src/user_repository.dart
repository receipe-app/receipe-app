import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('userData');

    if (data == null) return null;

    return User.fromJson(jsonDecode(data));
  }
}
