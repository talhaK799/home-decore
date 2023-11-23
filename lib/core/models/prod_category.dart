import 'package:f2_base_project/core/others/localization_class.dart';

class ProdCategory {
  int? categId;
  String? categName;
  String? categDescription;
  String? categImgUrl;
  String? cretedAt;

  ProdCategory(
      {this.categId,
      this.categName,
      this.categDescription,
      this.categImgUrl,
      this.cretedAt});

  ProdCategory.fromJson(json) {
    try {
      this.categId = json['id'];
      this.categName = json[LocalizationClass.getLocalizedKey('name')];
      this.categDescription =
          json[LocalizationClass.getLocalizedKey('description') ?? ''];
      this.categImgUrl = json['image_url'];
      this.cretedAt = json['created_at'];
    } catch (e, s) {
      print('Exception @ProdCategory.fromJson: $e');
      print('$s');
    }
  }
}
