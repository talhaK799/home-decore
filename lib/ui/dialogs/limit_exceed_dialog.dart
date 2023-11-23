import 'package:f2_base_project/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LimitExceedDialog extends StatelessWidget {
  final errorMessage;

  LimitExceedDialog({@required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('alert'.tr),
      content: Text("$errorMessage"),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'ok'.tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
