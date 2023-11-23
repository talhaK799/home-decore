import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/core/services/device_info_service.dart';
import 'package:f2_base_project/core/services/shared_prefs_service.dart';
import 'package:f2_base_project/ui/dialogs/language_change_dialog.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../locator.dart';

class SettingsViewModel extends BaseViewModel {
  List<String> languages = ["EN", "AR"];
  final _sharedPrefsService = locator<SharedPrefsService>();
  final _dbService = locator<DatabaseService>();
  final authService = locator<AuthService>();
  String selectedLangCode = Get.locale!.languageCode;
  late bool notificationStatus;

  init() async {
    setState(ViewState.busy);
    notificationStatus = await _sharedPrefsService.getNotificationSatus();
    selectedLangCode = Get.locale!.languageCode;
    debugPrint(
        '@SettingViewModel.constructor: Lang: $selectedLangCode,  Notifications_status: $notificationStatus');
    setState(ViewState.idle);
  }

  SettingsViewModel() {
    init();
  }

  toggleNotification(bool val) async {
    // setState(ViewState.busy);
    notificationStatus = val;
    notifyListeners();
    await _sharedPrefsService.updateNotificationStatus(val);
    if (val == false) {
    } else {
    }
    debugPrint('@toggleNotificaiton=> Status: $val');
    setState(ViewState.idle);
  }

  changeLanguage(String val) async {
    if (val.toLowerCase() != selectedLangCode) {
      final newLocale = Locale(val.toLowerCase());
      final shouldChange = await Get.dialog(
          LanguageChangeAlertDialog(
            message: 'change_lang_msg'.tr,
          ),
          barrierDismissible: false);
      if (shouldChange) {
        _sharedPrefsService.updateSelectedLanguage(val.toLowerCase());
        Get.updateLocale(newLocale);
        Get.offAll(() => RootScreen());
      }
    }
    setState(ViewState.idle);
  }
}
