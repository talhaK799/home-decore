import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/colors.dart';

class StatusDot extends StatelessWidget {
  final Color? dotColor;
  final Color borderColor;
  StatusDot({@required this.dotColor, this.borderColor = primaryColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: this.dotColor,
        border: Border.all(color: borderColor),
      ),
    );
  }
}
