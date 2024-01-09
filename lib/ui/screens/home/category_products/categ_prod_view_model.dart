import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/offers.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:get/get.dart';
import '../../../../locator.dart';

class CategProdViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final authService = locator<AuthService>();
  List<Product> products = [];
  List<SubCategory> subCategory = [];

  CategProdViewModel(
      String category, bool isFromOffer, Offers? offer, String CategoryId) {
    getCategProducts(category, isFromOffer, offer, CategoryId);
    getSubCategories(category, isFromOffer, offer, CategoryId);
  }

  getCategProducts(String category, bool isFromOffer, Offers? offer,
      String categoryId) async {
    setState(ViewState.busy);
    products = await _dbService.getCategoryProducts(categoryId);
    print('categoryProducts => ${products.length}');
    if (isFromOffer) {
      for (var prod in products) {
        if (prod.discountPercentage != null) {
          if (int.parse(offer!.percentage!) != 0) {
            calculateDiscountSalePrice(prod, offer);
          } else {
            calculateFlatSalePrice(prod, offer);
          }
        } else {
          calculateFlatSalePrice(prod, offer!);
        }
      }
    }
    setState(ViewState.idle);
  }

  getSubCategories(String category, bool isFromOffer, Offers? offer,
      String categoryId) async {
    print('object');
    setState(ViewState.busy);
    subCategory = await _dbService.getSubCategories(categoryId);
    print('........${subCategory.length}');

    // print('SubCategoreis => ${products.length}');
    // if (isFromOffer) {
    //   for (var prod in products) {
    //     if (prod.discountPercentage != null) {
    //       if (int.parse(offer!.percentage!) != 0) {
    //         calculateDiscountSalePrice(prod, offer);
    //       } else {
    //         calculateFlatSalePrice(prod, offer);
    //       }
    //     } else {
    //       calculateFlatSalePrice(prod, offer!);
    //     }
    //   }
    // }
    setState(ViewState.idle);
  }

  calculateDiscountSalePrice(Product product, Offers offer) {
    var sale = 0.0;
    print('offerDiscount => ${offer.percentage}');
    print('offerFlatDiscount => ${offer.flatDiscount}');
    if (offer.percentage != null && product.salePrice != null) {
      sale = (int.parse(offer.percentage!) / 100) * product.salePrice!;
      print('sale => $sale');
      sale = product.salePrice! - sale;
      product.salePrice = sale;
    }
  }

  calculateFlatSalePrice(Product product, Offers offer) {
    if (offer.flatDiscount != null &&
        int.parse(offer.flatDiscount!) != 0 &&
        product.price != null) {
      product.salePrice = product.salePrice! - int.parse(offer.flatDiscount!);
    }
    setState(ViewState.idle);
  }

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
        Get.snackbar('whishlist_added'.tr, 'added_to_whishlist'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('whishlist_removed'.tr, 'removed_from_whislist'.tr,
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
}
