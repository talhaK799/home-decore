import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/authentication_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_text_field.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/custom_widgets/radio_button.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:f2_base_project/ui/screens/auth_signup/signup/signup_view_model.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/privacy_policy/privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, index) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            progressIndicator: circularProgressIndicator(),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ///
                    /// ========== This Section Contain Back Button And Avatar =============
                    ///

                    customAppBarAndLogo(context),

                    ///
                    /// =============== This Section Contain Register Form ==============
                    ///

                    Container(
                      padding:
                          EdgeInsets.only(top: 35.h, left: 31.w, right: 31),
                      decoration:
                          topRoundedDecoration.copyWith(color: primaryColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///
                          /// Social Auth Buttons + Text Fields
                          ///
                          textFieldsAndSocialButtons(model, context),

                          // /// Row Contain remember me radio button
                          // genderAndLanguageSelection(model),
                          // SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget genderAndLanguageSelection(SignUpViewModel model) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10),
  //     child: Column(
  //       children: [
  //         ///
  //         /// gender and language
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               'gender'.tr + ':',
  //               style: TextStyle(fontSize: 12.sp, color: Colors.white),
  //             ),
  //             Row(
  //               children: [
  //                 Row(children: [
  //                   RadioButton(
  //                     value: 1,
  //                     groupValue: model.selectedGenter,
  //                     activeColor: Colors.white,
  //                     inActiveColor: Colors.white,
  //                     onChange: (value) {
  //                       model.setGender(1);
  //                     },
  //                   ),
  //                   Text(
  //                     "female".tr,
  //                     style: TextStyle(fontSize: 12.sp, color: Colors.white),
  //                   ),
  //                 ]),
  //                 Row(children: [
  //                   RadioButton(
  //                     value: 0,
  //                     groupValue: model.selectedGenter,
  //                     activeColor: Colors.white,
  //                     inActiveColor: Colors.white,
  //                     onChange: (value) {
  //                       model.setGender(0);
  //                     },
  //                   ),
  //                   Text(
  //                     "male".tr,
  //                     style: TextStyle(fontSize: 12.sp, color: Colors.white),
  //                   ),
  //                 ]),
  //               ],
  //             )
  //           ],
  //         ),

  //         /// terms and conditions checkbox
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             GestureDetector(
  //               onTap: () {
  //                 Get.to(() => PrivacyPolicyScreen());
  //               },
  //               child: Text('terms_and_conditions'.tr,
  //                   style: TextStyle(
  //                       decoration: TextDecoration.underline,
  //                       fontSize: 12.sp,
  //                       color: Colors.blue)),
  //             ),
  //             Expanded(
  //               child: Theme(
  //                 data: ThemeData(unselectedWidgetColor: Colors.white),
  //                 child: Checkbox(
  //                   checkColor: primaryColor,
  //                   activeColor: Colors.white,
  //                   value: model.isChecked,
  //                   onChanged: (bool? value) {
  //                     model.isChecked = value!;
  //                     model.setState(ViewState.idle);
  //                   },
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget customAppBarAndLogo(context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),

          ///
          /// custom app bar
          ///
          AuthenticationAppBar(
            leadingIcon: '$staticAssets/back.png',
            color: Colors.black,
            onBack: () {
              Get.back();
            },
            heading: "sign_up".tr,
          ),

          ///
          /// App Logo
          ///
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Center(
                child: Column(
              children: [
                Text('Logo',
                    style: headingTextStyleLato.copyWith(
                        fontSize: 30.sp, color: primaryColor)),
                // ImageContainer(
                //   assetImage: "$staticAssets/logo.png",
                //   height: 85.h,
                // ),
                SizedBox(height: 30.h),
                Text('Inna Home',
                    style: headingTextStyleLato.copyWith(
                        fontSize: 30.sp, color: primaryColor))
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget textFieldsAndSocialButtons(SignUpViewModel model, context) {
    return Form(
      key: model.formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// user name field
            Column(
              children: [
                CustomTextField(
                  errorColor: Colors.white,
                  prefixIcon: ImageContainer(
                    height: 22.h,
                    width: 22.w,
                    assetImage: "$assets/user_icon.png",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "username_required".tr;
                    } else {
                      return null;
                    }
                  },
                  hintText: "username".tr,
                  onSaved: (value) {
                    model.signUpBody.name = value;
                  },
                ),
                SizedBox(height: 18.h),

                /// Email name field
                CustomTextField(
                  errorColor: Colors.white,
                  prefixIcon: ImageContainer(
                    height: 18.3.h,
                    width: 18.3.w,
                    assetImage: "$staticAssets/email.png",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "email_required".tr;
                    } else {
                      bool emailValid = RegExp(
                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(value);
                      if (emailValid) {
                        return null;
                      } else {
                        if (value.contains(' ')) {
                          return null;
                        } else {
                          return "validate_email".tr;
                        }
                      }
                    }
                  },
                  // controller: model.isPasswordVisible,
                  hintText: "email".tr,
                  onChange: (value) {
                    model.signUpBody.email = value;
                  },
                ),

                SizedBox(height: 18.h),

                /// Password field
                CustomTextField(
                  errorColor: Colors.white,
                  prefixIcon: ImageContainer(
                    height: 20.h,
                    width: 14.9.w,
                    assetImage: "$staticAssets/password_icon.png",
                  ),
                  obscure: model.isPasswordVisible,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "password_required".tr;
                    }
                    if (value.length < 6) {
                      return "password_too_short".tr;
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: IconButton(
                      icon: Icon(
                        model.isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 18,
                      ),
                      onPressed: () {
                        model.setPasswrdVisibility();
                      },
                    ),
                  ),
                  controller: model.passwrdController,
                  hintText: "password".tr,
                  onSaved: (value) {
                    model.signUpBody.password = value;
                  },
                ),
              ],
            ),

            // /// Phone code and mobile no
            // CustomTextField(
            //   prefixIcon: ImageContainer(
            //     height: 18.3.h,
            //     width: 18.3.w,
            //     assetImage: "$staticAssets/phone_no.png",
            //   ),
            //   isMobile: true,
            //   isInputFormatter: true,
            //   errorColor: Colors.white,
            //   validator: (value) {
            //     if (value.isEmpty) {
            //       return "phone_required".tr;
            //     } else {
            //       return null;
            //     }
            //   },
            //   inputType: TextInputType.number,
            //   hintText: "mobile".tr,
            //   onChange: (value) {
            //     model.mobileNo = value.toString();
            //   },
            // ),

            // SizedBox(height: 18.h),

            ///
            /// SignUP Button
            ///
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      // if (model.formKey.currentState!
                      //     .validate()) {
                      model.formKey.currentState!.save();
                      model.signUpWithEmailAndPassword();
                      // }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(16.r)),
                      child: Text("Sign Up", style: buttonTextStyle),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "I have Already Account ?",
                      style: titleTextStyle.copyWith(color: greyColor),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "Sign In",
                          style: titleTextStyle.copyWith(color: whiteColor),
                        )),
                  ],
                ),
              ],
            ),

            SizedBox(height: 1.h),

            // /// Confirm Password field
            // CustomTextField(
            //   errorColor: Colors.white,
            //   prefixIcon: ImageContainer(
            //     height: 20.h,
            //     width: 14.9.w,
            //     assetImage: "$staticAssets/password_icon.png",
            //   ),
            //   controller: model.confirmPasswrdControler,
            //   obscure: model.isConfirmPasswordVisible,
            //   validator: (value) {
            //     if (value.isEmpty) {
            //       return "password_required".tr;
            //     } else if (value != model.passwrdController.text) {
            //       return "password_should_match".tr;
            //     } else {
            //       return null;
            //     }
            //   },
            //   suffixIcon: Padding(
            //     padding: EdgeInsets.only(bottom: 8.h),
            //     child: IconButton(
            //       icon: Icon(
            //         model.isConfirmPasswordVisible
            //             ? Icons.visibility_off
            //             : Icons.visibility,
            //         size: 18,
            //       ),
            //       onPressed: () {
            //         model.setConfirmPasswrdVisibility();
            //       },
            //     ),
            //   ),
            //   hintText: "confirm_password".tr,
            //   onSaved: (value) {
            //     model.signUpBody.confirmPassword = value;
            //   },
            // ),

            // SizedBox(height: 18.h),

            // /// Age field
            // CustomTextField(
            //   errorColor: Colors.white,
            //   prefixIcon: ImageContainer(
            //     height: 23.2.h,
            //     width: 25.w,
            //     assetImage: "$staticAssets/age.png",
            //   ),
            //   validator: (value) {
            //     // if (value.isEmpty) {
            //     //   return "age_required".tr;
            //     // } else {
            //     //   return null;
            //     // }
            //     return null;
            //   },
            //   inputType: TextInputType.number,
            //   hintText: "age".tr,
            //   onSaved: (value) {
            //     model.signUpBody.age = value;
            //   },
            // ),

            // SizedBox(height: 18.h),

            // /// Age field
            // CustomTextField(
            //   errorColor: Colors.white,
            //   prefixIcon: ImageContainer(
            //     height: 23.2.h,
            //     width: 25.w,
            //     assetImage: "$staticAssets/location_icon.png",
            //   ),
            //   validator: (value) {
            //     if (value.isEmpty) {
            //       return "age_required".tr;
            //     } else {
            //       return null;
            //     }
            //   },
            //   inputType: TextInputType.number,
            //   hintText: "location".tr,
            //   onSaved: (value) {
            //     model.signUpBody.age = value;
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
