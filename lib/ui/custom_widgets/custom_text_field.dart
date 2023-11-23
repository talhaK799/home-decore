import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final controller;
  final isInputFormatter;
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
  final isMobile;
  final isCountryCode;
  CustomTextField({
    this.isInputFormatter = false,
    this.controller,
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
    this.isElevated = false,
    this.isMobile = false,
    this.isCountryCode = false,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: (42.h * maxline),
            decoration: BoxDecoration(
                color: fillColor,
                borderRadius: isMobile
                    ? Get.locale!.languageCode == 'en'
                        ? BorderRadius.only(
                            topRight: Radius.circular(11),
                            bottomRight: Radius.circular(11))
                        : BorderRadius.only(
                            topLeft: Radius.circular(11),
                            bottomLeft: Radius.circular(11))
                    : isCountryCode
                        ? Get.locale!.languageCode == 'en'
                            ? BorderRadius.only(
                                topLeft: Radius.circular(11),
                                bottomLeft: Radius.circular(11))
                            : BorderRadius.only(
                                topRight: Radius.circular(11),
                                bottomRight: Radius.circular(11))
                        : BorderRadius.circular(11.0),
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
          readOnly: enabled! ? false : true,
          onChanged: onChange,
          inputFormatters: isInputFormatter
              ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
              : [],
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
                padding: EdgeInsets.only(left: 14.w, right: 18.w, bottom: 0.h),
                child: prefixIcon,
              ),
              prefixIconConstraints: BoxConstraints(
                  maxHeight: prefixIcon != null ? 40 : 14,
                  maxWidth: prefixIcon != null ? 50 : 15),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              isDense: true,
              errorStyle: TextStyle(
                fontSize: 10.sp,
                color: errorColor,
                fontFamily: 'OpenSans',
              ),
              suffixIcon: Padding(
                  padding: const EdgeInsets.only(),
                  child: suffixIcon != null ? suffixIcon : Container()),
              suffixIconConstraints:
                  BoxConstraints(maxHeight: 40.h, maxWidth: 50.w),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              hintText: this.hintText,
              hintStyle: bodyTextStyleLato.copyWith(
                  fontSize: 16.sp, color: primaryColor.withOpacity(0.5))),
        ),
      ],
    );
  }
}
