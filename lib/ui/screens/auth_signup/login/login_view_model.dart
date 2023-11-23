import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/app_user.dart';
import 'package:f2_base_project/core/models/fcm.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/models/custom_auth_result.dart';
import '../../../../locator.dart';

class LoginViewModel extends BaseViewModel {
  TextEditingController locationController = TextEditingController();
  final _authService = locator<AuthService>();
  final _dbService = locator<DatabaseService>();
  CustomAuthResult authResult = CustomAuthResult();
  final formKey = GlobalKey<FormState>();
  Fcm fcm = Fcm();
  AppUser appUser = AppUser();
  bool isShowPassword = true;
  bool isLoading = false;
  final pinPutController = TextEditingController();
  final pinPutFocusNode = FocusNode();

  showPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  signUpWithFacebook() async {
    setState(ViewState.busy);
    authResult = await _authService.signupWithFacebook();
    if (authResult.status!) {
      print("Facebook user created successfully");
      _authService.appUser = await _dbService.getAppUser(authResult.user.id);
      final newToken = await FirebaseMessaging.instance.getToken();
      _authService.appUser.fcmToken = newToken;
      await _dbService.updateUserFcm(newToken, authResult.user.id);
      Get.offAll(() => RootScreen());
    } else {
      Get.dialog(AlertDialog(
        title: Text("Error"),
        content: Text("Sigining with Facebook"),
        actions: [
          ElevatedButton(child: Text("Ok"), onPressed: () => Get.back())
        ],
      ));
    }
    setState(ViewState.idle);
  }

  signUpWithGoogle() async {
    setState(ViewState.busy);
    authResult = await _authService.loginWithGoogle();
    if (authResult.status!) {
      print("Facebook user created successfully");
      _authService.appUser =
          await _dbService.getAppUser(_authService.appUser.id);
      final newToken = await FirebaseMessaging.instance.getToken();
      _authService.appUser.fcmToken = newToken;
      await _dbService.updateUserFcm(newToken, _authService.appUser.id);
      Get.offAll(() => RootScreen());
    } else {
      Get.dialog(AlertDialog(
        title: Text("Error"),
        content: Text("Sigining with Google"),
        actions: [
          ElevatedButton(child: Text("Ok"), onPressed: () => Get.back())
        ],
      ));
    }
    setState(ViewState.idle);
  }

  loginWithPhoneNo() async {
    isLoading = true;
    setState(ViewState.busy);
    print('phoneNumber => +88${appUser.mobileNo}');
    await _authService.sendCodeToPhone(phoneNumber: '${appUser.mobileNo}');
    print('verificationCodeSent');
    setState(ViewState.idle);
  }

  void loginWithEmailAndPassword() async {
    setState(ViewState.busy);
    authResult = await _authService.loginWithEmailPassword(
        email: appUser.email, password: appUser.password);
    if (authResult.status!) {
      print("User logged in successfully");
      _authService.isLogin = true;
      Get.offAll(() => RootScreen());
    } else {
      Get.dialog(AlertDialog(
        title: Text("Error"),
        content: Text("${authResult.errorMessage}"),
        actions: [
          ElevatedButton(child: Text("Ok"), onPressed: () => Get.back())
        ],
      ));
    }
    setState(ViewState.idle);
  }

  verifyOTP(String otp) async {
    setState(ViewState.busy);
    print('OTP => $otp');
    await _authService.verifyPhone(otp, appUser.mobileNo);
    if (_authService.isPhoneVerified) {
      _authService.isLogin = true;
      isLoading = false;
      Get.offAll(() => RootScreen());
    }
    setState(ViewState.idle);
  }

  geBack() {
    isLoading = false;
    notifyListeners();
    Get.back();
  }
}
