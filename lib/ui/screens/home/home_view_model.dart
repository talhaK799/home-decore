import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/core/services/shared_prefs_service.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../locator.dart';

class HomeViewModel extends BaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  AuthService authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  final localStorage = locator<SharedPrefsService>();
  late PageController pageController;
  int currentImage = 0;
  bool isShimmer = false;
  bool isSearching = false;
  List<String> offersImages = [];
  List<Product> searchedProducts = [];
  String selectedLang = '';

  HomeViewModel() {
    pageController = PageController(initialPage: currentImage);
    init();
    selectedLang = localStorage.language;

    // getHelpLine();
  }

  init() async {
    isShimmer = true;
    setState(ViewState.idle);
    await getAppBanners();
    // getOffers();
    await getCategories();
    await getAllProducts();
    await getLatestProducts();
    await getTopRatedProducts();
    isShimmer = false;
    setState(ViewState.idle);
  }

  List<String> languages = ['en', 'fr', 'ne'];

  selectLang(val) async {
    selectedLang = val;
    Get.locale = Locale(selectedLang);
    await init();
    localStorage.updateSelectedLanguage(val);
    notifyListeners();
  }

  getHelpLine() async {
    setState(ViewState.busy);
    authService.helpline = await _dbService.getHelpline();
    setState(ViewState.idle);
  }

  Future getCategories() async {
    setState(ViewState.busy);
    authService.categories = [];
    authService.categories = await _dbService.getCategories();
    print('categoriesLength => ${authService.categories.length}');
    setState(ViewState.idle);
  }

  List<String> banner = [];
  Future getAppBanners() async {
    setState(ViewState.busy);
    authService.banners = await _dbService.getAppBanners();
    banner.add(authService.banners[1]);
    print('appBanners => ${authService.banners.length}');
    setState(ViewState.idle);
  }

  getAllProducts() async {
    isShimmer = true;

    authService.allProducts = await _dbService.getProducts();
    print(authService.allProducts[0].toJson());
    print('allProductsLength => ${authService.allProducts.length}');
    print(authService.allProducts[0].toJson());

    isShimmer = false;
    setState(ViewState.idle);
    notifyListeners();
  }

  Future getLatestProducts() async {
    isShimmer = true;
    setState(ViewState.idle);
    authService.latestProducts = await _dbService.getLatestProducts();
    print('latestProductsLength => ${authService.latestProducts.length}');
    isShimmer = false;
    setState(ViewState.idle);
  }

  Future getTopRatedProducts() async {
    isShimmer = true;
    setState(ViewState.idle);
    authService.topRatedProducts = await _dbService.getTopRatedProducts();
    print('topRatedProducts => ${authService.topRatedProducts.length}');

    isShimmer = false;
    setState(ViewState.idle);
  }

  Future getOffers() async {
    setState(ViewState.busy);
    authService.offers = await _dbService.getOffers();
    print('offers => ${authService.offers.length}');
    for (var offer in authService.offers) {
      offersImages.add(offer.imageUrl!);
    }
    setState(ViewState.idle);
  }

  // filter by category name
  searchByName(String keyword) {
    // isShimmer = true;
    isSearching = keyword.isEmpty ? false : true;
    setState(ViewState.idle);
    searchedProducts = authService.allProducts
        .where((e) => (e.name!.toLowerCase().contains(keyword.toLowerCase())))
        .toList();
    print('searchedproducts => $isSearching');
    notifyListeners();
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
