class Offers {
  String? id;
  String? product;
  String? title;
  String? category;
  String? description;
  String? percentage;
  String? imageUrl;
  String? flatDiscount;
  DateTime? createdAt;

  Offers(
      {this.id,
      this.product,
      this.title,
      this.category,
      this.description,
      this.percentage,
      this.imageUrl,
      this.flatDiscount,
      this.createdAt});

  Offers.formJson(json, this.id) {
    product = json['product'];
    title = json['title'];
    category = json['category'];
    description = json['description'];
    percentage = json['percentage'];
    imageUrl = json['imageUrl'];
    flatDiscount = json['flatDiscount'];
    createdAt = json['createdAt'].toDate();
  }

  toJson() {
    return {
      'product': product,
      'title': title,
      'category': category,
      'description': description,
      'percentage': percentage,
      'imageUrl': imageUrl,
      'flatDiscount': flatDiscount,
      'createdAt': createdAt,
    };
  }
}
