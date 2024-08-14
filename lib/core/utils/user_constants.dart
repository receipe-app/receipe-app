import '../../data/model/user_model.dart';

class UserConstants {
  static String name = 'null';
  static String email = 'null';
  static String imageUrl = 'null';
  static String uid = 'null';
  static List<String> savedRecipesId = [];
  static List<String> likedRecipesId = [];

  static saveUserData({required UserModel userModel}) {
    name = userModel.name;
    email = userModel.email;
    imageUrl = userModel.imageUrl;
    savedRecipesId = userModel.savedRecipesId;
    likedRecipesId = userModel.likedRecipesId;
  }
}
