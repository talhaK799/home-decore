import 'dart:math';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/core/services/string_formate_service.dart';
import 'package:f2_base_project/responsive.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:f2_base_project/ui/screens/contact_us/contact_us_screen.dart';
import 'package:f2_base_project/ui/screens/notification/notification-screen.dart';
import 'package:f2_base_project/ui/screens/orders-section/all_orders_screen.dart';
import 'package:f2_base_project/ui/screens/profile/account_info/account-info-screen.dart';
import 'package:f2_base_project/ui/screens/profile/address_screen/address_screen.dart';
import 'package:f2_base_project/ui/screens/profile/edit_profile/edif-profile-screen.dart';
import 'package:f2_base_project/ui/screens/profile/language/language_settings_screen.dart';
import 'package:f2_base_project/ui/screens/profile/profile-view-model.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/faq/FAQ_screen.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/privacy_policy/privacy_policy_screen.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/wishlist/wishlist_screen.dart';
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

            body: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //back button

                  backButton(model),

                  //user avatar nd edit profile button
                  userInfoAndAvatar(model),

                  //account setting  tile
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.0),
                              topRight: Radius.circular(24.0))),
                      child: ListView(
                        children: [
                          settingTiles(model),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  backButton(model) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
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
                      color: primaryColor,
                      fontWeight: FontWeight.normal,
                      fontSize: Responsive.isMobile(context) ? 20.sp : 26.sp,
                    ))
              ],
            ),
          ),
          Container(
              // height: 40.94.h,
              child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              model.authSerivce.appUser = await Get.to(() => EditProfileScreen(
                      userProfile: model.authSerivce.appUser)) ??
                  model.authSerivce.appUser;
              setState(() {});
            },
          )),
        ],
      ),
    );
  }

  userInfoAndAvatar(ProfileViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.3, bottom: 20.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            model.authSerivce.appUser.imageUrl == null
                ? CircleAvatar(
                    radius: Responsive.isMobile(context) ? 50.r : 70.r,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: whiteColor,
                    ))
                : CircleAvatar(
                    radius: Responsive.isMobile(context) ? 50.r : 70.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        NetworkImage('${model.authSerivce.appUser.imageUrl}'),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 16.4, bottom: 5.3),
              child: Text(
                '${convertToTitleCase(model.authSerivce.appUser.name ?? "John Kellis")}',
                style: headingTextStyleLato.copyWith(
                    fontSize: Responsive.isMobile(context) ? 14 : 20),
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
                  style: bodyTextStyleLato.copyWith(
                      fontSize: 13, color: blackColor),
                )
              ],
            ),
//edit profle button
          ],
        ),
      ),
    );
  }

  settingTiles(ProfileViewModel model) {
    return Padding(
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
          // ContactUsScreen
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
          _tile(
              title: "Language Settings".tr,
              ontap: () {
                print("presed");
                Get.to(() => LanguageSettingScreen());
              }),

          _tile(
              title: "Contact Us".tr,
              ontap: () {
                print("presed");
                Get.to(() => ContactUsScreen());
              }),

          _tile(
            ontap: () => Get.to(WishlistScreen()),
            title: 'wishlist'.tr,
          ),

          _tile(
            ontap: () => Get.to(NotificationScreen()),
            title: 'notifications'.tr,
          ),

          _tile(
            ontap: () => Get.to(FaqScreen()),
            title: 'faqs'.tr,
          ),

          _tile(
            ontap: () => Get.to(PrivacyPolicyScreen()),
            title: 'Terms and Conditions'.tr,
          ),

          _tile(
              title: 'Logout'.tr,
              ontap: () {
                model.authSerivce.isLogin
                    ? Get.dialog(
                        AlertDialog(
                          title: Text("Logout".tr),
                          content: Text("to_logout".tr),
                          actions: [
                            ElevatedButton(
                              child: Text("yes".tr),
                              onPressed: () async {
                                // toggleAnimation();
                                // animationController!.reverse();

                                Get.back();

                                model.logOut();
                              },
                            ),
                            ElevatedButton(
                              child: Text("no".tr),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      )
                    : Get.dialog(
                        AlertDialog(
                          title: Text("login".tr),
                          content: Text("are_you_sure_to_login".tr),
                          actions: [
                            ElevatedButton(
                              child: Text("yes".tr),
                              onPressed: () {
                                Get.to(() => LoginScreen());
                              },
                            ),
                            ElevatedButton(
                              child: Text("no".tr),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      );
              }),
          SizedBox(height: 15.6.h),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
          //   child: RectangularButton(
          //     title: 'Logout',
          //     radius: 6,
          //     buttonColor: greyColor,
          //     textStyle: bodyTextStyleLato.copyWith(color: Colors.white),
          //     onTap: () async {
          //       await model.authSerivce.logout();
          //       Get.offAll(() => LoginScreen());
          //     },
          //   ),
          // ),
          SizedBox(height: 30.6.h),
        ],
      ),
    );
  }

  _tile({title, ontap}) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.5,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$title",
                    style: bodyTextStyleLato.copyWith(
                        fontSize: Responsive.isMobile(context) ? 14.sp : 20.sp,
                        color: Colors.white),
                  ),
                  Transform(
                    alignment: Alignment.center,
                    transform: Get.locale!.languageCode == 'ar'
                        ? Matrix4.rotationY(pi)
                        : Matrix4.rotationY(0),
                    child: ImageContainer(
                      assetImage: "$assets/forward.png",
                      height: Responsive.isMobile(context) ? 9.14.h : 15,
                      width: Responsive.isMobile(context) ? 5.85.w : 15,
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
