import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:receipe_app/core/network/dio_client.dart';
import 'package:receipe_app/data/model/app_resposne.dart';

import '../../model/user_model.dart';

class UserDioService {
  final DioClient _dioClient = DioClient();

  Future<AppResponse> getUser({
    required String uid,
    required String email,
  }) async {
    final AppResponse appResponse = AppResponse();
    try {
      final response = await _dioClient.get(url: 'users.json');

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
}
