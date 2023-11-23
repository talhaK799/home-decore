// import 'package:f2_base_project/core/models/response/base_response.dart';
// import 'package:f2_base_project/core/others/localization_class.dart';

// class AboutUs extends BaseResponse {
//   int? id;
//   String? title;
//   String? content;
//   String? imageUrl;
//   String? createdAt;

//   AboutUs(
//     succes, {
//     error,
//     this.id,
//     this.title,
//     this.content,
//     this.imageUrl,
//     this.createdAt,
//   }) : super(succes, error: error);

//   /// Named Constructor
//   AboutUs.fromJson(json) : super.fromJson(json) {
//     this.id = json['body']['aboutus']['id'];
//     this.title = json['body']['aboutus'][LocalizationClass.getLocalizedKey('title')];
//     this.content = json['body']['aboutus'][LocalizationClass.getLocalizedKey('content')];
//     this.imageUrl = json['body']['aboutus']['image_url'];
//     this.createdAt = json['body']['aboutus']['created_at'];
//   }
// }
