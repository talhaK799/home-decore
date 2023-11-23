import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/constants/typedef.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final String? hintText;
  final stringParamFunction? onChange;
  final double? height;
  SearchField({this.hintText, this.onChange, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFCFCFCF))),
      child: TextField(
        // onChanged: onChange!,
        decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.only(start: 10),
            // prefixIcon: Icon(Icons.search, size: 24.h, color: blackColor),
            border: InputBorder.none,
            hintText: '$hintText',
            hintStyle: normalTextStyleLato.copyWith(
                color: Color(0xFFCFCFCF), fontSize: 14)),
      ),
    );
  }
}
