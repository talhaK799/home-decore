// import 'package:f2_base_project/core/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class UtilityBaseScreen extends StatelessWidget {
//   final appBarChild;
//   final body;
//   final double appBarContainerHeight;
//   final double bodyTopPadding;
//   final double topChildPad;
//   final double leftChildPad;
//   final Widget? fab;
//   UtilityBaseScreen(
//       {this.appBarChild,
//       this.body,
//       this.topChildPad = 65.0,
//       this.leftChildPad = 30.0,
//       this.fab,
//       this.appBarContainerHeight = 300,
//       this.bodyTopPadding = 101});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       ///
//       ///[body] Starts from here
//       ///
//       body: Stack(
//         children: [
//           ///
//           ///custom appbar
//           ///
//           Container(
//             height: this.appBarContainerHeight.h,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: primaryColor,
//             ),
//             child: Padding(
//               padding: EdgeInsets.only(
//                   left: leftChildPad, right: 34, top: topChildPad, bottom: 27),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   // //backButton
//                   // GestureDetector(
//                   //   onTap: () {
//                   //     Get.back();
//                   //   },
//                   //   child: Padding(
//                   //     padding: const EdgeInsets.only(bottom: 24.1),
//                   //     child: ImageContainer(
//                   //       assetImage: "$assets/back_button_white.png",
//                   //       height: 19.21.h,
//                   //       width: 31.67.w,
//                   //     ),
//                   //   ),
//                   // ),
//                   //app bar body
//                   appBarChild,
//                 ],
//               ),
//             ),
//           ),

//           ///
//           ///body container
//           ///
//           Column(
//             children: [
//               SizedBox(
//                 height: this.bodyTopPadding.h,
//               ),
//               Expanded(
//                 child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(24.0),
//                           topRight: Radius.circular(24.0),
//                         )),
//                     child: body),
//               )
//             ],
//           )
//         ],
//       ),

//       ////
//       ///fab
//       ///
//       floatingActionButton: fab,
//     );
//   }
// }
