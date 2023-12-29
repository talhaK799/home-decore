import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/notifications.dart';
import 'package:f2_base_project/core/models/order.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/models/user_address.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/core/services/notification_service.dart';
import 'package:f2_base_project/ui/dialogs/checkout_dialog.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:f2_base_project/ui/screens/orders-section/all_orders_screen.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../locator.dart';

class CartViewModel extends BaseViewModel {
  ///
  /// Cart Screen Working Area
  ///
  final _dbService = locator<DatabaseService>();
  final authService = locator<AuthService>();
  int productQuantity = 1;
  bool isLoading = false;
  int pageIndex = 0;
  int selectedAddress = 0;
  TabController? tabController;
  List<UserAddress> addresses = [];
  Notifications notification = Notifications();
  NotificationsService notificationsService = NotificationsService();

  CartViewModel(var obj) {
    tabController = TabController(length: 2, vsync: obj, initialIndex: 0);
    getUserAddress();
  }

  checkout() async {
    if (authService.isLogin) {
      if (addresses.isNotEmpty) {
        if (authService.order.products != null) {
          if (authService.order.products!.length > 0) {
            Get.dialog(CheckoutDialog(
              title: 'verify_before_checkout'.tr,
              errorMessage:
                  '${'total_price'.tr}: € ${double.parse(authService.order.totalPrice!).toStringAsFixed(2)}\nAddress: ${addresses[selectedAddress].address} ${addresses[selectedAddress].city}\nMobile no:  +32 ${addresses[selectedAddress].phone}',
              onChange: () async {
                Get.back();
                isLoading = true;
                notifyListeners();
                int totalProducts = 0;
                for (var prod in authService.order.products!) {
                  totalProducts = totalProducts + prod.count!;
                }
                authService.order.deliveryCharges =
                    addresses[selectedAddress].city == 'Peshawar' ? 70 : 130;
                authService.order.totalProducts = totalProducts.toString();
                authService.order.appUser = authService.appUser;
                authService.order.userAddress = addresses[selectedAddress];
                authService.order.createdAt = DateTime.now();
                authService.order.orderStatus = placed;
                notification.createdAt = DateTime.now();
                notification.userId = authService.appUser.id;
                notification.title = 'Order Placed';
                notification.content = 'Order id: ${authService.order.orderId}';
                notification.notificationType = 'order';
                print('order => ${authService.order.toJson()}');
                for (int i = 0; i < authService.allProducts.length; i++) {
                  for (int j = 0; j < authService.order.products!.length; j++) {
                    if (authService.allProducts[i].name ==
                        authService.order.products![j].name) {
                      authService.allProducts[i].stock =
                          authService.allProducts[i].stock! -
                              authService.order.products![j].count!;
                      await _dbService
                          .updateProductStock(authService.allProducts[i]);
                    }
                  }
                }
                await _dbService.checkout(authService.order);
                await _dbService.addNotification(notification);
                await _dbService.deleteCartToDB(authService.appUser.id!);
                authService.order = Orders();
                Get.off(RootScreen());
                Get.snackbar('order_success'.tr, 'your_order_is_placed'.tr,
                    onTap: (value) {
                  Get.to(() => AllOrdersScreen());
                });
                isLoading = false;
                notifyListeners();
              },
            ));
          }
        }
      } else {
        Get.snackbar('add_address'.tr, 'add_address_for_check_out'.tr,
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.dialog(SignupRequiredDialog('productsScreen'));
    }
  }

  getUserAddress() async {
    if (authService.isLogin) {
      isLoading = true;
      setState(ViewState.busy);
      addresses = await _dbService.getAddresses(authService.appUser.id!);
      print('addresses => ${addresses.length}');
      isLoading = false;
      setState(ViewState.idle);
    }
  }

  deleteAddress(UserAddress address) async {
    print('deleteAddress');
    isLoading = true;
    notifyListeners();
    addresses.remove(address);
    await _dbService.deleteAddress(authService.appUser.id, address.addressId);
    isLoading = false;
    notifyListeners();
  }

  void selectAddress(index) {
    selectedAddress = index;
    print("Selected Address => $selectedAddress");
    notifyListeners();
  }

  incrementProducts(Product product, Orders order, {double? sizePrice}) async {
    if (product.sizes != null) {
      if (product.sizes!.isNotEmpty) {
        int addCount = 0;
        for (var prod in product.sizes!) {
          print('with sizes');
          addCount += 1;
          prod.count = prod.count! + 1;
        }
        order.totalPrice =
            '${double.parse(order.totalPrice!) + product.salePrice!}';
        product.count = product.count! + addCount;
      } else {
        print('without sizes');
        product.count = product.count! + 1;
        order.totalPrice =
            '${double.parse(order.totalPrice!) + product.salePrice!}';
      }
    } else {
      print('without sizes');
      product.count = product.count! + 1;
      order.totalPrice =
          '${double.parse(order.totalPrice!) + product.salePrice!}';
    }
    print('count => ${product.count}');
    await addCartToDB();
    setState(ViewState.idle);
  }

  addCartToDB() async {
    await _dbService.addCartToDB(authService.appUser.id!, authService.order);
  }

  decrementProducts(Product product, Orders order, {double? sizePrice}) async {
    if (product.count! > 1) {
      if (product.sizes != null) {
        if (product.sizes!.isNotEmpty) {
          int removeCount = 0;
          for (var prod in product.sizes!) {
            if (prod.count! > 1) {
              removeCount += 1;
              prod.count = prod.count! - 1;
            }
          }
          if (removeCount > 0) {
            order.totalPrice =
                '${double.parse(order.totalPrice!) - product.salePrice!}';
          } else {
            await removeFromCart(product, order);
          }
          product.count = product.count! - removeCount;
        } else {
          if (product.count! > 1) {
            product.count = product.count! - 1;
            order.totalPrice =
                '${double.parse(order.totalPrice!) - product.salePrice!}';
          }
        }
      } else {
        if (product.count! > 1) {
          product.count = product.count! - 1;
          order.totalPrice =
              '${double.parse(order.totalPrice!) - product.salePrice!}';
        }
      }
      await addCartToDB();
    } else {
      await removeFromCart(product, order);
    }
    setState(ViewState.idle);
  }

  removeFromCart(Product product, Orders ordr) async {
    Get.defaultDialog(
        title: 'remove_from_cart'.tr,
        middleText: 'do_you_want_to_remove_this'.tr,
        onCancel: () {},
        buttonColor: primaryColor,
        confirmTextColor: Colors.white,
        cancelTextColor: primaryColor,
        onConfirm: () async {
          authService.order.products!.remove(product);
          Get.back();
          setState(ViewState.busy);
          if (authService.order.products == null) {
            await _dbService.deleteCartToDB(authService.appUser.id!);
          } else {
            ordr.totalPrice =
                '${double.parse(ordr.totalPrice!) - product.salePrice!}';
            await addCartToDB();
          }
          Orders? order =
              await _dbService.getCartProducts(authService.appUser.id!);
          authService.order = order ?? Orders();
          setState(ViewState.idle);
        });
  }

  deleteProduct() async {
    Get.defaultDialog(
        title: 'are_you_sure'.tr,
        middleText:
            'do_you_really_want_to_delete_all_the_products_from_the_cart'.tr,
        buttonColor: primaryColor,
        confirmTextColor: Colors.white,
        cancelTextColor: primaryColor,
        onCancel: () {},
        onConfirm: () async {
          Get.back();
          setState(ViewState.busy);
          authService.order.products = [];
          authService.order.totalPrice = '0.0';
          authService.order = Orders();
          await _dbService.deleteCartToDB(authService.appUser.id!);
          setState(ViewState.idle);
          // order.products!.remove(product);
          // if (product.sizes == null) {
          //   // order.totalPrice =
          //   //     '${double.parse(order.totalPrice!) - (product.count! * product.salePrice!)}';
          // } else {
          //   double calAmount = 0.0;
          //   for (var size in product.sizes!) {
          //     print('&&&&&&&&&& ${product.cartSalePrice!}');
          //     print('********* ${size.count! * product.cartSalePrice!}');
          //     calAmount = calAmount + (size.count! * product.cartSalePrice!);
          //   }
          //   print('calAmount => $calAmount');
          //   // order.totalPrice = '${double.parse(order.totalPrice!) - calAmount}';
          // }
          // setState(ViewState.idle);
          // Get.back();
        });
  }

  goBack() {
    Get.back(result: authService.order.products);
  }
}
