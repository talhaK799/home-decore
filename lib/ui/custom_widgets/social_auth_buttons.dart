// import 'package:f2_base_project/core/constants/strings.dart';
// import 'package:f2_base_project/core/others/screen_uitls.dart';
// import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
// import 'package:flutter/material.dart';

// class SocialAuthButtons extends StatelessWidget {
//   final isAndroid;
//   final onAppleTap;
//   final onGoogleTap;
//   final onFacebookTap;
//   SocialAuthButtons({
//     this.isAndroid = false,
//     this.onFacebookTap,
//     this.onGoogleTap,
//     this.onAppleTap,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Google Button
//         InkWell(
//           onTap: onGoogleTap,
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//             ),
//             child: ImageContainer(
//               assetImage: '$staticAssets/google.png',
//               height: 65.h,
//               width: 64.w,
//             ),
//           ),
//         ),
//         SizedBox(width: 8.w),

//         // Facebook Button
//         InkWell(
//           onTap: onFacebookTap,
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//             ),
//             child: Image.asset('$staticAssets/facebook_button.png',
//                 height: 65.h, width: 65.w),
//           ),
//         ),
//         SizedBox(width: 8.w),

//         // Apple Button
//         isAndroid
//             ? Container()
//             : InkWell(
//                 onTap: onAppleTap,
//                 child: Container(
//                   height: 65.h,
//                   width: 65.w,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                   ),
//                   child: Image.asset('$staticAssets/apple_button.png'),
//                 ),
//               ),
//       ],
//     );
//   }
// }
