import 'package:f2_base_project/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageChangeAlertDialog extends StatelessWidget {
  final message;

  LanguageChangeAlertDialog({@required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('are_you_sure'.tr),
      content: Text("$message"),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.back(result: true);
          },
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
          ),
          child: Text('yes'.tr),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(result: false);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          child: Text('no'.tr, style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }
}
