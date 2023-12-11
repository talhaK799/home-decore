import 'dart:math';

import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/typedef.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationAppBar extends StatelessWidget {
  final voidFunction? onBack;
  final String? heading;
  final String? leadingIcon;
  final Color? color;
  final isHeadingBold;
  AuthenticationAppBar(
      {this.onBack,
      this.heading,
      this.leadingIcon,
      this.color,
      this.isHeadingBold = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack,
      child: Row(
        children: [
          SizedBox(width: 8.w),
          leadingIcon == null
              ? Container()
              : Transform(
                  alignment: Alignment.center,
                  transform: Get.locale!.languageCode == 'ar'
                      ? Matrix4.rotationY(pi)
                      : Matrix4.rotationY(0),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onBack,
                    icon: Image.asset(
                      '$leadingIcon',
                      width: 20.w,
                      height: 20.h,
                      color: color,
                    ),
                  )),
          SizedBox(width: 4.w),
          Text("${heading!}",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: blackColor,
                  fontWeight:
                      isHeadingBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
