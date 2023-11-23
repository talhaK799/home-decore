
import 'package:f2_base_project/core/models/products.dart';

class MyOrders {
  int? id;
  int? userId;
  String? paymnetType;
  String? orderStatus;
  int? addressId;
  String? orderId;
  String? createdAt;
  double? totalPrice;
  int? totalProducts;
  
  List<OrderDetails> orderDetails = [];

  MyOrders(
      {this.id,
      this.userId,
      this.paymnetType,
      this.orderStatus,
      this.addressId,
      this.orderId,
      this.totalPrice,
      this.createdAt,
      this.totalProducts,
      required this.orderDetails});

  MyOrders.fromJson(json, id) {
    try {
      this.id = json['id'];
      this.userId = json['user_id'];
      this.paymnetType = json['payment_type'];
      this.orderStatus = json['status'];
      this.addressId = json['address_id'];
      this.totalProducts = json['total_products'];
      print('PRICE => ${json['total_price']}');
      this.totalPrice = json['total_price'].toDouble();
      this.orderId = json['order_id'];
      this.createdAt = json['created_at'];
      
      if (json['order_details'].length > 0) {
        json['order_details'].forEach((value) {
          orderDetails.add(OrderDetails.fromJson(value, id));
        });
      }
    } catch (e, s) {
      print('Exception @MyOrders.fromJson: $e');
      print('$s');
    }
  }
}

class OrderDetails {
  int? id;
  int? productId;
  int? quantity;
  double? orderPrice;
  Product? product;

  OrderDetails({
    this.id,
    this.productId,
    this.quantity,
    this.orderPrice,
    this.product,
  });

  OrderDetails.fromJson(json,id) {
    try {
      this.id = json['id'];
      this.productId = json['product_id'];
      this.quantity = json['quantity'] ?? 1;
      this.orderPrice = json['total_price'].toDouble();
      if (json['product'] != null) {
        product = Product.fromJson(json['product'], id);
      }
    } catch (e, s) {
      print('Exception @MyOrders.fromJson: $e');
      print('$s');
    }
  }
}
