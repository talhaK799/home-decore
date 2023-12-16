import 'dart:io';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:f2_base_project/ui/screens/home/home_screen.dart';
import 'package:f2_base_project/ui/screens/notification/notification-screen.dart';
import 'package:f2_base_project/ui/screens/offers/offers_screen.dart';
import 'package:f2_base_project/ui/screens/orders-section/all_orders_screen.dart';
import 'package:f2_base_project/ui/screens/profile/profile-screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../locator.dart';

class RootProvider extends BaseViewModel {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedDate = 1;
  String? selectedMonth;
  List<Widget> allScreen = [];
  final authService = locator<AuthService>();

  PageController? pageController;
  int? pageIndex = 0;

  RootProvider(int selectedPage, String? selectedMonth,
      {int selectedDate = 1}) {
        getCategory();
    pageController = PageController(initialPage: 0);
    pageIndex = selectedPage;
    this.selectedDate = selectedDate;
    this.selectedMonth = selectedMonth;
    allScreen = [
      HomeScreen(),
      ProductsScreen(),
      OfferScreen(),
      ProfileScreen(),
      AllOrdersScreen(),
    ];
  }
  final _dbService = locator<DatabaseService>();


  getCategory()async{
    authService.categories = [];
    authService.categories =  await _dbService.getCategories();
    notifyListeners();
  }

  onTap(int pageIndex) {
    print('onPageChange $pageIndex');
    this.pageIndex = pageIndex;
    notifyListeners();
  }

  ///
  /// Back button dialog
  ///
  Future<bool> onWillPop() async {
    return await Get.defaultDialog(
            radius: 10,
            title: 'are_you_sure'.tr,
            middleText: 'want_to_exit'.tr,
            cancelTextColor: primaryColor,
            buttonColor: primaryColor,
            confirmTextColor: Colors.white,
            textCancel: 'cancell'.tr,
            textConfirm: 'okk'.tr,
            onCancel: () {},
            onConfirm: () => exit(0)) ??
        false;
  }

 

  
}
