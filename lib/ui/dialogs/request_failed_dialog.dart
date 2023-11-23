import 'package:f2_base_project/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestFailedDialog extends StatelessWidget {
  final errorMessage;

  RequestFailedDialog({@required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('requestFailed'.tr),
      content: Text("$errorMessage"),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'ok'.tr,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
