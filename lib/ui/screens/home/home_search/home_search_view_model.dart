import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/dialogs/request_failed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../locator.dart';

class HomeSearchViewModel extends BaseViewModel {
  // ProductResponse productResponse = ProductResponse(true);
  final _dbService = locator<DatabaseService>();
  String? searchingText;

  // void searchProducts() async {
  //   setState(ViewState.busy);
  //   if (searchingText != null) {
  //     try {
  //       productResponse = await _dbService.getSearchedProducts(
  //           searchingText!, Get.locale!.languageCode);

  //       if (!productResponse.success) {
  //         Get.dialog(RequestFailedDialog(errorMessage: productResponse.error));
  //       } else {
  //         print(
  //             "Searched Products list length => ${productResponse.baseProduct.products.length}");
  //         Get.back(result: productResponse.baseProduct.products);
  //       }
  //     } catch (e, s) {
  //       debugPrint('@gettingAllProducts:Eoor');
  //       debugPrint(e.toString());
  //       debugPrint(s.toString());
  //       Get.dialog(RequestFailedDialog(errorMessage: e.toString()));
  //     }
  //   }
  //   setState(ViewState.idle);
  // }
}
