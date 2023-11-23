import 'package:f2_base_project/core/models/app_user.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/models/user_address.dart';

class Orders {
  String? id;
  String? orderId;
  String? userName;
  String? userId;
  String? totalProducts;
  int? deliveryCharges;
  String? totalPrice;
  String? orderStatus;
  AppUser? appUser;
  UserAddress? userAddress;
  DateTime? createdAt;
  List<Product>? products;
  List<String>? sizes;
  double? sizePrice;

  Orders({
    this.id,
    this.orderId,
    this.userName,
    this.userId,
    this.totalPrice,
    this.totalProducts,
    this.deliveryCharges,
    this.orderStatus,
    this.appUser,
    this.userAddress,
    this.createdAt,
    this.products,
    this.sizes,
    this.sizePrice,
  });

  Orders.formJson(json, this.id) {
    orderId = json['orderId'];
    userName = json['userName'];
    userId = json['userId'];
    totalPrice = json['totalPrice'];
    totalProducts = json['totalProducts'];
    deliveryCharges = json['deliveryCharges'];
    orderStatus = json['orderStatus'];
    sizes = json[sizes];
    if (json['user'] != null) {
      appUser = AppUser();
      appUser = AppUser.fromJson(json['user'], json['userId']);
    }
    if (json['userAddress'] != null) {
      userAddress = UserAddress();
      userAddress = UserAddress.fromJson(json['userAddress'], id);
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((e) {
        products!.add(Product.fromOrdersJson(e, id));
      });
    }
    createdAt = json['createdAt'].toDate();
  }

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['userName'] = userName;
    data['userId'] = userId;
    data['totalPrice'] = totalPrice;
    data['totalProducts'] = totalProducts;
    data['deliveryCharges'] = deliveryCharges;
    data['orderStatus'] = orderStatus;
    data['sizes'] = sizes;
    if (products!.isNotEmpty) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (appUser != null) {
      data['user'] = appUser!.toJson();
    }
    data['createdAt'] = createdAt;
    if (userAddress != null) {
      data['userAddress'] = userAddress!.toJson();
    }

    return data;
  }
}
