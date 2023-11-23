import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityTile extends StatelessWidget {
  final imgUrl;
  final text;
  final ontap;
  FacilityTile({this.imgUrl, this.ontap, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ImageContainer(
            assetImage: "$assets/facility.png",
            height: 24,
            width: 24,
          ),
          SizedBox(
            width: 9.5,
          ),
          Text(
            "Facility_1",
            style: bodyTextStyleLato.copyWith(fontSize: 16.sp),
          )
        ],
      ),
    );
  }
}
