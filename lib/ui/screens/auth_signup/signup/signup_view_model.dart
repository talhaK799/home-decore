import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/app_user.dart';
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

  var confirmPasswrdControler = TextEditingController();
  AppUser signUpBody = AppUser();
  AuthService _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  int selectedLangCode = 0;
  final _sharedPrefsService = locator<SharedPrefsService>();
  bool isChecked = false;
  String countryCode = '';
  String mobileNo = '';

  void signUpWithEmailAndPassword() async {
    setState(ViewState.busy);
    Get.offAll(() => RootScreen());
    setState(ViewState.idle);
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
