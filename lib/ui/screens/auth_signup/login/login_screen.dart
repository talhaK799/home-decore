import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/authentication_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_text_field.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'login_view_model.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, model, child) => ModalProgressHUD(
        inAsyncCall: model.state == ViewState.busy,
        progressIndicator: circularProgressIndicator(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ///
                /// ========== This Section Contain Back Button And App Logo =============
                ///
                customAppBarAndLogo(context),

                ///
                /// =============== This Section Contain Login Form ==============
                ///
                textFieldsLowerHalfScreen(context, model)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customAppBarAndLogo(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 60.h),

          ///
          /// custom app bar
          ///
          AuthenticationAppBar(
            leadingIcon: '$staticAssets/back.png',
            color: primaryColor,
            onBack: () => Get.back(),
            heading: "login".tr,
          ),

          ///
          /// App Logo
          ///
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Center(
                child: Column(
              children: [
                ImageContainer(
                  assetImage: "$staticAssets/login-logo.png",
                  height: 150.h,
                  // width: 150.w,
                ),
                // SizedBox(height: 10.h),
              ],
            )),
          ),
        ],
      ),
    );
  }

  textFieldsLowerHalfScreen(context, LoginViewModel model) {
    return Container(
      height: 0.6.sh,
      padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 31.w),
      decoration: topRoundedDecoration.copyWith(color: primaryColor),
      child: Form(
        key: model.formKey,
        child: Column(
          children: [
            SizedBox(height: 20.h),

            /// user name field
            // CustomTextField(
            //   errorColor: Colors.white,
            //   prefixIcon: ImageContainer(
            //     height: 22.h,
            //     width: 22.w,
            //     assetImage: "$assets/email.png",
            //   ),
            //   validator: (value) {
            //     if (value.isEmpty) {
            //       return "Email is required".tr;
            //     } else {
            //       return null;
            //     }
            //   },
            //   hintText: "email",
            //   onChange: (value) {
            //     model.appUser.email = value;
            //   },
            // ),

            // SizedBox(height: 20.h),
            // CustomTextField(
            //   obscure: true,
            //   errorColor: Colors.white,
            //   prefixIcon: ImageContainer(
            //     height: 22.h,
            //     width: 22.w,
            //     assetImage: "$assets/password_icon.png",
            //   ),
            //   validator: (value) {
            //     if (value.isEmpty) {
            //       return "Password is required".tr;
            //     } else {
            //       return null;
            //     }
            //   },
            //   hintText: "password",
            //   onChange: (value) {
            //     model.appUser.password = value;
            //   },
            // ),

            CustomTextField(
              errorColor: Colors.white,
              prefixIcon: ImageContainer(
                height: 22.h,
                width: 22.w,
                assetImage: "$assets/phone_no.png",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "phone_required".tr;
                } else {
                  return null;
                }
              },
              hintText: "017XXXXXXXX".tr,
              onChange: (value) {
                model.appUser.mobileNo = value;
              },
            ),

            SizedBox(height: 20.h),

            ///
            /// Login Button
            ///
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: model.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                              backgroundColor: primaryColor))
                      : Container(
                          // width: 147.w,
                          child: RectangularButton(
                              radius: 15,
                              buttonColor: Colors.white,
                              textStyle: TextStyle(
                                  fontSize: 18.sp, color: Color(0xFFF55858)),
                              title: 'login'.tr,
                              onTap: () {
                                if (model.appUser.mobileNo != null) {
                                  model.loginWithPhoneNo();
                                }
                                // model.loginWithEmailAndPassword();
                                // model.appUser.email = model.appUser.email!.trim();
                                // if (model.formKey.currentState!.validate()) {
                                //   model.formKey.currentState!.save();
                                //   model.loginWithEmailAndPassword();
                                // }
                              })),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            Text('OR',
                style: headingTextStyleLato.copyWith(
                    fontSize: 30.sp, color: Colors.white)),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      // width: 147.w,
                      child: RectangularButton(
                          radius: 15,
                          buttonColor: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 18.sp, color: Color(0xFFF55858)),
                          title: 'Login with Facebook'.tr,
                          onTap: () {
                            model.signUpWithFacebook();
                            // model.appUser.email = model.appUser.email!.trim();
                            // if (model.formKey.currentState!.validate()) {
                            //   model.formKey.currentState!.save();
                            //   model.loginWithEmailAndPassword();
                            // }
                          })),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      // width: 147.w,
                      child: RectangularButton(
                          radius: 15,
                          buttonColor: Colors.white,
                          textStyle: TextStyle(
                              fontSize: 18.sp, color: Color(0xFFF55858)),
                          title: 'Login with Google'.tr,
                          onTap: () {
                            model.signUpWithGoogle();
                            // model.appUser.email = model.appUser.email!.trim();
                            // if (model.formKey.currentState!.validate()) {
                            //   model.formKey.currentState!.save();
                            //   model.loginWithEmailAndPassword();
                            // }
                          })),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
