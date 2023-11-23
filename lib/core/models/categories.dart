import 'dart:io';

class Categories {
  String? id;
  String? title;
  String? iconUrl;
  DateTime? createdAt;
  File? icon;

  Categories({
    this.id,
    this.title,
    this.iconUrl,
    this.createdAt,
    this.icon,
  });

  Categories.fromJson(json, id) {
    this.id = id;
    this.title = json['title'];
    this.iconUrl = json['iconUrl'];
    this.createdAt = json['createdAt'].toDate();
  }

  toJson() => {
        'title': this.title,
        'iconUrl': this.iconUrl,
        'createdAt': this.createdAt,
      };
}
