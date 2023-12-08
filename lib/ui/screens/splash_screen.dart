import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/connectivity_helper.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/notification_service.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/dialogs/network_error_dialog.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:f2_base_project/ui/screens/auth_signup/signup/signup_screen.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../locator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = locator<AuthService>();
  // final _dbService = locator<DatabaseService>();
  final _notificationService = locator<NotificationsService>();

  @override
  void initState() {
    _initialSetup();
    super.initState();
  }

  _initialSetup() async {
    final connectivityResult = await checkInternetConnectivity();

    ///
    /// If not connected to internet, show an alert dialog
    /// to activate the network connection.
    ///
    if (connectivityResult == false) {
      Get.dialog(NetworkErrorDialog());
      return;
    }

    ////
    ///initializing notification services
    ///
    await _notificationService.initConfigure();

    await _authService.init();
    await Future.delayed(Duration(seconds: 1));
    print('Login State: ${_authService.isLogin}');

    if (_authService.isLogin) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RootScreen()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => RootScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: whiteColor,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageContainer(
                      assetImage: '$staticAssets/logoo.png',
                      height: 200.h,
                      width: 200.h,
                      fit: BoxFit.contain),
                  // SizedBox(height: 30.h),
                  // Text('HORITOKI',
                  //     style: headingTextStyleLato.copyWith(
                  //         color: primaryColor, fontSize: 30.sp))
                ],
              ),
            ),
          )),
    );
  }
}
