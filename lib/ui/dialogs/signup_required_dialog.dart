import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../locator.dart';

class SignupRequiredDialog extends StatelessWidget {
  final String redirectScreen;
  SignupRequiredDialog(this.redirectScreen);

  final _authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('oops'.tr),
      content: Text("signup_required".tr),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'cancel'.tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: () {
            Get.back();
            Get.to(() => LoginScreen());
          },
          child: Text(
            'login'.tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
