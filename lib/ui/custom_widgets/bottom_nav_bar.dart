import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/typedef.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final int pageIndex;

  BottomNavBar(this.pageIndex);

  onTap(int pageIndex) {
    if (pageIndex == 0) {
      Get.offAll(() => RootScreen(selectedPage: 0));
    } else if (pageIndex == 1) {
      // Get.offAll(() => ProductsScreen());
    } else if (pageIndex == 2) {
      Get.offAll(() => RootScreen(selectedPage: 2));
    } else if (pageIndex == 4) {
      print('NO SCREEN TO NAVIGATE');
    } else {
      Get.offAll(() => RootScreen(selectedPage: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      child: Container(
        height: 84.h,
        decoration: BoxDecoration(
            color: pageIndex == 2 ? Colors.white : primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        child: BottomAppBar(
          color: pageIndex == 2 ? Colors.white : primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home Screen
              pageIndex == 0
                  ? selectedIcon(icon: 'home_icon.png', onTap: () => onTap(0))
                  : GestureDetector(
                      onTap: () => onTap(0),
                      child: Image.asset(
                        '$staticAssets/home_icon.png',
                        width: 30.w,
                        height: 30.h,
                        color: pageIndex == 2 ? primaryColor : Colors.white,
                      ),
                    ),
              // Products Screen
              pageIndex == 1
                  ? selectedIcon(
                      icon: 'products_icon.png', onTap: () => onTap(1))
                  : GestureDetector(
                      onTap: () => onTap(1),
                      child: Image.asset(
                        '$staticAssets/products_icon.png',
                        width: pageIndex == 1 ? 38.w : 30.w,
                        height: pageIndex == 1 ? 38.h : 30.h,
                        color: pageIndex == 2 ? primaryColor : Colors.white,
                      ),
                    ),
              // Booking Screen
              pageIndex == 2
                  ? selectedIcon(
                      isBookingScreen: true,
                      icon: 'booking_icon.png',
                      onTap: () => onTap(2))
                  : GestureDetector(
                      onTap: () => onTap(2),
                      child: Image.asset(
                        '$staticAssets/booking_icon.png',
                        width: pageIndex == 2 ? 38.w : 30.w,
                        height: pageIndex == 2 ? 38.h : 30.h,
                        color: pageIndex == 2 ? primaryColor : Colors.white,
                      ),
                    ),
              // payment Screen
              pageIndex == 3
                  ? selectedIcon(
                      icon: 'payment_icon.png', onTap: () => onTap(3))
                  : GestureDetector(
                      onTap: () => onTap(3),
                      child: Image.asset(
                        '$staticAssets/payment_icon.png',
                        width: pageIndex == 3 ? 38.w : 30.w,
                        height: pageIndex == 3 ? 38.h : 30.h,
                        color: pageIndex == 2 ? primaryColor : Colors.white,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget selectedIcon(
      {String? icon, voidFunction? onTap, bool isBookingScreen = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            '$staticAssets/$icon',
            width: 38.w,
            height: 38.h,
            color: isBookingScreen ? primaryColor : Colors.white,
          ),
          SizedBox(height: 8.h),
          Container(
            height: 7.h,
            width: 7.w,
            decoration: BoxDecoration(
                color: isBookingScreen == true ? primaryColor : Colors.white,
                shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
