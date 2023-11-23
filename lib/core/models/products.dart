import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/locator.dart';

class Product {
  String? id;
  String? sku;
  String? name;
  String? category;
  int? stock;
  int? discountPercentage;
  double? price;
  double? salePrice;
  double? cartSalePrice;
  String? description;
  DateTime? createdAt;
  List<String>? images;
  List<OrderSizes>? sizes;
  List<String>? prices;
  List<String>? salePrices;
  bool? isDiscountAvailable;
  bool? isLiked;
  List<String>? likedUserIds;
  late List<ProductSizes> productSizes;
  int? count;
  String? selectedSize;

  Product({
    this.id,
    this.sku,
    this.name,
    this.category,
    this.stock,
    this.discountPercentage,
    this.sizes,
    this.prices,
    this.salePrices,
    this.cartSalePrice,
    this.price,
    this.salePrice,
    this.description,
    this.images,
    this.isDiscountAvailable,
    this.createdAt,
    this.isLiked,
    this.likedUserIds,
    this.count = 1,
    this.selectedSize,
    required this.productSizes,
  });
  Product.fromJson(json, this.id) {
    sku = json['sku'];
    name = json['name'];
    category = json['category'];
    stock = int.parse(json['stock']);
    discountPercentage = json['discountPercentage'] != null
        ? int.parse(json['discountPercentage'])
        : 0;

    ///
    /// price
    if (json['price'] == null || json['price'] == "") {
      price = json['prodSizes'] != null
          ? json['prodSizes'][0]['price'] != null
              ? json['prodSizes'][0]['price'].contains('.')
                  ? double.parse(json['prodSizes'][0]['price'])
                  : int.parse(json['prodSizes'][0]['price']).toDouble()
              : 0.0
          : 0.0;
    } else {
      price = json['price'] != null
          ? json['price'].contains('.')
              ? double.parse(json['price'])
              : int.parse(json['price']).toDouble()
          : 0.0;
    }

    ///
    /// sale price
    if (json['salePrice'] == null || json['salePrice'] == "") {
      salePrice = json['prodSizes'] != null
          ? json['prodSizes'][0]['salePrice'] != null
              ? json['prodSizes'][0]['salePrice'].contains('.')
                  ? double.parse(json['prodSizes'][0]['salePrice'])
                  : int.parse(json['prodSizes'][0]['salePrice']).toDouble()
              : 0.0
          : 0.0;
      cartSalePrice = salePrice;
    } else {
      salePrice = json['salePrice'] != null
          ? json['salePrice'].contains('.')
              ? double.parse(json['salePrice'])
              : int.parse(json['salePrice']).toDouble()
          : 0.0;
      cartSalePrice = salePrice;
    }

    ///
    /// other work
    description = json['description'];
    productSizes = [];
    if (json['prodSizes'] != null) {
      json['prodSizes'].forEach((e) {
        productSizes.add(ProductSizes.formJson(e));
      });
    }
    if (json['discountPercentage'] == null ||
        json['discountPercentage'] == '0') {
      isDiscountAvailable = false;
    } else {
      isDiscountAvailable = true;
    }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((e) {
        images!.add(e);
      });
    }
    likedUserIds = [];
    if (json['likedUsersIds'] != null) {
      json['likedUsersIds'].forEach((e) {
        likedUserIds!.add(e);
      });
      for (var i in likedUserIds!) {
        if (i == locator<AuthService>().appUser.id) {
          isLiked = true;
        } else {
          isLiked = false;
        }
      }
    } else {
      isLiked = false;
    }
    createdAt = json['createdAt'].toDate();
  }

  Product.fromOrdersJson(json, this.id) {
    sku = json['sku'];
    name = json['name'];
    category = json['category'];
    stock = json['stock'];
    count = json['count'];
    selectedSize = json['selectedSize'];
    discountPercentage =
        json['discountPercentage'] != null ? json['discountPercentage'] : 0;

    ///
    /// price
    if (json['price'] == null) {
      price = json['prodSizes'] != null
          ? json['prodSizes'][0]['price'].contains('.')
              ? double.parse(json['prodSizes'][0]['price'])
              : int.parse(json['prodSizes'][0]['price']).toDouble()
          : 0.0;
    } else {
      price = json['price'] != null ? json['price'] : 0.0;
    }

    ///
    /// sale price
    if (json['salePrice'] == null) {
      salePrice = json['prodSizes'] != null
          ? json['prodSizes'][0]['salePrice'].contains('.')
              ? double.parse(json['prodSizes'][0]['salePrice'])
              : int.parse(json['prodSizes'][0]['salePrice']).toDouble()
          : 0.0;
    } else {
      salePrice = json['salePrice'] != null ? json['salePrice'] : 0.0;
    }

    ///
    /// other work
    description = json['description'];
    productSizes = [];
    if (json['prodSizes'] != null) {
      json['prodSizes'].forEach((e) {
        productSizes.add(ProductSizes.formJson(e));
      });
    }
    if (json['orderSizes'] != null) {
      sizes = [];
      json['orderSizes'].forEach((e) {
        sizes!.add(OrderSizes.formJson(e));
      });
      print('ordersizes ******* ${sizes!.length}');
    }
    if (json['discountPercentage'] == null ||
        json['discountPercentage'] == '0') {
      isDiscountAvailable = false;
    } else {
      isDiscountAvailable = true;
    }
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((e) {
        images!.add(e);
      });
    }
    // sizes = [];
    // if (json['sizes'] != null) {
    //   json['sizes'].forEach((e) {
    //     sizes!.add(e);
    //   });
    // }
    prices = [];
    if (json['prices'] != null) {
      json['prices'].forEach((e) {
        prices!.add(e);
      });
    }
    likedUserIds = [];
    if (json['likedUsersIds'] != null) {
      json['likedUsersIds'].forEach((e) {
        likedUserIds!.add(e);
      });
      for (var i in likedUserIds!) {
        if (i == locator<AuthService>().appUser.id) {
          isLiked = true;
        } else {
          isLiked = false;
        }
      }
    } else {
      isLiked = false;
    }
    createdAt =
        json['createdAt'] != null ? json['createdAt'].toDate() : DateTime.now();
  }

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sku'] = sku;
    data['name'] = name;
    data['category'] = category;
    data['stock'] = stock;
    data['discountPercentage'] = discountPercentage;
    data['price'] = price;
    data['salePrice'] = salePrice;
    data['description'] = description;
    data['images'] = images;
    data['likedUsersIds'] = likedUserIds;
    data['createdAt'] = createdAt;
    data['count'] = count;
    // data['sizes'] = sizes;
    data['prices'] = prices;
    data['selectedSize'] = selectedSize;
    if (productSizes.isNotEmpty) {
      data['prodSizes'] = productSizes.map((v) => v.toJson()).toList();
    }
    if (sizes != null) {
      data['orderSizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductSizes {
  String? size;
  String? price;
  String? salePrice;
  String? percentage;

  ProductSizes({
    this.size,
    this.price,
    this.salePrice,
    this.percentage,
  });

  ProductSizes.formJson(json) {
    size = json['size'];
    price = json['price'];
    salePrice = json['salePrice'];
    percentage = json['percentage'];
  }

  toJson() {
    return {
      'size': size,
      'price': price,
      'salePrice': salePrice,
      'percentage': percentage,
    };
  }
}

class OrderSizes {
  String? size;
  int? count;

  OrderSizes({
    this.size,
    this.count,
  });

  OrderSizes.formJson(json) {
    size = json['size'];
    count = json['count'];
  }

  toJson() {
    return {
      'size': size,
      'count': count,
    };
  }
}
