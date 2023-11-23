import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('network_error'.tr),
      content: Text("connect_network".tr),
    );
  }
}
