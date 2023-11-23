// import 'package:f2_base_project/core/models/other_models/shop_section/products.dart';

// class ProductCart {
//   int? shopId;
//   String? shopName;
//   late List<Product> products;

//   ProductCart({this.shopId, this.shopName});

//   ProductCart.fromJson(json) {
//     try {
//       products = [];
//       this.shopId = json['id'];
//       this.shopName = json['shopName'];
//       if (json['products'] != null) {
//         json['products']?.forEach((value) {
//           print('ProductID => ${value['id']}');
//           products.add(Product.fromJson(value));
//         });
//       }
//     } catch (e, s) {
//       print('Exception @productCart.fromJson: $e');
//       print('$s');
//     }
//   }
// }
