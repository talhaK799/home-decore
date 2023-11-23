import 'dart:math';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/constants/typedef.dart';
import 'package:f2_base_project/core/models/my_orders.dart';
import 'package:f2_base_project/core/models/order.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/circular_progress_indicator.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/screens/orders-section/order_status_screen.dart';
import 'package:f2_base_project/ui/screens/orders-section/orders_view_model.dart';
import 'package:f2_base_project/ui/screens/root/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AllOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrdersViewModel(),
      child: Consumer<OrdersViewModel>(
        builder: (context, model, child) {
          return BaseScreen(
            topPadding: 91,
            appBarChild: CustomAppBar(
              leadingIcon: '$staticAssets/back_icon.png',
              title: 'my_orders'.tr,
              onLeadingPressed: () {
                Get.offAll(RootScreen());
              },
            ),
            body: model.isLoading
                ? circularProgressIndicator()
                : Padding(
                    padding: EdgeInsets.fromLTRB(31.w, 30.h, 31.w, 20.h),
                    child: model.allOrders.isEmpty
                        ? Center(
                            child: Text(
                            'no_order_created'.tr,
                            style:
                                bodyTextStyleLato.copyWith(color: primaryColor),
                          ))
                        : ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: model.allOrders.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  orderDetails(
                                      myOrders: model.allOrders,
                                      index: index,
                                      color: Color(0xFFDB9D0B),
                                      onPressed: () => Get.to(OrderStatusScreen(
                                          myOrders: model.allOrders[index],
                                          title:
                                              '${model.allOrders[index].orderStatus}',

                                          ///
                                          /// Selected color on the basis of order status
                                          color: Color(0xFFDB9D0B))))
                                ],
                              );
                            })),
          );
        },
      ),
    );
  }

  Widget orderDetails(
      {List<Orders>? myOrders, Color? color, voidFunction? onPressed, index}) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10.9.w,
                    height: 10.9.h,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: color),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '${myOrders![index].orderStatus}'.tr,
                    style: bodyTextStyleLato.copyWith(fontSize: 19.sp),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            'order'.tr + ' #:  ${myOrders[index].orderId}',
            style: bodyTextStyleLato.copyWith(fontSize: 17),
          ),
          SizedBox(height: 6.h),
          Text(
            'Total Price'.tr +
                ':  ${(double.parse(myOrders[index].totalPrice!) + myOrders[index].deliveryCharges!).toStringAsFixed(2)}',
            style: bodyTextStyleLato.copyWith(fontSize: 17),
          ),
          SizedBox(height: 23.h),
          Container(
            height: 69.h,
            child: ListView.builder(
                itemCount: myOrders[index].products!.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                      color: lightGreyColor,
                      height: 69.h,
                      width: 69.w,
                      child: FadeInImage.assetNetwork(
                        height: 69.h,
                        width: 69.w,
                        placeholder: '$productPlaceHolder',
                        image: '${myOrders[index].products![i].images![0]}',
                        fit: BoxFit.fill,
                      ),
                      // Image.asset('$staticAssets/gloves.png')),
                    ),
                  );
                }
                // Row(
                //   children: List.generate(
                //       myOrders.orderDetails!.product!.prodImages.length,
                //       (index) => Expanded(
                //             child:
                //           )),
                ),
          ),
          Divider(color: greyColor, height: 35.h),
        ],
      ),
    );
  }
}
