import 'package:receipe_app/data/service/dio/user_dio_service.dart';

import '../model/app_resposne.dart';
import '../model/user_model.dart';

class UserRepository {
  final UserDioService _userDioService;

  UserRepository({required UserDioService userDioService})
      : _userDioService = userDioService;

  Future<AppResponse> getUser({
    required String uid,
    required String email,
  }) async =>
      _userDioService.getUser(uid: uid, email: email);

  Future<AppResponse> addUser({required UserModel user}) async =>
      _userDioService.addUser(user: user);
}
