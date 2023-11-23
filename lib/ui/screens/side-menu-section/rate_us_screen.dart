// import 'package:f2_base_project/core/constants/colors.dart';
// import 'package:f2_base_project/core/constants/strings.dart';
// import 'package:f2_base_project/core/constants/styles.dart';
// import 'package:f2_base_project/core/enums/view_state.dart';
// import 'package:f2_base_project/core/others/screen_uitls.dart';
// import 'package:f2_base_project/ui/custom_widgets/base_screen.dart';
// import 'package:f2_base_project/ui/custom_widgets/custom_app_bar.dart';
// import 'package:f2_base_project/ui/custom_widgets/rectangle_button.dart';
// import 'package:f2_base_project/ui/screens/side-menu-section/feedback/feedback_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:provider/provider.dart';

// class RateUsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => FeedbackViewModel(),
//       child: Consumer<FeedbackViewModel>(
//         builder: (context, model, child) {
//           return ModalProgressHUD(
//             inAsyncCall: model.state == ViewState.busy,
//             child: BaseScreen(
//               topPadding: 141,
//               appBarChild: CustomAppBar(
//                 leadingIcon: '$staticAssets/back_icon.png',
//                 title: 'rate_us'.tr,
//               ),
//               body: Form(
//                 key: model.formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(),
//                     Column(
//                       children: [
//                         SizedBox(height: 68.h),
//                         Text('rate_experience'.tr,
//                             style: bodyTextStyleLato.copyWith(fontSize: 19.sp)),
//                         SizedBox(height: 40.h),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             RatingBar(
//                                 itemPadding: EdgeInsets.only(right: 9.0),
//                                 ratingWidget: RatingWidget(
//                                   empty: Image.asset(
//                                       '$staticAssets/empty_star.png',
//                                       width: 36.5.w,
//                                       height: 35.1.h),
//                                   half: Image.asset(
//                                       '$staticAssets/half_fill.png',
//                                       width: 36.5.w,
//                                       height: 35.1.h),
//                                   full: Image.asset(
//                                       '$staticAssets/full_star.png',
//                                       width: 36.5.w,
//                                       height: 35.1.h),
//                                 ),
//                                 itemCount: 5,
//                                 // c
//                                 glowColor: primaryColor,
//                                 direction: Axis.horizontal,
//                                 allowHalfRating: true,
//                                 onRatingUpdate: (value) {
//                                   model.feedBack.rating = value;
//                                 })
//                           ],
//                         ),
//                       ],
//                     ),
//                     // SizedBox(height: 40.h),

//                     ///
//                     /// add Comments
//                     ///
//                     // Text('Additional Comments',
//                     //     style: bodyTextStyle.copyWith(fontSize: 19.sp)),
//                     // SizedBox(height: 40.h),
//                     // Padding(
//                     //   padding: EdgeInsets.symmetric(horizontal: 25.w),
//                     //   child: Container(
//                     //     height: 260.h,
//                     //     child: CustomTextField2(
//                     //       maxline: 6,
//                     //       // controller: TextEditingController(),
//                     //       hintText: "",
//                     //       fillColor: lightGreyColor,
//                     //       validator: (value) {
//                     //         if (value.isEmpty) {
//                     //           return "This field is required";
//                     //         } else {
//                     //           return null;
//                     //         }
//                     //       },
//                     //       onSaved: (value) {
//                     //         model.feedBack.comment = value;
//                     //       },
//                     //     ),
//                     //   ),
//                     // ),
//                     // SizedBox(height: 37.h),

//                     ///
//                     /// Submit button
//                     ///
//                     Column(
//                       children: [
//                         RectangularButton(
//                           width: 159.w,
//                           radius: 9,
//                           title: 'submit'.tr,
//                           textStyle: buttonTextStyle,
//                           buttonColor: primaryColor,
//                           onTap: () {
//                             Get.back();
//                             Get.snackbar('thanks'.tr, 'rating_recorded'.tr,
//                                 snackPosition: SnackPosition.BOTTOM);
//                             // if (model.formKey.currentState!.validate()) {
//                             //   model.formKey.currentState!.save();
//                             //   model.addFeedback();
//                             // }
//                           },
//                         ),
//                         SizedBox(height: 30.h)
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
