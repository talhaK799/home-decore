import 'package:flutter/material.dart';
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/styles.dart';

class RoundedRaisedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RoundedRaisedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          text,
          style:
              headingTextStyleLato.copyWith(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }
}





// import 'package:f2_base_project/core/constants/colors.dart';
// import 'package:f2_base_project/core/constants/styles.dart';
// import 'package:flutter/material.dart';

// class RoundedRaisedButton extends StatelessWidget {
//   final text;
//   final onPressed;
//   RoundedRaisedButton({this.text, this.onPressed});
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//         color: primaryColor,
//         colorBrightness: Brightness.dark,
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//         onPressed: onPressed,
//         padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//         child: Text(
//           "$text",
//           style: headingTextStyleLato.copyWith(fontSize: 17, color: Colors.white),
//         ));
//   }
// }
