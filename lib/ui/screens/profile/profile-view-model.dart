import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';

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
}
