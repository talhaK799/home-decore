import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/ui/custom_widgets/authentication_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:f2_base_project/ui/dialogs/limit_exceed_dialog.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
// import 'package:pinput/pinput.dart';

class EnterOtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (context, model, child) {
      return ModalProgressHUD(
        progressIndicator: circularProgressIndicator(),
        inAsyncCall: model.state == ViewState.busy,
        child: WillPopScope(
          onWillPop: () => model.geBack(),
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
                    /// =============== This Section Contain OTP Fields and Verify button ==============
                    ///
                    otpFieldsLowerHalfScreen(context, model),
                  ],
                ),
              )),
        ),
      );
    });
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
            heading: "Enter OTP".tr,
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

  otpFieldsLowerHalfScreen(context, LoginViewModel model) {
    return Container(
      height: 0.6.sh,
      padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 31.w),
      decoration: topRoundedDecoration.copyWith(color: primaryColor),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Text('Enter OTP'.tr,
              style: headingTextStyleLato.copyWith(color: Colors.white)),
          SizedBox(height: 20.h),
          Text(
            'Enter the verification code'.tr +
                ' \n' +
                'received by SMS/Call'.tr, //${model.customerUser.phoneNumber}',
            textAlign: TextAlign.center,
            style: bodyTextStyleLato.copyWith(color: Colors.white),
          ),
          SizedBox(height: 40.h),

          ///
          /// Enter otp fields (boxes)
          ///
          _otpField(model),

          /// Row Contain remember me radio button
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () async {
                    model.loginWithPhoneNo();
                  },
                  child: Text(
                    "Resend otp".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 60.h),

          ///
          /// Login Button
          ///
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 0.5.sw,
                  height: 50.h,
                  child: RectangularButton(
                      radius: 10,
                      buttonColor: Colors.white,
                      textStyle:
                          TextStyle(fontSize: 18.sp, color: Color(0xFFF55858)),
                      title: "VERIFY & CONTINUE",
                      onTap: () {
                        print(model.pinPutController.text);
                        if (model.pinPutController.text.isEmpty) {
                          Get.dialog(LimitExceedDialog(
                              errorMessage:
                                  'Please enter OTP received by SMS'));
                        } else {
                          model.verifyOTP(model.pinPutController.text);
                        }
                      })),
            ],
          )
        ],
      ),
    );
  }

  Widget _otpField(LoginViewModel model) {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: primaryColor,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: Colors.white,
      ),
    );

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Pinput(
              length: 6,
              showCursor: true,

              errorTextStyle:
                  headingTextStyleLato.copyWith(color: Colors.white),
              //  fieldsCount: 6,
              // withCursor: true,

              // textStyle: headingTextStyleLato.copyWith(color: Colors.white),
              // eachFieldWidth: 40.0,
              // eachFieldHeight: 40.0,
              focusNode: model.pinPutFocusNode,
              controller: model.pinPutController,
              // submittedFieldDecoration: pinPutDecoration,
              // selectedFieldDecoration: pinPutDecoration,
              // followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
            ),
          ),
        ),
      ],
    );
  }
}
