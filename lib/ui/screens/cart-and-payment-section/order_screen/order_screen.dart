import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/cart_product_tile.dart';
import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../cart_view_model.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, model, child) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: model.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        color: primaryColor, backgroundColor: greyColor),
                  )
                : Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
                    child: model.authService.order.products == null
                        ? Center(
                            child: Text('empty_cart'.tr,
                                style: bodyTextStyleLato.copyWith(
                                    color: primaryColor)))
                        : model.authService.order.products!.length <= 0
                            ? Center(
                                child: Text('empty_cart'.tr,
                                    style: bodyTextStyleLato.copyWith(
                                        color: primaryColor)))
                            : ListView(
                                children: [
                                  ///
                                  /// List of Products
                                  ///

                                  ListView.builder(
                                      primary: false,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: model
                                          .authService.order.products!.length,
                                      itemBuilder: (context, cartIndex) {
                                        return cartProductTile(cartIndex, () {
                                          model.deleteProduct();
                                        });
                                      }),
                                  SizedBox(height: 45.h),

                                  ///
                                  /// Total and Sub total Prices
                                  ///
                                  SizedBox(
                                    height: 1.2.h,
                                  ),
                                  Divider(color: Color(0xFF58595B)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('total'.tr,
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              fontFamily: latoFont)),
                                      Text(
                                          '${double.parse(model.authService.order.totalPrice!).toStringAsFixed(2)} BDT',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontFamily: latoFont)),
                                    ],
                                  ),
                                  SizedBox(height: 40),

                                  ///
                                  /// Place Order Button
                                  ///
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // RectangularButton(
                                      //   radius: 9,
                                      //   width: 0.5.sw,
                                      //   buttonColor: primaryColor,
                                      //   textStyle: TextStyle(
                                      //       fontSize: 19.sp,
                                      //       color: Colors.white,
                                      //       fontFamily: latoFont,
                                      //       fontWeight: FontWeight.bold),
                                      //   title: 'Empty Cart'.tr,
                                      //   onTap: () {
                                      //     model.deleteProduct();
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RectangularButton(
                                        radius: 9,
                                        width: 0.5.sw,
                                        buttonColor: primaryColor,
                                        textStyle: TextStyle(
                                            fontSize: 19.sp,
                                            color: Colors.white,
                                            fontFamily: latoFont,
                                            fontWeight: FontWeight.bold),
                                        title: 'place_order'.tr,
                                        onTap: () {
                                          model.tabController!.animateTo(1);
                                        },
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20.h)
                                ],
                              ),
                  ));
      },
    );
  }
}
