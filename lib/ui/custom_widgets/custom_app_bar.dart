import 'dart:math';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/constants/typedef.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final String? leadingIcon;
  final String? firstIcon;
  final String? secondIcon;
  final voidFunction? firstIconOnTap;
  final voidFunction? secondIconOnTap;
  final voidFunction? onLeadingPressed;

  CustomAppBar(
      {this.title,
      this.firstIcon,
      this.secondIcon,
      this.leadingIcon,
      this.onLeadingPressed,
      this.firstIconOnTap,
      this.secondIconOnTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Transform(
                  alignment: Alignment.center,
                  transform: Get.locale!.languageCode == 'ar'
                      ? Matrix4.rotationY(pi)
                      : Matrix4.rotationY(0),
                  child: Image.asset('$leadingIcon', height: 18.h, width: 9.w)),
              onPressed: onLeadingPressed ??
                  () {
                    Get.back();
                  },
            ),
            SizedBox(width: 8.w),
            Text(
              '$title',
              style: normalTextStyleLato.copyWith(fontSize: 18.sp),
            )
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: firstIconOnTap,
              child: firstIcon != null
                  ? Image.asset('$firstIcon', width: 29.w, height: 29.h)
                  : Container(),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: secondIconOnTap,
              child: secondIcon != null
                  ? Image.asset(
                      '$secondIcon',
                      width: 27.98,
                      height: 28.61.h,
                    )
                  : Container(),
            )
          ],
        )
      ],
    );
  }
}
