import 'dart:math';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/core/services/string_formate_service.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:f2_base_project/ui/screens/home/category_products/sub_category_screen.dart';
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
                      SizedBox(height: 60.h),

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
                                      backgroundColor: primaryColor,
                                      child: Icon(
                                        Icons.person,
                                        color: whiteColor,
                                        size: 35,
                                      ),
                                    )
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
                                          : 'please_login'.tr,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 15.0, left: 25),
                            child: Divider(color: greyColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text('categories'.tr,
                                style: normalTextStyleLato.copyWith(
                                    color: blackColor,
                                    fontSize: 15.sp,
                                    fontFamily: latoFont)),
                          ),
                          Container(
                            // height: 160.h,
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 7),
                              shrinkWrap: true,
                              primary: false,

                              // scrollDirection: Axis.horizontal,
                              itemCount: model.authService.categories.length,
                              itemBuilder: (context, index) {
                                return drawerTile(
                                  // model.authService.categories, index,
                                  onTap: () {
                                    Get.to(() => SubCategoryScreen(
                                        model.authService.categories[index]
                                            .title!,
                                        model.authService.categories[index]
                                            .id!));
                                  },

                                  title:
                                      '${model.authService.categories[index].title}'
                                          .tr,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),

                      ///
                      /// Settings and Logout
                      ///
                      Padding(
                        padding: EdgeInsets.only(bottom: 31.h),
                        child: Row(
                          children: [
                            SizedBox(width: 3.w),

                            SizedBox(width: 15.w),
                            // GestureDetector(
                            //   onTap: onLogout,
                            //   child: Row(children: [
                            //     Transform(
                            //         alignment: Alignment.center,
                            //         transform: Get.locale!.languageCode == 'ar'
                            //             ? Matrix4.rotationY(pi)
                            //             : Matrix4.rotationY(0),
                            //         child: Icon(
                            //           Icons.login_rounded,
                            //           color: primaryColor,
                            //         )),
                            //     Padding(
                            //       padding:
                            //           EdgeInsetsDirectional.only(start: 8.0),
                            //       child: Text(
                            //           model.authService.isLogin
                            //               ? 'logout'.tr
                            //               : 'login'.tr,
                            //           style: boldTextStyleHacen.copyWith(
                            //               fontSize: 17.sp,
                            //               color: blackColor,
                            //               fontFamily: latoFont)),
                            //     ),
                            //   ]),
                            // )
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

  Widget drawerTile({
    String? title,
    onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        trailing: Icon(Icons.arrow_forward_ios_rounded),
        title: Text('$title',
            style: normalTextStyleLato.copyWith(
                color: blackColor, fontSize: 15.sp, fontFamily: latoFont)),
      ),
    );
  }
}
