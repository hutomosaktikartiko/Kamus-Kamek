import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/utils/size_config.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.backgroundColor,
      this.borderColor,
      this.borderRadius,
      this.child,
      this.label,
      this.labelStyle,
      this.onTap,
      this.linearGradient,
      this.padding,
      this.width})
      : super(key: key);

  final Widget? child;
  final String? label;
  final Function? onTap;
  final LinearGradient? linearGradient;
  final Color? borderColor, backgroundColor;
  final double? width, borderRadius, padding;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width == null) ? SizeConfig.screenWidth : width,
      decoration: BoxDecoration(
        gradient: linearGradient ?? null,
        color: backgroundColor ?? null,
        borderRadius: BorderRadius.circular(
                    (borderRadius == null) ? 10 : borderRadius!),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: (padding == null) ? 0 : SizeConfig.defaultMargin),
      height: 50,
      child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    (borderRadius == null) ? 10 : borderRadius!),)
          ),
          child: child ??
              Text(label ?? "",
                  style: (labelStyle == null)
                      ? whiteFontStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600)
                      : labelStyle),
          onPressed: () async {
            if (onTap != null) {
              onTap!();
            }
          }),
    );
  }
}
