import 'package:hive_flutter/adapters.dart';

part 'comment.g.dart';

@HiveType(typeId: 3)
class Comment {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String text;
  @HiveField(2)
  DateTime createdAt;

  Comment({
    required this.userId,
    required this.text,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  String toString() {
    return 'Comment{userId: $userId, text: $text, createdAt: $createdAt}';
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'] as String,
      text: json['text'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }
}
