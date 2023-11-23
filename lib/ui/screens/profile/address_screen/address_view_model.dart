import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/user_address.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:flutter/material.dart';
import '../../../../locator.dart';

class AddressViewModel extends BaseViewModel {
  ///
  /// Cart Screen Working Area
  ///
  final _dbService = locator<DatabaseService>();
  final authService = locator<AuthService>();
  int productQuantity = 1;
  bool isLoading = false;
  int pageIndex = 0;
  int selectedAddress = 0;
  List<UserAddress> addresses = [];

  AddressViewModel() {
    getUserAddress();
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
}
