import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/config/text_style.dart';

class CustomForm extends StatelessWidget {
  const CustomForm(this.controller,
      {Key? key,
      this.labelStyle,
      this.readOnly = false,
      this.hintText,
      this.labelText,
      this.isShowBorder = false})
      : super(key: key);

  final TextEditingController controller;
  final TextStyle? labelStyle;
  final String? hintText, labelText;
  final bool isShowBorder;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText ?? "English",
          style: (labelStyle == null)
              ? mainColor2FontStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500)
              : labelStyle,
        ),
        SizedBox(
          height: 19,
        ),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          style: blackFontStyle.copyWith(
              fontSize: 30, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: hintText ?? "Enter text",
            hintStyle: mainColor2FontStyle.copyWith(
                color: mainColor2.withOpacity(0.21),
                fontSize: 30,
                fontWeight: FontWeight.w600),
             ),
        ),
      ],
    );
  }
}