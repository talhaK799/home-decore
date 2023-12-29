import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/notification-tile.dart';
import 'package:f2_base_project/ui/screens/notification/notification-view-model.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationViewModel(),
      child: Consumer<NotificationViewModel>(
          builder: (context, model, child) => BaseScreen(
              topPadding: 91,
              appBarChild: CustomAppBar(
                leadingIcon: '$staticAssets/back_icon.png',
                onLeadingPressed: () {
                  Get.back();
                },
                title: 'Notifications'.tr,
              ),
              body: model.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Center(child: _categoriesStackView(model)))),
    );
  }

  _categoriesStackView(NotificationViewModel model) {
    return Padding(
        padding: EdgeInsets.zero,
        child: model.notificaitons.isEmpty
            ? Center(child: Text('notifications_not_found'.tr))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: List.generate(
                      model.notificaitons.length,
                      (index) => index == 0
                          ? InkWell(
                              onTap: () {
                                // if (model.notificaitons[index].notificationType ==
                                //     'order') {
                                //   // Get.to(() => AllOrdersScreen());
                                // } else if (model
                                //         .notificaitons[index].notificationType ==
                                //     'service') {
                                //   Get.offAll(() => RootScreen(selectedPage: 2));
                                // }
                              },
                              child: Container(
                                height: model.notificaitons.length *
                                    108.h, //lengthoflist * 100
                                decoration: BoxDecoration(
                                    color: Color(0XFFE4E4E4),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24.0),
                                      topRight: Radius.circular(24.0),
                                    )),
                                child:
                                    NotifcationTile(index, model.notificaitons),
                              ),
                            )
                          : Positioned.fill(
                              top: (108.h * index),
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    height: 141.h,
                                    decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? Color(0XFFE4E4E4)
                                            : Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24.0),
                                          topRight: Radius.circular(24.0),
                                        )),
                                    child: NotifcationTile(
                                        index, model.notificaitons)),
                              ),
                            ),
                    ),
                  )
                ],
              ));
  }
}
