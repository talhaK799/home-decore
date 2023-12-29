import 'dart:math';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/settings/setting_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationON = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
      child: Consumer<SettingsViewModel>(
        builder: (context, model, child) {
          return BaseScreen(
            topPadding: 91,
            appBarChild: CustomAppBar(
              leadingIcon: '$staticAssets/back_icon.png',
              title: 'settings'.tr,
            ),
            body: model.state == ViewState.busy
                ? circularProgressIndicator()
                : Padding(
                    padding: EdgeInsets.fromLTRB(30.w, 70.h, 30.w, 0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'notifications'.tr,
                              style:
                                  bodyTextStyleLato.copyWith(fontSize: 17.sp),
                            ),
                            InkWell(
                                onTap: () {
                                  model.authService.isLogin
                                      ? model.toggleNotification(
                                          !model.notificationStatus)
                                      : Get.dialog(SignupRequiredDialog(
                                          'settingScreen'));
                                },
                                child: Transform.scale(
                                  scale: 5.2,
                                  child: Opacity(
                                    opacity: model.notificationStatus ? 1 : 0.6,
                                    child: Container(
                                      height: 27.13.h,
                                      width: 57.22.w,
                                      padding: EdgeInsets.zero,
                                      // color: Colors.orange,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fitHeight,
                                              image: AssetImage(
                                                model.notificationStatus
                                                    ? "$assets/switch_on.png"
                                                    : "$assets/switch_off.png",
                                              ))),
                                      // child: SvgPicture.string(switch_string),
                                    ),
                                  ),
                                )),
                            // CupertinoSwitch(
                            //     activeColor: primaryColor, value: true, onChanged: null),
                          ],
                        ),
                        SizedBox(height: 29.h),
                        divider(),
                        SizedBox(height: 23.h),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'language'.tr,
                        //       style:
                        //           bodyTextStyleLato.copyWith(fontSize: 17.sp),
                        //     ),
                        //     Container(
                        //       height: 30.h,
                        //       padding: EdgeInsets.symmetric(
                        //         horizontal: 9,
                        //       ),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(9.0),
                        //         color: primaryColor,
                        //       ),

                        //       /// Drop down
                        //       child: DropdownButtonHideUnderline(
                        //         child: DropdownButton<String>(
                        //           dropdownColor:
                        //               primaryColor.withOpacity(0.9),
                        //           style: bodyTextStyleLato.copyWith(
                        //               color: primaryColor,
                        //               letterSpacing: 0,
                        //               fontSize: 16),
                        //           value: model.selectedLangCode.toUpperCase(),
                        //           icon: Icon(Icons.keyboard_arrow_down,
                        //               size: 15, color: Colors.white),
                        //           elevation: 0,
                        //           onChanged: (val) {
                        //             model.changeLanguage(val!);
                        //           },
                        //           items: model.languages
                        //               .map<DropdownMenuItem<String>>(
                        //                   (String value) {
                        //             return DropdownMenuItem<String>(
                        //               value: value,
                        //               child: Text(
                        //                 value,
                        //                 style: bodyTextStyleLato.copyWith(
                        //                     color: Colors.white,
                        //                     letterSpacing: 0,
                        //                     fontSize: 16.sp),
                        //               ),
                        //             );
                        //           }).toList(),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // SizedBox(height: 23.h),
                        divider(),
                        SizedBox(height: 23.h),
                        InkWell(
                          // onTap: () => Get.to(() => AboutUsScreen()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'about_inna_home'.tr,
                                style:
                                    bodyTextStyleLato.copyWith(fontSize: 17.sp),
                              ),
                              IconButton(
                                icon: Transform(
                                  alignment: Alignment.center,
                                  transform: Get.locale!.languageCode == 'ar'
                                      ? Matrix4.rotationY(pi)
                                      : Matrix4.rotationY(0),
                                  child: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.black, size: 30.h),
                                ),
                                onPressed: null,
                                // Get.to(() => AboutUsScreen()),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 23.h),
                        divider(),
                        SizedBox(height: 23.h),
                        InkWell(
                          onTap: () async {
                            await launch('https://play.google.com/store/apps');
                            // Get.to(() => RateUsScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('rate_us'.tr,
                                  style: bodyTextStyleLato.copyWith(
                                      fontSize: 17.sp)),
                              IconButton(
                                icon: Transform(
                                  alignment: Alignment.center,
                                  transform: Get.locale!.languageCode == 'ar'
                                      ? Matrix4.rotationY(pi)
                                      : Matrix4.rotationY(0),
                                  child: Icon(Icons.keyboard_arrow_right,
                                      color: Colors.black, size: 30.h),
                                ),
                                onPressed: () async {
                                  await launch(
                                      'https://play.google.com/store/apps');
                                  // Get.to(() => RateUsScreen());
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  divider() {
    return Container(color: greyColor.withOpacity(0.8), height: 0.5.h);
  }
}
