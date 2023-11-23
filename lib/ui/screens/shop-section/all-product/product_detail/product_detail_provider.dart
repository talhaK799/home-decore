import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/offers.dart';
import 'package:f2_base_project/core/models/order.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../../../../locator.dart';

class ProductDetailProvider extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final authService = locator<AuthService>();
  late PageController pageController;
  int currentImage = 0;
  List<Product> relatedProducts = [];
  bool isShimmer = false;
  double salePrice = 0.0;
  double price = 0.0;
  String selectedSize = '';
  List<String> sizes = [];
  // Order order = Order();
  int selectedSizeIndex = 0;

  ProductDetailProvider(
      Product product, bool isFromOffer, Offers offer, bool isFirstTime) {
    pageController = PageController(initialPage: currentImage);
    price = product.price!;
    salePrice = product.salePrice!;
    if (product.productSizes.isNotEmpty) {
      selectedSize = product.productSizes[0].size!;
      for (var e in product.productSizes) {
        sizes.add(e.size!);
      }
    }
    if (product.productSizes.isNotEmpty) {
      changeSize(product, 0, isFromOffer: isFromOffer, offer: offer);
    }
    if (product.productSizes.isEmpty) {
      print('isFromOfferScreen => $isFromOffer');
      if (isFirstTime == false) {
        if (isFromOffer == true) {
          calculateSalePrice(offer, product);
        }
      }
    }
    getRelatedProducts(product);
  }

  calculateSalePrice(Offers offer, Product product) {
    if (offer.percentage != null && offer.percentage != '0') {
      double calPrice = salePrice * int.parse(offer.percentage!) / 100;
      print('calPrice => $calPrice');
      salePrice = salePrice - calPrice;
      product.salePrice = salePrice;
      print('salePrice => $salePrice');
    } else {
      salePrice = salePrice - int.parse(offer.flatDiscount!);
      product.salePrice = salePrice;
    }
    notifyListeners();
  }

  ///
  /// add to cart concept
  /// with different sizes and
  /// price for each size
  ///
  addToCart(Product product, {bool isShowSnackbar = true}) async {
    print('SalePrice => $salePrice');
    if (authService.isLogin) {
      setState(ViewState.busy);
      if (authService.order.products == null) {
        authService.order.totalPrice = salePrice.toString();
        authService.order.totalProducts = '1';
        authService.order.orderId = generateRandomString(8);
        print('orderID => ${authService.order.orderId}');
        authService.order.userId = authService.appUser.id;
        authService.order.userName = authService.appUser.name;
        authService.order.createdAt = DateTime.now();
        authService.order.products = [];
        authService.order.appUser = authService.appUser;
        if (selectedSize != '') {
          product.sizes = [];
          OrderSizes orderSizes = OrderSizes(count: 1);
          orderSizes.size = selectedSize;
          product.sizes!.add(orderSizes);
          product.selectedSize = selectedSize;
        }
        product.salePrice = salePrice;
        product.price = price;
        authService.order.products!.add(product);
        authService.order.products![0].count = 1;
        print(
            'firstProductSalePrice => ${authService.order.products![0].salePrice}');
      } else {
        bool isFound = false;
        bool isSizeFound = false;
        for (int i = 0; i < authService.order.products!.length; i++) {
          if (authService.order.products![i].id == product.id) {
            isFound = true;
            if (authService.order.products![i].sizes != null) {
              for (int j = 0;
                  j < authService.order.products![i].sizes!.length;
                  j++) {
                if (selectedSize ==
                    authService.order.products![i].sizes![j].size) {
                  isSizeFound = true;
                  authService.order.products![i].sizes![j].count =
                      authService.order.products![i].sizes![j].count! + 1;
                }
              }
              if (!isSizeFound) {
                print('i => $i');
                print(
                    'sizesProductSalePrice => ${authService.order.products![i].salePrice}:::$salePrice');
                authService.order.products![i].salePrice =
                    salePrice + authService.order.products![i].salePrice!;
                print(
                    'sizesProductSalePrice => ${authService.order.products![i].salePrice}:::$salePrice');
                OrderSizes orderSizes = OrderSizes(count: 1);
                orderSizes.size = selectedSize;
                product.sizes!.add(orderSizes);
              }
            }
            authService.order.products![i].count =
                authService.order.products![i].count! + 1;
          }
        }
        if (!isFound) {
          print('prodNameNotFound => ${product.name}');
          product.count = 1;
          if (selectedSize != '') {
            product.sizes = [];
            OrderSizes orderSizes = OrderSizes(count: 1);
            orderSizes.size = selectedSize;
            product.sizes!.add(orderSizes);
            product.selectedSize = selectedSize;
          }
          product.salePrice = salePrice;
          product.price = price;
          authService.order.products!.add(product);
        }
        authService.order.totalPrice =
            '${salePrice + double.parse(authService.order.totalPrice!)}';
      }
      print('SelectedSize => $selectedSize');
      print('totalPrice => ${authService.order.totalPrice}');

      ///
      /// add cart to db
      ///
      await addCartToDB(isShowSnackbar);
      setState(ViewState.idle);
    } else {
      Get.dialog(SignupRequiredDialog('productsScreen'));
    }
  }

  addCartToDB(bool isShowSnackbar) async {
    await _dbService.addCartToDB(authService.appUser.id!, authService.order);
    isShowSnackbar
        ? Get.snackbar('Added Success', 'Product added to cart successfully',
            snackPosition: SnackPosition.BOTTOM)
        : null;
  }

  getRelatedProducts(Product product) async {
    setState(ViewState.busy);
    relatedProducts = await _dbService.getRelatedProducts(product);
    print('relatedProducts => ${relatedProducts.length}');
    setState(ViewState.idle);
  }

  changeSize(Product product, int index, {bool? isFromOffer, Offers? offer}) {
    if (isFromOffer == true) {
      print('FromOffersScreen');
      price = 0.0;
      salePrice = 0.0;
      selectedSizeIndex = index;
      selectedSize = product.productSizes[index].size!;
      if (product.discountPercentage != null) {
        print('offer!.percentage => ${offer!.percentage}');
        if (int.parse(offer.percentage!) != 0) {
          calculateDiscountSalePrice(product, offer, index);
        } else {
          calculateFlatSalePrice(product, offer, index);
        }
      }
    } else {
      print('NOtFromOffersScreen');
      price = 0.0;
      salePrice = 0.0;
      selectedSizeIndex = index;
      price = double.parse(product.productSizes[index].price!);
      salePrice = double.parse(product.productSizes[index].salePrice!);
      selectedSize = product.productSizes[index].size!;
    }
    setState(ViewState.idle);
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  ///
  /// Toggling product like
  ///
  void toggleProductLike(Product product) async {
    if (authService.isLogin) {
      if (product.isLiked == null) {
        product.isLiked = true;
      } else {
        product.isLiked = product.isLiked == false ? true : false;
      }
      if (product.isLiked == true) {
        Get.snackbar('Wishlist added', 'Product successfully added to wishlist',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar(
            'Wishlist removed', 'Product successfully removed from wishlist',
            snackPosition: SnackPosition.BOTTOM);
      }
      // for (var prod in authService.allProducts) {
      //   if (prod.sku == product.sku) {
      //     prod.isLiked = prod.isLiked == true ? false : true;
      //   }
      // }
      if (product.likedUserIds != null) {
        if (product.likedUserIds!.contains(authService.appUser.id)) {
          print('Not equal to null');
          product.likedUserIds!.remove(authService.appUser.id!);
        } else {
          product.likedUserIds!.add(authService.appUser.id!);
        }
      } else {
        print('Equal to null');
        product.likedUserIds = [];
        product.likedUserIds!.add(authService.appUser.id!);
      }
      setState(ViewState.idle);
      await _dbService.updateProduct(product);
      setState(ViewState.idle);
    } else {
      Get.dialog(SignupRequiredDialog('rootScreen'));
    }
  }

  onBackPress(Product product) {
    Get.back(result: authService.order.products);
  }

  calculateDiscountSalePrice(Product product, Offers offer, int index) {
    var sale = 0.0;
    print('offerDiscount => ${offer.percentage}');
    print('offerFlatDiscount => ${offer.flatDiscount}');
    if (offer.percentage != null &&
        product.productSizes[index].salePrice != null) {
      sale = (int.parse(offer.percentage!) / 100) *
          double.parse(product.productSizes[index].salePrice!);
      print('sale => $sale');
      sale = double.parse(product.productSizes[index].salePrice!) - sale;
      salePrice = sale;
    }
    notifyListeners();
  }

  calculateFlatSalePrice(Product product, Offers offer, int index) {
    if (offer.flatDiscount != null &&
        int.parse(offer.flatDiscount!) != 0 &&
        product.price != null) {
      salePrice = double.parse(product.productSizes[index].salePrice!) -
          int.parse(offer.flatDiscount!);
    }
    setState(ViewState.idle);
  }
}
