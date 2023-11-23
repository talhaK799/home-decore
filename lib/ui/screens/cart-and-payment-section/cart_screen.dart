import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'cart_address/cart_address_screen.dart';
import 'cart_view_model.dart';
import 'order_screen/order_screen.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  // int? pageIndex;
  // CartScreen({this.pageIndex = 0});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartViewModel(this),
      child: Consumer<CartViewModel>(
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () => model.goBack(),
            child: BaseScreen(
                topPadding: 91,
                appBarChild: CustomAppBar(
                  leadingIcon: '$staticAssets/back_icon.png',
                  title: 'my_cart'.tr,
                  onLeadingPressed: () {
                    Get.back(result: model.authService.order.products);
                  },
                ),
                body: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  child: DefaultTabController(

                      ///
                      /// Numbers of tabs
                      length: 2,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Column(
                          children: [
                            Container(
                              child: TabBar(
                                // controller:,
                                controller: model.tabController,
                                labelColor: Colors.black,
                                labelStyle: bodyTextStyleLato.copyWith(
                                    fontWeight: FontWeight.bold),
                                indicatorWeight: 3.w,
                                indicatorColor: primaryColor,
                                unselectedLabelColor: greyColor,
                                tabs: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 14.0),
                                    child: Text(
                                      'order'.tr,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: latoFont),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 14.0),
                                    child: Text(
                                      'address1'.tr,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontFamily: latoFont),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: TabBarView(
                                    controller: model.tabController,
                                    children: [
                                      OrderScreen(),
                                      CartAddressScreen(),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      )),
                )),
          );
        },
      ),
    );
  }
}
