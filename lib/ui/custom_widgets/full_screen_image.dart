import 'dart:math';

import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Transform(
                          alignment: Alignment.center,
                          transform: Get.locale!.languageCode == 'ar'
                              ? Matrix4.rotationY(pi)
                              : Matrix4.rotationY(0),
                          child: Image.asset('$staticAssets/back.png',
                              color: primaryColor, height: 22.h, width: 11.w)),
                      onPressed: () => Get.back()),
                ],
              ),
              // SizedBox(height: 30.h),
              Expanded(
                child: PhotoView(
                  
                  imageProvider: NetworkImage(imageUrl),
                ),
              ),
            ],
          )),
    );
  }
}
