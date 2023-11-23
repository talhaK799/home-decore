import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/locator.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final authService = locator<AuthService>();
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();
  String sorting = '1';

  ///
  /// Toggling product like
  void toggleProductLike(List<Product> product, int index) async {
    if (authService.isLogin) {
      if (product[index].isLiked == null) {
        product[index].isLiked = true;
      } else {
        product[index].isLiked = product[index].isLiked == false ? true : false;
      }
      if (product[index].isLiked == true) {
        Get.snackbar('Wishlist added', 'Product successfully added to wishlist',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar(
            'Wishlist removed', 'Product successfully removed from wishlist',
            snackPosition: SnackPosition.BOTTOM);
      }
      // for (var prod in authService.allProducts) {
      //   if (prod.sku == product[index].sku) {
      //     prod.isLiked = prod.isLiked == true ? false : true;
      //   }
      // }
      if (product[index].likedUserIds != null) {
        if (product[index].likedUserIds!.contains(authService.appUser.id)) {
          print('Not equal to null');
          product[index].likedUserIds!.remove(authService.appUser.id!);
        } else {
          product[index].likedUserIds!.add(authService.appUser.id!);
        }
      } else {
        print('Equal to null');
        product[index].likedUserIds = [];
        product[index].likedUserIds!.add(authService.appUser.id!);
      }
      setState(ViewState.idle);
      await _dbService.updateProduct(product[index]);
    } else {
      Get.dialog(SignupRequiredDialog('homeScreen'));
    }
    setState(ViewState.idle);
  }

  updateSorting(String value) {
    sorting = value;
    notifyListeners();
  }

  sortHighToLow() {
    print('sortHightToLow');
    authService.allProducts
        .sort((a, b) => a.salePrice!.compareTo(b.salePrice!));
    authService.allProducts = authService.allProducts.reversed.toList();
    notifyListeners();
  }

  sortHighToLowWishlist(List<Product> products) {
    print('sortHightToLowWishlist');
    products.sort((a, b) => a.salePrice!.compareTo(b.salePrice!));
    products = products.reversed.toList();
    notifyListeners();
  }

  sortLowToHigh() {
    print('sortLowToHigh');
    authService.allProducts
        .sort((a, b) => a.salePrice!.compareTo(b.salePrice!));
    notifyListeners();
  }

  sortLowToHighWishlist(List<Product> products) {
    print('sortLowToHighWishlist');
    authService.allProducts
        .sort((a, b) => a.salePrice!.compareTo(b.salePrice!));
    notifyListeners();
  }

  sortNewArrival() {
    print('sortNewArrival');
    authService.allProducts
        .sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    authService.allProducts = authService.allProducts.reversed.toList();
    notifyListeners();
  }

  sortWishlistedProds(List<Product> products) {
    print('sortWishlisted');
    products.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    products = products.reversed.toList();
    notifyListeners();
  }

  sortTopRated() {
    print('sortTopRated');
    authService.allProducts.sort((a, b) => a.category!.compareTo(b.category!));
    notifyListeners();
  }

  sortTopRatedWishlist(List<Product> products) {
    print('sortTopRatedWishlist');
    products.sort((a, b) => a.category!.compareTo(b.category!));
    notifyListeners();
  }

  applySorting({List<Product>? products}) {
    if (sorting == '1') {
      if (products == null) {
        sortNewArrival();
        Get.back(result: authService.allProducts);
      } else {
        sortWishlistedProds(products);
        Get.back(result: products);
      }
    } else if (sorting == '2') {
      if (products == null) {
        sortLowToHigh();
        Get.back(result: authService.allProducts);
      } else {
        sortLowToHighWishlist(products);
        Get.back(result: products);
      }
    } else if (sorting == '3') {
      if (products == null) {
        sortHighToLow();
        Get.back(result: authService.allProducts);
      } else {
        sortHighToLowWishlist(products);
        Get.back(result: products);
      }
    } else {
      if (products == null) {
        sortTopRated();
        Get.back(result: authService.allProducts);
      } else {
        sortTopRatedWishlist(products);
        Get.back(result: products);
      }
    }
  }
}
