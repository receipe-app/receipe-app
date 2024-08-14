import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user.dart';

class AuthenticationRepository {
  final Dio _dio = Dio();

  Future<User> _authenticate({
    required String email,
    required String password,
    required String query,
  }) async {
    String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$query?key=AIzaSyBETfX8XDGAJBdBzkRZY68vBBeIYO0HWT0";

    try {
      final response = await _dio.post(
        url,
        data: {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final user = User.fromJson(data);
        _saveUserData(user);
        return user;
      }

      print(response.data['error ']['message']);
      throw (response.data['error ']['message']);
    } on DioException catch (e) {
      if (e.response != null) {
        throw (e.response?.data['error']['message'] ?? 'An error occurred');
      } else {
        throw ('An error occurred: ${e.message}');
      }
    }
  }

  Future<User> register({
    required String email,
    required String password,
  }) async =>
      await _authenticate(
        email: email,
        password: password,
        query: "signUp",
      );

  Future<User> login({
    required String email,
    required String password,
  }) async =>
      await _authenticate(
        email: email,
        password: password,
        query: "signInWithPassword",
      );

  Future<User?> checkTokenExpiry() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userData = sharedPreferences.getString("userData");
    if (userData == null) {
      return null;
    }

    final user = jsonDecode(userData);

    if (DateTime.now().isBefore(
      DateTime.parse(
        user['expiresIn'],
      ),
    )) {
      return User(
        id: user['localId'],
        email: user['email'],
        token: user['idToken'],
        refreshToken: user['refreshToken'],
        expiresIn: DateTime.parse(user['expiresIn']),
      );
    }

    return null;
  }

  Future<void> _saveUserData(User user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
      'userData',
      jsonEncode(user.toJson()),
    );
  }

  Future<void> clearTokens() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}
