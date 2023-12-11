import 'package:f2_base_project/core/constants/lists.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/user_address.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:get/get.dart';
import '../../../../../locator.dart';

class AddCartAddressViewModel extends BaseViewModel {
  UserAddress userAddress = UserAddress(city: "Brussels");
  final _dbService = locator<DatabaseService>();
  final _authService = locator<AuthService>();
  bool isSearching = false;
  List<String> searchedCities = [];

  // filter by category name
  searchByName(String keyword) {
    // isShimmer = true;
    isSearching = keyword.isEmpty ? false : true;
    setState(ViewState.idle);
    searchedCities = cities
        .where((e) => (e.toLowerCase().contains(keyword.toLowerCase())))
        .toList();
    notifyListeners();
  }

  saveAddress(List<UserAddress> address) async {
    if (_authService.isLogin) {
      setState(ViewState.busy);
      userAddress.userId = _authService.appUser.id;
      userAddress.createdAt = DateTime.now();
      address.add(userAddress);
      await _dbService.saveAddress(userAddress, _authService.appUser.id!);
      Get.back(result: address);
    } else {
      Get.dialog(SignupRequiredDialog('productsScreen'));
    }
  }
}
