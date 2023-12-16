
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/authentication_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_text_field.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/screens/auth_signup/signup/signup_screen.dart';
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
                textFieldsLowerHalfScreen(context, model),
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
            color: blackColor,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageContainer(
                  assetImage: "$staticAssets/logoo.png",
                  height: 150.h,
                  // width: 150.w,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  textFieldsLowerHalfScreen(context, LoginViewModel model) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.66,
      padding: EdgeInsets.only(top: 35, left: 31, right: 31),
      decoration: topRoundedDecoration.copyWith(color: primaryColor),
      child: Form(
        key: model.formKey,
        child: Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              // SizedBox(height: 10,),

              Column(
                children: [
                  ////
                  /// Email
                  ///
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: CustomTextField(
                      errorColor: Colors.white,
                      prefixIcon: Image.asset(
                        "$assets/IconEmail.png",
                        color: greyColor,
                        height: 26.h,
                        width: 26.w,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter the email".tr;
                        } else {
                          return null;
                        }
                      },
                      hintText: "Enter the Email".tr,
                      onChange: (value) {
                        model.appUser.email = value;
                      },
                    ),
                  ),

                  ///
                  /// Password
                  ///
                  CustomTextField(
                    obscure: model.isShowPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        model.showPassword();
                      },
                      icon: Icon(
                        model.isShowPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                    errorColor: Colors.white,
                    prefixIcon: Image.asset(
                      "$assets/pass.png",
                      color: greyColor,
                      height: 20.h,
                      width: 20.w,
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter the passoword".tr;
                      } else {
                        return null;
                      }
                    },
                    hintText: "Enter the Password".tr,
                    onChange: (value) {
                      model.appUser.password = value;
                    },
                  ),

                  SizedBox(
                    height: 60.h,
                  )
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: TextButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         "Forgot Password",
                  //         style: boldTextStyleLato.copyWith(
                  //             color: whiteColor,
                  //             decoration: TextDecoration.underline,
                  //             decorationColor: whiteColor,
                  //             decorationThickness: 2),
                  //       )),
                  // )
                ],
              ),

              ///
              /// Donot Have an account ?
              ///
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///
                  /// Login Button
                  ///
                  model.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                              backgroundColor: primaryColor))
                      : GestureDetector(
                          onTap: () {
                            if (model.formKey.currentState!.validate()) {
                              model.loginWithEmailAndPassword();
                            }
                          },
                          child: Container(
                            // alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 9.h, horizontal: 50.w),
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(16.r)),
                            child: Text("Login", style: buttonTextStyle),
                          ),
                        ),
                  SizedBox(
                    height: 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(SignUpScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have an Account? ",
                          style: bodyTextStyleHacen.copyWith(
                            color: whiteColor,
                            fontSize: 11.sp,
                          ),
                        ),
                        Text(" Register ",
                            style: bodyTextStyleHacen.copyWith(
                                fontSize: 13.sp,
                                decorationColor: whiteColor,
                                decorationThickness: 2,
                                decoration: TextDecoration.underline,
                                color: whiteColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ]),

        // SizedBox(height: 30.h),

        // Text('OR',
        //     style: headingTextStyleLato.copyWith(
        //         fontSize: 30.sp, color: Colors.white)),
        // SizedBox(height: 30.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Expanded(
        //       child: Container(
        //           // width: 147.w,
        //           child: RectangularButton(
        //               radius: 15,
        //               buttonColor: Colors.white,
        //               textStyle: TextStyle(
        //                   fontSize: 18.sp, color: Color(0xFFF55858)),
        //               title: 'Login with Facebook'.tr,
        //               onTap: () {
        //                 model.signUpWithFacebook();
        //                 // model.appUser.email = model.appUser.email!.trim();
        //                 // if (model.formKey.currentState!.validate()) {
        //                 //   model.formKey.currentState!.save();
        //                 //   model.loginWithEmailAndPassword();
        //                 // }
        //               })),
        //     ),
        //   ],
        // ),
        // SizedBox(height: 30.h),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Expanded(
        //       child: Container(
        //           // width: 147.w,
        //           child: RectangularButton(
        //               radius: 15,
        //               buttonColor: Colors.white,
        //               textStyle: TextStyle(
        //                   fontSize: 18.sp, color: Color(0xFFF55858)),
        //               title: 'Login with Google'.tr,
        //               onTap: () {
        //                 model.signUpWithGoogle();
        //                 // model.appUser.email = model.appUser.email!.trim();
        //                 // if (model.formKey.currentState!.validate()) {
        //                 //   model.formKey.currentState!.save();
        //                 //   model.loginWithEmailAndPassword();
        //                 // }
        //               })),
        //     ),
        //   ],
        // )
      ),
    );
  }
}
