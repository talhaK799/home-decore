import 'package:f2_base_project/core/constants/colors.dart';
import 'package:flutter/material.dart';

Widget circularProgressIndicator() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: greyColor,
      color: primaryColor,
    ),
  );
}
