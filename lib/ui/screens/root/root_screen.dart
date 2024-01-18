import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/responsive.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/dialogs/signup_required_dialog.dart';
import 'package:f2_base_project/ui/screens/auth_signup/login/login_screen.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_screen.dart';
import 'package:f2_base_project/ui/screens/home/home_view_model.dart';
import 'package:f2_base_project/ui/screens/root/root_provider.dart';
import 'package:f2_base_project/ui/screens/side-menu-section/drawer/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

class RootScreen extends StatefulWidget {
  final int selectedDate;
  final String? selectedMonth;
  final selectedPage;
  RootScreen(
      {this.selectedPage = 0, this.selectedDate = 1, this.selectedMonth});

  @override
  _RootScreenState createState() => _RootScreenState();
}

final advancedDrawerController = AdvancedDrawerController();

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  bool isDrawerOpened = false;
  toggleAnimation() {
    if (animationController!.isDismissed) {
      isDrawerOpened = true;
      animationController!.forward();
    } else {
      animationController!.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    if (isDrawerOpened == true) {
      toggleAnimation();
    }

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RootProvider(
          widget.selectedPage, widget.selectedMonth,
          selectedDate: widget.selectedDate),
      child: Consumer<RootProvider>(
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () async {
              return model.onWillPop();
            },
            child: AdvancedDrawer(
              backdropColor: Colors.white,
              controller: advancedDrawerController,
              rtlOpening: Get.locale?.languageCode == 'ar',
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              animateChildDecoration: true,
              disabledGestures: false,
              drawer: DrawerScreen(),
              child: GestureDetector(
                onTap: () {
                  if (isDrawerOpened) {
                    toggleAnimation();
                  }
                },
                child: Scaffold(
                  key: model.scaffoldKey,
                  // drawer: DrawerScreen1(),
                  extendBody: true,
                  body: Column(
                    children: [
                      // model.pageIndex == 0
                      //     ? customAppBar(Provider.of<HomeViewModel>(context))
                      //     : Container(),
                      Expanded(child: model.allScreen[model.pageIndex!]),
                    ],
                  ),
                  bottomNavigationBar: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)),
                    child: Container(
                      height: Responsive.isMobile(context)
                          ? Platform.isIOS
                              ? 75.h
                              : 60.h
                          : 120.h,
                      padding: EdgeInsets.only(bottom: Platform.isIOS ? 15 : 0),
                      decoration: BoxDecoration(
                          color:
                              //  model.pageIndex == 3
                              //     ? Colors.white
                              //     :
                              primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: BottomAppBar(
                        color:
                            // model.pageIndex == 3 ? Colors.white :
                            primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Home Screen
                            model.pageIndex == 0
                                ? selectedIcon(
                                    icon: 'home_icon.png',
                                    onTap: () => model.onTap(0))
                                : GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => model.onTap(0),
                                    child: Image.asset(
                                      '$staticAssets/home_icon.png',
                                      width: Responsive.isMobile(context)
                                          ? 20.w
                                          : 30.w,
                                      height: Responsive.isMobile(context)
                                          ? 20.h
                                          : 30.h,
                                      color: model.pageIndex == 0
                                          ? primaryColor
                                          : Colors.white,
                                    ),
                                  ),
                            // Products Screen
                            model.pageIndex == 1
                                ? selectedIcon(
                                    icon: 'products_icon.png',
                                    onTap: () => model.onTap(1))
                                : GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => model.onTap(1),
                                    child: Image.asset(
                                      '$staticAssets/products_icon.png',
                                      width: Responsive.isMobile(context)
                                          ? 20
                                          : 30,
                                      height: Responsive.isMobile(context)
                                          ? 20
                                          : 30,
                                      color: model.pageIndex == 1
                                          ? primaryColor
                                          : Colors.white,
                                    ),
                                  ),

                            model.pageIndex == 2
                                ? selectedIcon(
                                    icon: 'profile.png',
                                    onTap: () {
                                      if (model.authService.isLogin) {
                                        model.onTap(2);
                                      } else {
                                        Get.dialog(
                                            SignupRequiredDialog('rootScreen'));
                                      }
                                    })
                                : GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      if (model.authService.isLogin) {
                                        model.onTap(2);
                                      } else {
                                        Get.dialog(
                                            SignupRequiredDialog('rootScreen'));
                                      }
                                    },
                                    child: Image.asset(
                                      '$staticAssets/profile.png',
                                      width: Responsive.isMobile(context)
                                          ? 20
                                          : 30,
                                      height: Responsive.isMobile(context)
                                          ? 20
                                          : 30,
                                      color: model.pageIndex == 2
                                          ? primaryColor
                                          : Colors.white,
                                    ),
                                  ),

                            model.pageIndex == 3
                                ? selectedIcon(
                                    icon: 'order_icon.png',
                                    onTap: () {
                                      if (model.authService.isLogin) {
                                        model.onTap(3);
                                      } else {
                                        Get.dialog(
                                            SignupRequiredDialog('rootScreen'));
                                      }
                                    })
                                : GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      if (model.authService.isLogin) {
                                        model.onTap(3);
                                      } else {
                                        Get.dialog(
                                            SignupRequiredDialog('rootScreen'));
                                      }
                                    },
                                    child: Image.asset(
                                      '$staticAssets/order_icon.png',
                                      width: Responsive.isMobile(context)
                                          ? 20
                                          : 30,
                                      height: Responsive.isMobile(context)
                                          ? 20
                                          : 30,
                                      color: model.pageIndex == 3
                                          ? primaryColor
                                          : Colors.white,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget selectedIcon(
      {String? icon, final onTap, bool isBookingScreen = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            '$staticAssets/$icon',
            width: Responsive.isMobile(context) ? 26.w : 35.w,
            height: Responsive.isMobile(context) ? 26.w : 35.w,
            color: isBookingScreen ? primaryColor : Colors.white,
          ),
          SizedBox(height: 5.h),
          Container(
            height: Responsive.isMobile(context) ? 4.w : 8.w,
            width: Responsive.isMobile(context) ? 4.w : 8.w,
            decoration: BoxDecoration(
                color: isBookingScreen == true ? primaryColor : Colors.white,
                shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }

  Widget customAppBar(HomeViewModel model) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) {
        return Container(
          color: primaryColor,
          height: Responsive.isMobile(context) ? 84.h : 130.h,
          child: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 30.h, 12.w, 0.h),
            child: Row(
              children: [
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Image.asset('$staticAssets/drawer_icon.png',
                          height: 20.h, width: 25.w),
                      onPressed: () {
                        print('open drawer');
                        toggleAnimation();
                        advancedDrawerController.showDrawer();
                        advancedDrawerController.value =
                            AdvancedDrawerValue.visible();
                        if (advancedDrawerController.value.visible == false) {
                          advancedDrawerController.showDrawer();
                          setState(() {});
                        }
                      },
                    ),
                    SizedBox(width: 7.w),
                    Text(
                      'sportsTalent'.tr,
                      style: normalTextStyleLato,
                    )
                  ],
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Container(
                    height: 30.h,
                    // width: 0.35.sw,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        model.searchByName(value);
                      },
                      onChanged: (value) {
                        model.searchByName(value);
                      },
                      decoration: InputDecoration(
                          suffixIcon: UnconstrainedBox(
                            child: ImageContainer(
                                height: 16.h,
                                width: 16.w,
                                assetImage: '$staticAssets/search.png'),
                          ),
                          contentPadding: EdgeInsets.only(left: 13, bottom: 17),
                          border: InputBorder.none,
                          hintText: 'Search products'.tr,
                          hintStyle: normalTextStyleLato.copyWith(
                              fontSize: 13.sp, color: Color(0xFFCFCFCF))),
                    ),
                  ),
                ),
                SizedBox(width: 11.w),
                IconButton(
                  constraints: BoxConstraints(maxHeight: 23),
                  padding: EdgeInsets.zero,
                  onPressed: () => Get.to(() => CartScreen()),
                  icon: Stack(
                    children: [
                      model.authService.order.id != null
                          ? Container(
                              height: 3.h,
                              width: 3.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: greyColor),
                            )
                          : Container(),
                      Image.asset('$staticAssets/cart_icon.png',
                          width: 21.06.w, height: 21.16.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// IconButton(
//   constraints: BoxConstraints(maxHeight: 23),
//   padding: EdgeInsets.zero,
//   onPressed: () => Get.to(() => SearchScreen()),
//   icon: Image.asset('$staticAssets/search_white.png',
//       width: 21.06.w, height: 21.16.h),
// ),
