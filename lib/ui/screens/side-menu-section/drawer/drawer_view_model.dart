import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:get/get.dart';

import '../../../../locator.dart';

class DrawerViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  

  DrawerViewModel(){
    print("Lenght ===> ${authService.categories.length}");
  
  }
 


  void logOut() async {
    setState(ViewState.busy);
    authService.logout();
    Get.to(() => LoginScreen());
    setState(ViewState.idle);
  }
}
