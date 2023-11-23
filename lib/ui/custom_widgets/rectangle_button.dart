import 'package:f2_base_project/core/constants/typedef.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  final String? title;
  final voidFunction? onTap;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final double? width;
  final double? radius;

  RectangularButton(
      {this.onTap,
      this.title,
      this.buttonColor,
      this.textStyle,
      this.width,
      this.radius});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 42.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius!), color: buttonColor),
        child: Center(child: Text(title!, style: textStyle)),
      ),
    );
  }
}
