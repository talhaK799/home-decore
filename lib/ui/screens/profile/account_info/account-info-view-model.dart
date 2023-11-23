import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/dialogs/limit_exceed_dialog.dart';
import 'package:get/get.dart';

import '../../../../locator.dart';

class AccountInfoViewModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();

  AccountInfoViewModel() {
    // getProfileData();
  }

 
}
