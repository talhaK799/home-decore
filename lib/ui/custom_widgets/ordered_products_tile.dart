import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/models/order.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderedProductsList extends StatelessWidget {
  final List<Product> orderDetails;
  final Color? color;
  final orderIndex;
  final Orders? myOrders;

  final orderStatus;

  OrderedProductsList(
      {required this.orderDetails,
      this.color,
      this.orderIndex,
      this.orderStatus,
      this.myOrders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: orderDetails.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              Row(
                children: [
                  // Text('${myOrders!.totalProducts}x',
                  //     style: bodyTextStyleLato.copyWith(fontSize: 11.sp)),
                  // SizedBox(width: 15.w),
                  Container(
                      width: 63.w,
                      height: 63.h,
                      color: Color(0xFFE3E3E3),
                      child: Center(
                        child: FadeInImage.assetNetwork(
                          height: 63.h,
                          width: 63.w,
                          placeholder: '$productPlaceHolder',
                          image: '${orderDetails[index].images![0]}',
                          fit: BoxFit.fill,
                        ),
                        // Image.asset(
                        //     '${myOrders!.orderDetails!.product!.prodImages[index]}',
                        //     fit: BoxFit.contain)
                      )),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${orderDetails[index].category}',
                                style: boldTextStyleLato.copyWith(
                                    fontSize: 14.sp)),
                            Row(
                              children: [
                                Container(
                                  width: 10.9.w,
                                  height: 10.9.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: color),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  '$orderStatus'.tr,
                                  style: bodyTextStyleLato.copyWith(
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Text(
                              'By: ',
                              style: boldTextStyleLato.copyWith(
                                  fontSize: 11.sp, color: Color(0xFF58595B)),
                            ),
                            Text('${orderDetails[index].category ?? "Nike"}',
                                style: boldTextStyleLato.copyWith(
                                    decoration: TextDecoration.underline,
                                    fontSize: 10.sp,
                                    color: Color(0xFF8A8A8A))),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                            '${orderDetails[index].description != null ? orderDetails[index].description!.length > 20 ? orderDetails[index].description!.substring(0, 20) : orderDetails[index].description : ''}',
                            maxLines: 1,
                            style: boldTextStyleLato.copyWith(
                                fontSize: 10.sp, color: Color(0xFF8A8A8A))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text('${orderDetails[index].salePrice} BDT',
                                style: TextStyle(
                                    fontFamily: latoFont,
                                    fontSize: 12.sp,
                                    color: primaryColor)),
                          ],
                        ),
                        orderDetails[index].sizes != null
                            ? Container(
                                height: 15.h,
                                child: ListView.builder(
                                    itemCount:
                                        orderDetails[index].sizes!.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6.0),
                                        child: Text(
                                          '${orderDetails[index].sizes![i].size} (${orderDetails[index].sizes![i].count})',
                                          overflow: TextOverflow.ellipsis,
                                          style: boldTextStyleLato.copyWith(
                                              fontSize: 10.sp,
                                              color: Color(0xFF58595B)),
                                        ),
                                      );
                                    }))
                            : Container()
                      ],
                    ),
                  ),
                ],
              ),
              Divider(color: Color(0xFF58595B)),
              SizedBox(height: 6.h)
            ],
          ),
        );
      },
    );
  }
}
