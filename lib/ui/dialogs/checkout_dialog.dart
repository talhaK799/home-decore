import 'package:f2_base_project/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutDialog extends StatelessWidget {
  final errorMessage;
  final title;
  final onChange;

  CheckoutDialog({this.errorMessage, this.title, this.onChange});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$title'),
      content: Text("$errorMessage"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel'.tr,
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: onChange,
              child: Text(
                'Confirm Checkout'.tr,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
