import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:receipe_app/core/network/dio_client.dart';
import 'package:receipe_app/data/model/app_resposne.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';

class UserDioService {
  final DioClient _dioClient = DioClient();
  final String _apiKey = dotenv.get("WEB_API_KEY");

  Future<AppResponse> getUser({
    required String uid,
    required String email,
  }) async {
    final AppResponse appResponse = AppResponse();
    try {
      final userToken = await _getUserToken();
      final response = await _dioClient.get(url: 'users.json?auth=$userToken');

      final Map<String, dynamic> mapData = response.data;

      for (final key in mapData.keys) {
        final value = mapData[key];
        if (value['email'] == email && value['uid'] == uid) {
          value['id'] = key;
          appResponse.data = UserModel.fromJson(value);
          appResponse.isSuccess = true;
          break;
        }
      }
    } catch (e) {
      if (e is DioException) {
        appResponse.statusCode = e.response?.statusCode;
      }
      appResponse.errorMessage = e.toString();
    }

    log(appResponse.errorMessage);
    log(appResponse.statusCode.toString());

    return appResponse;
  }

  Future<AppResponse> addUser({required UserModel user}) async {
    final AppResponse appResponse = AppResponse();

    try {
      final userMap = user.toJson();
      userMap.remove('id');

      _dioClient.post(url: 'users.json', data: userMap);
    } catch (e) {
      if (e is DioException) {
        appResponse.errorMessage = e.toString();
        appResponse.statusCode = e.response?.statusCode;
      } else {
        appResponse.errorMessage = e.toString();
      }
      log(e.toString());
    }

    return appResponse;
  }

  Future<String> _getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString("userData");

    if (userData == null) {
      // redirect to login
      debugPrint("NULL USERDATA: $userData");
    }

    Map<String, dynamic> user = jsonDecode(userData!);
    bool isTokenExpired = DateTime.now().isAfter(
      DateTime.parse(
        user['expiresIn'],
      ),
    );

    if (isTokenExpired) {
      // refresh token
      user = await _refreshToken(user);
      prefs.setString("userData", jsonEncode(user));
    }

    return user['idToken'];
  }

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
}
