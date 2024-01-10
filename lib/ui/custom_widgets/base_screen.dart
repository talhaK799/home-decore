import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final appBarChild;
  final body;
  final double? topPadding;
  final bottomNavBar;
  BaseScreen({this.appBarChild, this.body, this.topPadding, this.bottomNavBar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 130.h,
            padding: EdgeInsets.fromLTRB(6.w, 45.h, 20.w, 50.h),
            color: primaryColor,
            child: appBarChild,
          ),
          Column(
            children: [
              SizedBox(
                height: this.topPadding!.h,
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )),
                    child: body),
              )
            ],
          )
        ],
      ),
    );
  }
}
