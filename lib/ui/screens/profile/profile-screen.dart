import 'dart:math';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/core/services/string_formate_service.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:f2_base_project/ui/custom_widgets/rounded-raised-button.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:f2_base_project/ui/screens/orders-section/all_orders_screen.dart';
import 'package:f2_base_project/ui/screens/profile/account_info/account-info-screen.dart';
import 'package:f2_base_project/ui/screens/profile/address_screen/address_screen.dart';
import 'package:f2_base_project/ui/screens/profile/edit_profile/edif-profile-screen.dart';
import 'package:f2_base_project/ui/screens/profile/profile-view-model.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            ///
            ///[body] starts here
            ///

            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //back button

                    backButton(),

                    //user avatar nd edit profile button
                    userInfoAndAvatar(model),

                    //account setting  tile
                    settingTiles(model),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  backButton() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          //back button
          Transform(
              alignment: Alignment.center,
              transform: Get.locale!.languageCode == 'ar'
                  ? Matrix4.rotationY(pi)
                  : Matrix4.rotationY(0),
              child: IconButton(
                icon: Image.asset('$staticAssets/back_icon.png',
                    height: 22.h, width: 11.w, color: primaryColor),
                onPressed: () {
                  Get.offAll(RootScreen());
                },
              )),
          SizedBox(width: 24.w),
          Text("profile".tr,
              style: headingTextStyleLato.copyWith(
                  color: primaryColor, fontWeight: FontWeight.normal))
        ],
      ),
    );
  }

  userInfoAndAvatar(ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 47.3, bottom: 33.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            model.authSerivce.appUser.imageUrl == null
                ? CircleAvatar(
                    radius: 50.r,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: whiteColor,
                    ))
                : CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        NetworkImage('${model.authSerivce.appUser.imageUrl}'),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 16.4, bottom: 5.3),
              child: Text(
                '${convertToTitleCase(model.authSerivce.appUser.name ?? "John Kellis")}',
                style: headingTextStyleLato.copyWith(fontSize: 14),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: primaryColor,
                ),
                SizedBox(width: 4.8.w),
                Text(
                  "${model.authSerivce.appUser.location ?? "London UK"}",
                  style: bodyTextStyleLato.copyWith(fontSize: 13,color: blackColor),
                )
              ],
            ),
//edit profle button
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 15.0),
              child: Container(
                  height: 40.94.h,
                  child: RoundedRaisedButton(
                    text: "edit_profile".tr,
                    onPressed: () async {
                      model.authSerivce.appUser = await Get.to(() =>
                              EditProfileScreen(
                                  userProfile: model.authSerivce.appUser)) ??
                          model.authSerivce.appUser;
                      setState(() {});
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

  settingTiles(ProfileViewModel model) {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24.0, right: 24.0, top: 10.6, bottom: 102),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _tile(
                title: "account_info".tr,
                ontap: () {
                  print("presed");
                  Get.to(() => AccountInfoScreen());
                }),
            _tile(
                title: "my_addresses".tr,
                ontap: () {
                  print("presed");
                  Get.to(() => AddressScreen());
                }),
            _tile(
                title: "my_orders".tr,
                ontap: () {
                  print("presed");
                  Get.to(() => AllOrdersScreen());
                }),
            SizedBox(height: 15.6.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: RectangularButton(
                title: 'Logout',
                radius: 6,
                buttonColor: greyColor,
                textStyle: bodyTextStyleLato.copyWith(color: Colors.white),
                onTap: () async {
                  await model.authSerivce.logout();
                  Get.offAll(() => LoginScreen());
                },
              ),
            ),
            SizedBox(height: 30.6.h),
          ],
        ),
      ),
    );
  }

  _tile({title, ontap}) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.5,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 27.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$title",
                    style: bodyTextStyleLato.copyWith(
                        fontSize: 14.sp, color: Colors.white),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Get.locale!.languageCode == 'ar'
                        ? Matrix4.rotationY(pi)
                        : Matrix4.rotationY(0),
                    child: ImageContainer(
                      assetImage: "$assets/forward.png",
                      height: 9.14.h,
                      width: 5.85.w,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
