import 'package:f2_base_project/core/others/localization_class.dart';

class ProdBrand {
  int? brandId;
  String? brandName;
  String? brandDescription;
  String? brandImgUrl;
  String? cretedAt;

  ProdBrand(
      {this.brandId,
      this.brandName,
      this.brandDescription,
      this.brandImgUrl,
      this.cretedAt});

  ProdBrand.fromJson(json) {
    try {
      print('brandName => ${json['name']}');
      this.brandId = json['id'];
      this.brandName = json[LocalizationClass.getLocalizedKey('name') ?? ''];
      this.brandDescription =
          json[LocalizationClass.getLocalizedKey('description') ?? ''];
      this.brandImgUrl = json['image_url'];
      this.cretedAt = json['created_at'];
    } catch (e, s) {
      print('Exception @prodBrand.fromJson: $e');
      print('$s');
    }
  }
}
