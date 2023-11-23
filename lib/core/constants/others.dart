import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// All corners rounded except bottom right
///
BorderRadius chatBorderRadiusRight = BorderRadius.only(
  topLeft: Radius.circular(20.0),
  topRight: Get.locale!.languageCode == 'en' ? Radius.circular(20.0) : Radius.circular(20.0),
  
  bottomLeft:Get.locale!.languageCode == 'en' ? Radius.circular(20.0) :  Radius.circular(0.0),
  bottomRight: Get.locale!.languageCode == 'ar' ? Radius.circular(20.0) : Radius.circular(0)
);

///
/// All corners rounded except bottom left
///
 BorderRadius chatBorderRadiusLeft = BorderRadius.only(
  topLeft: Radius.circular(20.0),
  topRight: Radius.circular(20.0),
  bottomLeft:Get.locale!.languageCode == 'ar' ? Radius.circular(20.0) :  Radius.circular(0.0),
  bottomRight: Get.locale!.languageCode == 'en' ? Radius.circular(20.0) : Radius.circular(0)
);
