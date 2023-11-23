// import 'package:f2_base_project/core/constants/colors.dart';
// import 'package:f2_base_project/core/constants/strings.dart';
// import 'package:f2_base_project/core/constants/styles.dart';
// import 'package:f2_base_project/core/models/other_models/my_orders.dart';
// import 'package:f2_base_project/core/others/screen_uitls.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OrderedProductsList extends StatelessWidget {
//   final List<OrderDetails> orderDetails;
//   final Color? color;
//   final orderIndex;
//   final MyOrders? myOrders;

//   final orderStatus;

//   OrderedProductsList(
//       {required this.orderDetails,
//       this.color,
//       this.orderIndex,
//       this.orderStatus,
//       this.myOrders});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       primary: false,
//       shrinkWrap: true,
//       itemCount: orderDetails.length,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12.w),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Text('${orderDetails[index].quantity}x',
//                       style: bodyTextStyleLato.copyWith(fontSize: 11.sp)),
//                   SizedBox(width: 15.w),
//                   Container(
//                       width: 63.w,
//                       height: 63.h,
//                       color: Color(0xFFE3E3E3),
//                       child: Center(
//                         child: FadeInImage.assetNetwork(
//                           height: 63.h,
//                           width: 63.w,
//                           placeholder: '$productPlaceHolder',
//                           image:
//                               '${orderDetails[index].product!.prodImages[index]}',
//                           fit: BoxFit.fill,
//                         ),
//                         // Image.asset(
//                         //     '${myOrders!.orderDetails!.product!.prodImages[index]}',
//                         //     fit: BoxFit.contain)
//                       )),
//                   SizedBox(width: 16.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('${myOrders!.shop!.shopName}',
//                                 style: boldTextStyleLato.copyWith(
//                                     fontSize: 14.sp)),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 10.9.w,
//                                   height: 10.9.h,
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle, color: color),
//                                 ),
//                                 SizedBox(width: 10.w),
//                                 Text(
//                                   '$orderStatus'.tr,
//                                   style: bodyTextStyleLato.copyWith(
//                                       fontSize: 12.sp),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 2.h),
//                         Row(
//                           children: [
//                             Text(
//                               'By: ',
//                               style: boldTextStyleLato.copyWith(
//                                   fontSize: 11.sp, color: Color(0xFF58595B)),
//                             ),
//                             Text('${myOrders!.shop!.shopName ?? "Nike"}',
//                                 style: boldTextStyleLato.copyWith(
//                                     decoration: TextDecoration.underline,
//                                     fontSize: 10.sp,
//                                     color: Color(0xFF8A8A8A))),
//                           ],
//                         ),
//                         SizedBox(height: 2.h),
//                         Text(
//                             '${orderDetails[index].product!.prodDescription != null ? orderDetails[index].product!.prodDescription!.length > 30 ? orderDetails[index].product!.prodDescription!.substring(0, 30) : orderDetails[index].product!.prodDescription : ''}',
//                             style: boldTextStyleLato.copyWith(
//                                 fontSize: 10.sp, color: Color(0xFF8A8A8A))),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(),
//                             Text('${orderDetails[index].orderPrice} BHD',
//                                 style: TextStyle(
//                                     fontFamily: latoFont,
//                                     fontSize: 12.sp,
//                                     color: primaryColor)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Divider(color: Color(0xFF58595B)),
//               SizedBox(height: 6.h)
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
