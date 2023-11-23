import 'package:f2_base_project/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProdShimmer extends StatelessWidget {
  final width;
  final height;
  final radius;
  ProdShimmer({this.width, this.height, this.radius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: Colors.grey,
            boxShadow: [
              BoxShadow(
                color: lightGreyColor,
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
