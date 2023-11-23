import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final value;
  final groupValue;
  final Color? activeColor;
  final Color? inActiveColor;
  final onChange;
  RadioButton(
      {this.groupValue,
      this.activeColor,
      this.inActiveColor,
      this.onChange,
      this.value});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          unselectedWidgetColor: inActiveColor, disabledColor: inActiveColor),
      child: Radio(
          activeColor: activeColor,
          focusColor: Colors.white,
          value: value,
          groupValue: groupValue,
          onChanged: onChange),
    );
  }
}
