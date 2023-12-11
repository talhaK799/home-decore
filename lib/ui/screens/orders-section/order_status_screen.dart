import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/my_orders.dart';
import 'package:f2_base_project/core/models/order.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
import 'package:f2_base_project/ui/custom_widgets/ordered_products_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../locator.dart';

class OrderStatusScreen extends StatelessWidget {
  final String? title;
  final Orders? myOrders;
  final Color? color;
  OrderStatusScreen({this.title, this.color, this.myOrders});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      topPadding: 91,

      ///
      /// Custom App bar
      ///
      appBarChild: CustomAppBar(
        leadingIcon: '$staticAssets/back_icon.png',
        title: '$title'.tr,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.w, 25.h, 30.w, 10.h),
        child: ListView(
          shrinkWrap: true,
          children: [
            ///
            /// Order Details
            ///
            Text('order'.tr + ' #: ${myOrders!.orderId}',
                style: titleTextStyle.copyWith(
                    color: color, fontSize: 17.sp, fontFamily: latoFont)),
            SizedBox(height: 20.h),
            Text(
                'TOTAL PRICE'.tr +
                    ': ${(double.parse(myOrders!.totalPrice!) + myOrders!.deliveryCharges!).toStringAsFixed(2)} €',
                style: titleTextStyle.copyWith(fontFamily: latoFont)),
            SizedBox(height: 20.h),
            Text('TOTAL QUANTITY'.tr + ': ${myOrders!.totalProducts!}',
                style: titleTextStyle.copyWith(fontFamily: latoFont)),
            SizedBox(height: 10.h),

            ///
            /// Buyer Details
            ///
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: primaryColor,
                ),
                SizedBox(width: 10.w),
                Text('${locator<AuthService>().appUser.name}',
                    style: bodyTextStyleLato.copyWith(fontSize: 13)),
              ],
            ),
            SizedBox(height: 7.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  '$staticAssets/location_icon.png',
                  color: primaryColor,
                  width: 10.w,
                  height: 13.h,
                ),
                SizedBox(width: 10.w),
                Text(
                    "${myOrders!.userAddress!.address} ${myOrders!.userAddress!.city}",
                    style: bodyTextStyleLato.copyWith(fontSize: 13)),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  '$staticAssets/phone_no.png',
                  color: primaryColor,
                  width: 10.w,
                  height: 13.h,
                ),
                SizedBox(width: 10.w),
                Text("+34${myOrders!.userAddress!.phone}",
                    style: bodyTextStyleLato.copyWith(fontSize: 13)),
              ],
            ),

            ///
            /// Products List
            ///
            SizedBox(height: 26.h),
            Text('products'.tr,
                style: titleTextStyle.copyWith(fontFamily: latoFont)),
            SizedBox(height: 25.h),
            // Column(
            //     children: List.generate(
            //   myOrders!.products!.length,
            //   (index) =>
            OrderedProductsList(
              myOrders: myOrders,
              orderDetails: myOrders!.products!,
              color: color,
              orderStatus: myOrders!.orderStatus!,
            ),
            // )),

            ///
            /// Order price
            ///
            SizedBox(height: 40.h),
            // PriceDetails(isOrderStatus: true)
            priceDetails(myOrders!)
          ],
        ),
      ),
    );
  }

  Widget priceDetails(Orders myOrders) {
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text('subtotal'.tr,
        //         style: bodyTextStyleLato.copyWith(fontSize: 13.sp)),
        //     Text('${myOrders.totalPrice} BDT',
        //         style: bodyTextStyleLato.copyWith(fontSize: 12.sp)),
        //   ],
        // ),
        SizedBox(height: 5.h),
        // Shipping amount
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Delivery Charges'.tr,
                style: bodyTextStyleLato.copyWith(
                  fontSize: 13.sp,
                )),
            Text('${myOrders.deliveryCharges ?? 00}  €',
                style: bodyTextStyleLato.copyWith(
                  fontSize: 12.sp,
                )),
          ],
        ),
        SizedBox(height: 6.h),
        // Service Charges

        SizedBox(height: 12.h),
        Container(color: Color(0xFF58595B), height: 0.13.h),

        ///
        /// Total price
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('total'.tr,
                style: titleTextStyle.copyWith(
                    fontFamily: latoFont,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF0B970B))),
            Text(
                myOrders.deliveryCharges == null
                    ? '${double.parse(myOrders.totalPrice!).toStringAsFixed(2)}  €'
                    : '${(double.parse(myOrders.totalPrice!) + myOrders.deliveryCharges!).toStringAsFixed(2)}  €',
                style: titleTextStyle.copyWith(
                    fontFamily: latoFont,
                    fontSize: 16.sp,
                    color: Color(0xFF0B970B))),
          ],
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
