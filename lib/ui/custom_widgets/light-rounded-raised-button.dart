import 'package:flutter/material.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/styles.dart';

class LightRoundedRaisedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LightRoundedRaisedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: primaryColor), // Optional: Add border
        ),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Text(
          text,
          style: headingTextStyleLato.copyWith(
            fontSize: 18,
            color: primaryColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
// import 'package:f2_base_project/core/constants/colors.dart';
// import 'package:f2_base_project/core/constants/styles.dart';
// import 'package:flutter/material.dart';

// class LightRoundedRaisedButton extends StatelessWidget {
//   final text;
//   final onPressed;
//   LightRoundedRaisedButton({this.text, this.onPressed});
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//         color: Colors.white,
//         colorBrightness: Brightness.dark,
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//         onPressed: onPressed,
//         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//         child: Text(
//           "$text",
//           style: headingTextStyleLato.copyWith(
//               fontSize: 18, color: primaryColor, fontWeight: FontWeight.normal),
//         ));
//   }
// }
