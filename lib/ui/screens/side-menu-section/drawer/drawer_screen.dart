import 'dart:math';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/core/services/string_formate_service.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:f2_base_project/ui/screens/notification/notification-screen.dart';
import 'package:f2_base_project/ui/screens/offers/offers_screen.dart';
import 'package:f2_base_project/ui/screens/profile/profile-screen.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:f2_base_project/ui/screens/shop-section/all-product/products_screen.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/drawer/drawer_view_model.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/privacy_policy/privacy_policy_screen.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../faq/FAQ_screen.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DrawerViewModel(),
      child: Consumer<DrawerViewModel>(
        builder: (context, model, child) {
          return ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            child: Drawer(
                elevation: 0.0,
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ///
                      /// Profile data
                      ///
                      InkWell(
                        onTap: () {
                          model.authService.isLogin
                              ? Get.to(() => ProfileScreen())
                              : Get.dialog(SignupRequiredDialog('rootScreen'));
                        },
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 22.9.w, top: 40.h, bottom: 10.2.h),
                          child: Row(
                            children: [
                              model.authService.appUser.imageUrl == null
                                  ? CircleAvatar(
                                      radius: 35.r,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('$profilePlaceHolder'))
                                  : CircleAvatar(
                                      radius: 35.r,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                          '${model.authService.appUser.imageUrl}'),
                                    ),
                              SizedBox(width: 15.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 3.0, bottom: 3),
                                    child: Text(
                                      model.authService.isLogin
                                          ? '${convertToTitleCase(model.authService.appUser.name ?? ' ')}'
                                          : 'Please Login',
                                      style: boldTextStyleLato.copyWith(
                                        fontSize: 14.sp,
                                        color: blackColor,
                                      ),
                                    ),
                                  ),
                                  model.authService.isLogin
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: primaryColor,
                                              size: 20.h,
                                            ),
                                            Text(
                                              ' ${model.authService.appUser.location ?? ""}',
                                              style:
                                                  normalTextStyleLato.copyWith(
                                                fontSize: 13.sp,
                                                color: blackColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 15.h),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 25),
                            child: Divider(color: greyColor),
                          ),
                          SizedBox(height: 25.h),
                          drawerTile(
                              onTap: () => model.authService.isLogin
                                  ? Get.to(ProfileScreen())
                                  : Get.dialog(
                                      SignupRequiredDialog('rootScreen')),
                              image: '$staticAssets/profile_icon.png',
                              title: 'profile'.tr,
                              width: 20.w,
                              height: 20.h),
                          SizedBox(height: 20.4.h),
                          drawerTile(
                              onTap: () => Get.to(() => ProductsScreen()),
                              image: '$staticAssets/shop.png',
                              title: 'shop'.tr,
                              width: 20.w,
                              isShop: true,
                              height: 20.h),
                          SizedBox(height: 20.4.h),
                          drawerTile(
                              onTap: () => model.authService.isLogin
                                  ? Get.to(WishlistScreen())
                                  : Get.dialog(
                                      SignupRequiredDialog('WishlistScreen')),
                              image: '$staticAssets/like.png',
                              title: 'wishlist'.tr,
                              width: 20.w,
                              height: 20.h),
                          SizedBox(height: 20.4.h),
                          drawerTile(
                              onTap: () => model.authService.isLogin
                                  ? Get.to(NotificationScreen())
                                  : Get.dialog(SignupRequiredDialog(
                                      'notificationScreen')),
                              image: '$staticAssets/notifications.png',
                              title: 'notifications'.tr,
                              width: 20.w,
                              height: 20.h),
                          SizedBox(height: 20.4.h),
                          drawerTile(
                              onTap: () => Get.to(() => OfferScreen()),
                              image: '$staticAssets/payment_icon.png',
                              title: 'Offers'.tr,
                              width: 20.w,
                              height: 20.h),
                          SizedBox(height: 20.4.h),
                          drawerTile(
                              onTap: () => Get.to(FaqScreen()),
                              image: '$staticAssets/faq_icon.png',
                              title: 'faqs'.tr,
                              width: 20.w,
                              height: 20.h),
                          SizedBox(height: 20.4.h),
                          drawerTile(
                              onTap: () async {
                                const url = "https://m.me/horitokibd";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              image: '$staticAssets/email.png',
                              title: 'Contact Us'.tr,
                              width: 20.w,
                              height: 20.h),
                          SizedBox(height: 20.4.h),
                          drawerTile(
                              onTap: () async {
                                String url =
                                    "tel:${model.authService.helpline.number ?? '+8801309007585'}";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              image: '$staticAssets/phone_no.png',
                              title: 'Helpline'.tr,
                              width: 20.w,
                              height: 20.h),
                          SizedBox(height: 20.4.h),
                          drawerTile(
                              onTap: () => Get.to(PrivacyPolicyScreen()),
                              image: '$staticAssets/privacy_icon.png',
                              title: 'Terms and Conditions'.tr,
                              width: 20.w,
                              height: 20.h),
                          SizedBox(height: 60.h),
                        ],
                      ),

                      ///
                      /// Settings and Logout
                      ///
                      Padding(
                        padding: EdgeInsets.only(bottom: 31.h),
                        child: Row(
                          children: [
                            SizedBox(width: 20.w),
                            // Icon(Icons.settings, color: primaryColor),
                            // GestureDetector(
                            //   onTap: () {
                            //     Get.to(SettingsScreen());
                            //   },
                            //   child: Padding(
                            //     padding: EdgeInsetsDirectional.only(start: 8.0),
                            //     child: Text('settings'.tr,
                            //         style: boldTextStyleLato.copyWith(
                            //             fontSize: 17.sp, color: blackColor)),
                            //   ),
                            // ),
                            // SizedBox(width: 15.w),
                            // Container(
                            //   width: 1.w,
                            //   color: Colors.black,
                            //   height: 17.9.h,
                            // ),
                            SizedBox(width: 15.w),
                            GestureDetector(
                              onTap: () {
                                model.authService.isLogin
                                    ? model.logOut()
                                    : Get.to(() => LoginScreen());
                              },
                              child: Row(children: [
                                Transform(
                                  alignment: Alignment.center,
                                  transform: Get.locale!.languageCode == 'ar'
                                      ? Matrix4.rotationY(pi)
                                      : Matrix4.rotationY(0),
                                  child: Image.asset(
                                      '$staticAssets/logout_icon.png',
                                      width: 25.7.w,
                                      height: 21.9.h),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 8.0),
                                  child: Text(
                                      model.authService.isLogin
                                          ? 'logout'.tr
                                          : 'login'.tr,
                                      style: boldTextStyleHacen.copyWith(
                                          fontSize: 17.sp,
                                          color: blackColor,
                                          fontFamily: latoFont)),
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }

  Widget drawerTile(
      {String? image,
      String? title,
      double? height,
      double? width,
      onTap,
      isShop = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 35.w),
        child: Row(
          children: [
            isShop
                ? Image.asset(
                    '$image',
                    height: height,
                    width: width,
                  )
                : Image.asset(
                    '$image',
                    height: height,
                    width: width,
                    color: primaryColor,
                  ),
            SizedBox(width: 20.6.w),
            Text('$title',
                style: normalTextStyleLato.copyWith(
                    color: blackColor, fontSize: 15.sp, fontFamily: latoFont)),
          ],
        ),
      ),
    );
  }
}
