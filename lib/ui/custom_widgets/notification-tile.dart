import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/notifications.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:flutter/material.dart';

class NotifcationTile extends StatelessWidget {
  final index;
  final List<Notifications> notifications;
  NotifcationTile(this.index, this.notifications);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 30.0, start: 26),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 10.0, start: 10),
            child: Column(
              children: [
                ImageContainer(
                  assetImage: "$assets/notifications.png",
                  height: 27.13.h,
                  width: 21.46.w,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 32.2.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${notifications[index].title}",
                  style: bodyTextStyleLato.copyWith(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 4.0.h,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 58.0),
                  child: Text(
                    "${notifications[index].content}",
                    style: bodyTextStyleLato.copyWith(fontSize: 12.sp),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
