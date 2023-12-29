import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:get/get.dart';
import '../../../../locator.dart';

class WishListProvider extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  bool isLoading = false;
  final authService = locator<AuthService>();
  List<Product> wishlistedProducts = [];

  WishListProvider() {
    getAllWishlistedProd();
  }

  getAllWishlistedProd() async {
    await getAllProducts();
  }

  Future getAllProducts() async {
    setState(ViewState.busy);
    authService.allProducts = await _dbService.getProducts();
    print('allProductsLength => ${authService.allProducts.length}');
    for (var prod in authService.allProducts) {
      if (prod.likedUserIds != null) {
        for (var id in prod.likedUserIds!) {
          if (id == authService.appUser.id) {
            wishlistedProducts.add(prod);
          }
        }
      }
    }
    print('Wishlisted Products => ${wishlistedProducts.length}');
    setState(ViewState.idle);
  }

  ///
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
        Get.snackbar(
            'whishlist_removed'.tr, 'removed_from_whislist',
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
