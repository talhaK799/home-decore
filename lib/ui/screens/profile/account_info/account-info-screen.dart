import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/screens/profile/account_info/account-info-view-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AccountInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccountInfoViewModel(),
      child: Consumer<AccountInfoViewModel>(
        builder: (context, model, child) {
          return BaseScreen(
            topPadding: 91,

            ///
            ///appbar body
            ///
            appBarChild: CustomAppBar(
              leadingIcon: '$staticAssets/back_icon.png',
              onLeadingPressed: () {
                Get.back();
              },
              title: 'Account Info'.tr,
            ),

            ///
            ///[body]
            ///
            body: SingleChildScrollView(
              child: Column(children: [
                accountInfo(model),
              ]),
            ),
          );
        },
      ),
    );
  }

  accountInfo(AccountInfoViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 24, top: 40),
      child: Column(
        children: [
          model.authService.appUser.imageUrl == null
              ? CircleAvatar(
                  radius: 50.r,
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.person,
                    color: whiteColor,
                    size: 45,
                  ),
                )
              : CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      NetworkImage('${model.authService.appUser.imageUrl}'),
                ),
          SizedBox(height: 30.h),
          Divider(
            thickness: 0.4,
          ),
          tile(
            label: "name".tr,
            value: "${model.authService.appUser.name ?? " "}",
          ),
          tile(
            label: "email".tr,
            value: "${model.authService.appUser.email ?? " "}",
          ),
          tile(
            label: "mobile".tr,
            value: "${model.authService.appUser.mobileNo ?? " "}",
          ),
          tile(
            label: "gender".tr,
            value: "${model.authService.appUser.gender ?? " "}",
          ),
          tile(
            label: "location".tr,
            value: "${model.authService.appUser.location ?? " "}",
          ),
          tile(
            label: "Date of birth".tr,
            value: "${model.authService.appUser.dob ?? " "}",
          ),
        ],
      ),
    );
  }

  tile({
    label,
    value,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 26.1, top: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$label",
                style: bodyTextStyleLato.copyWith(
                    fontSize: 20.sp, color: primaryColor),
              ),
              SizedBox(width: 10.w),
              Flexible(
                child: Text(
                  "$value",
                  style: bodyTextStyleLato.copyWith(fontSize: 16.sp),
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 0.4,
        ),
      ],
    );
  }
}
