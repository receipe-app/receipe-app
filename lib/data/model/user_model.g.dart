// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      imageUrl: json['imageUrl'] as String,
      email: json['email'] as String,
      savedRecipesId: (json['savedRecipesId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      likedRecipesId: (json['likedRecipesId'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'imageUrl': instance.imageUrl,
      'email': instance.email,
      'savedRecipesId': instance.savedRecipesId,
      'likedRecipesId': instance.likedRecipesId,
    };
