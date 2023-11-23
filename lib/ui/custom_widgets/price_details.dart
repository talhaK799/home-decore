// import 'package:f2_base_project/core/constants/colors.dart';
// import 'package:f2_base_project/core/constants/strings.dart';
// import 'package:f2_base_project/core/constants/styles.dart';
// import 'package:f2_base_project/core/others/screen_uitls.dart';
// import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// class PriceDetails extends StatelessWidget {
//   final bool? isOrderStatus;
//   PriceDetails({this.isOrderStatus = false});
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CartViewModel>(
//       builder: (context, model, child) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('subtotal'.tr,
//                     style: bodyTextStyleHacen.copyWith(
//                         fontSize: 13.sp, fontFamily: latoFont)),
//                 Text('${model.subTotalPrice} BHD',
//                     style: bodyTextStyleLato.copyWith(
//                         fontSize: 12.sp, fontFamily: latoFont)),
//               ],
//             ),
//             SizedBox(height: 5.h),
//             // Shipping amount
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('shipping'.tr,
//                     style: bodyTextStyleLato.copyWith(
//                         fontSize: 13.sp, fontFamily: latoFont)),
//                 Text('${model.shippingAmount} BHD',
//                     style: bodyTextStyleLato.copyWith(
//                         fontSize: 12.sp, fontFamily: latoFont)),
//               ],
//             ),
//             SizedBox(height: 6.h),
//             // Service Charges
//             isOrderStatus!
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('service_charge'.tr,
//                           style: bodyTextStyleLato.copyWith(
//                               fontSize: 13.sp, fontFamily: latoFont)),
//                       Text('${model.serviceCharge} BHD',
//                           style: bodyTextStyleLato.copyWith(
//                               fontSize: 12.sp, fontFamily: latoFont)),
//                     ],
//                   )

//                 /// Discount
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('discount'.tr,
//                           style: TextStyle(
//                               fontSize: 13.sp,
//                               color: primaryColor,
//                               fontFamily: latoFont)),
//                       Text(
//                           model.discountAmount == 0.00
//                               ? '${model.discountAmount!.toStringAsFixed(2)} BHD'
//                               : '${model.discountAmount!.toStringAsFixed(2)} BHD',
//                           style: TextStyle(
//                               fontSize: 12.sp,
//                               color: primaryColor,
//                               fontFamily: latoFont)),
//                     ],
//                   ),

//             SizedBox(height: 12.h),
//             Container(color: Color(0xFF58595B), height: 0.13.h),

//             ///
//             /// Total price
//             SizedBox(height: 12.h),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('total'.tr,
//                     style: titleTextStyle.copyWith(
//                         fontWeight: FontWeight.normal,
//                         fontFamily: latoFont,
//                         fontSize: isOrderStatus! ? 16.sp : 13.sp,
//                         color:
//                             isOrderStatus! ? Color(0xFF0B970B) : Colors.black)),
//                 Text('${model.totalPrice!.toStringAsFixed(2)} BHD',
//                     style: titleTextStyle.copyWith(
//                         fontWeight: FontWeight.normal,
//                         fontFamily: latoFont,
//                         fontSize: isOrderStatus! ? 16.sp : 13.sp,
//                         color:
//                             isOrderStatus! ? Color(0xFF0B970B) : Colors.black)),
//               ],
//             ),
//             SizedBox(height: 40.h),
//             isOrderStatus!
//                 ? Container()
//                 : Text('deliver_note'.tr,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 12.sp,
//                         color: primaryColor,
//                         fontFamily: segoeFont)),
//             SizedBox(height: 34.h),
//           ],
//         );
//       },
//     );
//   }
// }
