import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';

class CustomTextField2 extends StatelessWidget {
  final controller;
  final bool? obscure;
  final String? errorText;
  final String? hintText;
  final bool? enabled;
  final errorColor;
  final Widget? suffixIcon;
  final validator;
  final double? fontSize;
  final String? label;
  final inputType;
  final onSaved;
  final ontap;
  final bool disableBorder;
  final prefixIcon;
  final maxline;
  final fillColor;
  final isElevated;
  final onChange;
  CustomTextField2(
      {this.controller,
      this.prefixIcon,
      this.maxline = 1,
      this.ontap,
      this.errorColor = primaryColor,
      this.disableBorder = false,
      this.label,
      this.inputType = TextInputType.text,
      this.obscure = false,
      this.enabled = true,
      this.validator,
      this.errorText,
      this.fontSize = 15.0,
      this.hintText,
      this.onSaved,
      this.fillColor = Colors.white,
      this.suffixIcon,
      this.onChange,
      this.isElevated = false});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: (40.96.h * maxline),
            decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(11.0),
                boxShadow: [
                  isElevated!
                      ? BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius:
                              2, // has the effect of softening the shadow
                          spreadRadius:
                              0.6, // has the effect of extending the shadow
                          offset: Offset(
                            0, // horizontal, move right 10
                            0.4, // vertical, move down 10
                          ),
                        )
                      : BoxShadow(color: Colors.transparent),
                ])),
        TextFormField(
          onChanged: onChange,
          maxLines: maxline,
          onTap: ontap,
          onSaved: onSaved,
          enabled: enabled,
          style: subBodyTextStyle.copyWith(fontSize: this.fontSize),
          cursorColor: primaryColor,
          controller: this.controller,
          obscureText: this.obscure!,
          validator: validator,
          keyboardType: inputType,
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 14.0, right: 18.0),
                child: prefixIcon,
              ),
              prefixIconConstraints: BoxConstraints(
                  maxHeight: prefixIcon != null ? 40 : 14,
                  maxWidth: prefixIcon != null ? 50 : 15),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              isDense: true,
              errorStyle: TextStyle(
                fontSize: 10,
                color: errorColor,
                fontFamily: 'OpenSans',
              ),
              // alignLabelWithHint: true,
              suffixIcon: Padding(
                  padding: EdgeInsets.only(),
                  child: suffixIcon != null ? suffixIcon : Container()),
              suffixIconConstraints:
                  BoxConstraints(maxHeight: 40, maxWidth: 50),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              // EdgeInsets.only(left: 21.0, top: 10),
              hintText: this.hintText,

              // errorStyle: TextStyle(fontSize: 8, height: 1),
              hintStyle: subBodyTextStyle.copyWith(
                  fontFamily: latoFont,
                  color: disableBorder
                      ? greyColor
                      : Color(0XFF686868).withOpacity(0.4),
                  fontSize: fontSize)),
        ),
      ],
    );
  }
}
