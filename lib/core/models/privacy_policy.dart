import 'package:f2_base_project/core/others/localization_class.dart';

class PrivacyPolicy {
  int? id;
  String? policy;
  String? createdAt;

  PrivacyPolicy({
    this.id,
    this.policy,
    this.createdAt,
  });

  PrivacyPolicy.fromJson(json) {
    this.id = json['id'];
    this.policy = json[LocalizationClass.getLocalizedKey('privacy')];
    this.createdAt = json['created_at'];
  }
}
