import 'dart:developer';

import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/app_user.dart';
import 'package:f2_base_project/core/models/custom_auth_result.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/core/services/shared_prefs_service.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  var isPasswordVisible = true;
  var isConfirmPasswordVisible = true;
  int? selectedGenter;
  var passwrdController = TextEditingController();
  var locationController = TextEditingController();
  var countryCodeController = TextEditingController();
    var phoneNumber = TextEditingController();

  var confirmPasswrdControler = TextEditingController();
  AppUser signUpBody = AppUser();
  CustomAuthResult authResult = CustomAuthResult();
  AuthService _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  AppUser appUser = AppUser();
  int selectedLangCode = 0;
  final _sharedPrefsService = locator<SharedPrefsService>();
  bool isChecked = false;
  String countryCode = '';
  String mobileNo = '';

  void signUpWithEmailAndPassword() async {
    setState(ViewState.busy);

    authResult = await _authService.signUpWithEmailPassword(appUser);
    log('$authResult');
    if (authResult.status!) {
      print("User logged in successfully");
      _authService.isLogin = true;
      Get.offAll(() => RootScreen());
      notifyListeners();
    } else {
      setState(ViewState.idle);
      Get.dialog(AlertDialog(
        title: Text("Error"),
        content: Text("${authResult.errorMessage}"),
        actions: [
          ElevatedButton(child: Text("Ok"), onPressed: () => Get.back())
        ],
      ));
      notifyListeners();
    }
    setState(ViewState.idle);
    notifyListeners();
  }

  void loginWithEmailAndPassword() async {
    setState(ViewState.busy);
    authResult = await _authService.loginWithEmailPassword(
        email: appUser.email, password: appUser.password);
    log('$authResult');
    if (authResult.status!) {
      print("User logged in successfully");
      _authService.isLogin = true;
      Get.offAll(() => RootScreen());
      notifyListeners();
    } else {
      setState(ViewState.idle);
      Get.dialog(AlertDialog(
        title: Text("Error"),
        content: Text("${authResult.errorMessage}"),
        actions: [
          ElevatedButton(child: Text("Ok"), onPressed: () => Get.back())
        ],
      ));
      notifyListeners();
    }
    setState(ViewState.idle);
    notifyListeners();
  }

  loginWithFacebook() async {
    setState(ViewState.busy);

    setState(ViewState.idle);
  }

  signUpWithGoogle() async {
    setState(ViewState.busy);

    setState(ViewState.idle);
  }

  setPasswrdVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  setConfirmPasswrdVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  setGender(newValue) {
    selectedGenter = newValue;
    notifyListeners();
  }
}
