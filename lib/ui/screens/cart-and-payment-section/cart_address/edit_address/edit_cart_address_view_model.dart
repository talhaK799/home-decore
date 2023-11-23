import 'package:f2_base_project/core/models/user_address.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/database_service.dart';

import '../../../../../locator.dart';

class EditCartAddressViewModel extends BaseViewModel {
  UserAddress editUserAddress = UserAddress();
  final _dbService = locator<DatabaseService>();

  EditCartAddressViewModel() {
    // editUserAddress = userAddress;
    // print(editUserAddress.addressId);
  }

  // void editCartAddress(
  //     UserAddressResponse userAddressResponse, int index) async {
  //   setState(ViewState.busy);
  //   late BaseResponse baseResponse;
  //   try {
  //     baseResponse = await _dbService.editUserAddress(editUserAddress);
  //     if (!baseResponse.success) {
  //       Get.dialog(RequestFailedDialog(errorMessage: baseResponse.error));
  //     } else {
  //       userAddressResponse.userAddressList[index] = editUserAddress;
  //       Get.back(result: userAddressResponse.userAddressList);
  //       notifyListeners();
  //     }
  //   } catch (e, s) {
  //     debugPrint('@additionUserAddress:Error');
  //     debugPrint(e.toString());
  //     debugPrint(s.toString());
  //     Get.dialog(RequestFailedDialog(errorMessage: e.toString()));
  //   }
  //   setState(ViewState.idle);
  // }
}
