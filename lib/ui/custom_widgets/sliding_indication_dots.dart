import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';

class SlidingIndicationDots extends StatelessWidget {
  final int? index;
  final int? currentImage;
  final double height;
  final double width;
  final Color fillColor;
  final Color borderColor;

  SlidingIndicationDots(
      {this.index,
      this.currentImage,
      this.height = 15,
      this.width = 15,
      this.fillColor = Colors.white,
      this.borderColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        index == currentImage
            ? Container(
                height: height,
                width: width,
                decoration:
                    BoxDecoration(color: fillColor, shape: BoxShape.circle),
              )
            : Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    border: Border.all(color: fillColor),
                    color: Colors.transparent,
                    shape: BoxShape.circle),
              ),
        SizedBox(width: 13.w),
      ],
    );
  }
}
