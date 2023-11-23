class Notifications {
  String? id;
  String? userId;
  String? title;
  String? content;
  String? notificationType;
  String? imageUrl;
  int? isRead;
  DateTime? createdAt;

  Notifications({
    this.id,
    this.title,
    this.content,
    this.notificationType,
    this.userId,
    this.isRead = 0,
    this.imageUrl,
    this.createdAt,
  });

  Notifications.fromJson(json, this.id) {
    try {
      title = json['title'];
      content = json['content'];
      notificationType = json['notificationType'];
      userId = json['userId'];
      isRead = json['isRead'];
      imageUrl = json['imageUrl'];
      createdAt = json['createdAt'] != null ? json['createdAt'].toDate() : null;
    } catch (e, s) {
      print('Exception @Notifications.fromJson: $e');
      print('$s');
    }
  }

  toJson() => {
        'title': title,
        'content': content,
        'notificationType': notificationType,
        'userId': userId,
        'isRead': isRead,
        'imageUrl': imageUrl,
        'createdAt': createdAt,
      };
}
