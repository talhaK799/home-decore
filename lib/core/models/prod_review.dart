import 'package:f2_base_project/core/models/app_user.dart';

class ProdReview {
  int? prodId;
  int? reviewId;
  int? userId;
  String? rating;
  String? reviewText;
  String? reviewFor;
  String? createdAt;

  AppUser appUser = AppUser();

  ProdReview({this.prodId, this.rating, this.reviewText, this.reviewFor});

  toJson() => {
        'product_id': this.prodId,
        'rating': this.rating,
        'review': this.reviewText,
        'review_for': this.reviewFor,
        'service_provider_id': null,
      };

  ProdReview.fromJson(json, id) {
    try {
      this.prodId = json['product_id'];
      this.reviewId = json['id'];
      this.userId = json['user_id'];
      this.rating = json['rating'] ?? "1.0";
      this.reviewText = json['review'];
      this.reviewFor = json['review_for'];
      this.createdAt = json['created_at'];
      // print("Ratting => ${this.rating}");
      if (json['user'] != null) {
        appUser = AppUser();
        appUser = AppUser.fromJson(json['user'], id);
        // print("userName => ${userProfile.name}");
      }
    } catch (e, s) {
      print('Exception @ProdReview.fromJson: $e');
      print('$s');
    }
  }
}
