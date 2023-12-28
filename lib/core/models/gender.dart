
import 'package:f2_base_project/core/others/localization_class.dart';

class Gender {
  int? genderId;
  String? genderType;
  String? cretedAt;

  Gender({this.genderId, this.genderType, this.cretedAt});

  Gender.fromJson(json) {
    try {
      this.genderId = json['id'];
      this.genderType = json[LocalizationClass.getLocalizedKey('name') ?? ''];
      this.cretedAt = json['created_at'];
    } catch (e, s) {
      print('Exception @genders.fromJson: $e');
      print('$s');
    }
  }
}
