class Delievry {
  String? id;
  String? title;
  DateTime? createdAt;

  Delievry({
    this.id,
    this.title,
    this.createdAt,
  });

  Delievry.formJson(json, this.id) {
    title = json['title'];
    createdAt = json['createdAt'].toDate() ?? DateTime.now();
  }

  toJson() {
    return {
      'title': title,
      'createdAt': createdAt,
    };
  }
}
