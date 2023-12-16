import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:get/get.dart';

import '../../../locator.dart';

class ProfileViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final authSerivce = locator<AuthService>();

  ProfileViewModel() {
    // getUserProfile();
  }

  getUserProfile() async {
    setState(ViewState.busy);
    
    setState(ViewState.idle);
  }

   void logOut() async {
    setState(ViewState.busy);
    authSerivce.logout();
    Get.to(() => LoginScreen());
    setState(ViewState.idle);
  }
}
