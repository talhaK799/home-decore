import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';

final TextStyle normalTextStyleLato =
    TextStyle(color: Colors.white, fontSize: 20.sp, fontFamily: latoFont
        // fontFamily: hacenFont,
        );
final TextStyle headingTextStyleLato = TextStyle(
  color: Colors.black,
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
  fontFamily: latoFont,
);
final TextStyle boldTextStyleHacen = TextStyle(
    color: primaryColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    fontFamily: hacenFontHd);

final TextStyle boldTextStyleLato = TextStyle(
    color: primaryColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    fontFamily: latoFont);

final TextStyle bodyTextStyleLato =
    TextStyle(color: Colors.black, fontSize: 16.sp, fontFamily: latoFont);

final TextStyle bodyTextStyleHacen =
    TextStyle(color: Colors.black, fontSize: 16.sp, fontFamily: hacenFont);

final TextStyle underLineTextStyle = TextStyle(
    color: primaryColor,
    fontSize: 16.sp,
    decoration: TextDecoration.underline,
    fontFamily: hacenFont);

final TextStyle titleTextStyle = TextStyle(
    color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold);

final TextStyle subBodyTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12.sp,
);

final TextStyle buttonTextStyle = TextStyle(
    color: blackColor,
    fontSize: 17.sp,
    fontWeight: FontWeight.w500,
    fontFamily: hacenFontHd);

final topRoundedDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24), topRight: Radius.circular(24)),
);

///Chat textStyles
const chatTextStyleLeft = TextStyle(
  color: Colors.grey,
  fontSize: 15.0,
);

const chatTextStyleRight = TextStyle(
  color: Colors.white,
  fontSize: 15.0,
);

const chatTimeTS = TextStyle(
    fontSize: 12, color: Color(0xFFB2BEC3), fontWeight: FontWeight.w600);
