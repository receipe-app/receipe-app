class Comment {
  String userId;
  String text;
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
      'userId': this.userId,
      'text': this.text,
      'createdAt': this.createdAt,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'] as String,
      text: json['text'] as String,
      createdAt: json['createdAt'] as DateTime,
    );
  }
}
