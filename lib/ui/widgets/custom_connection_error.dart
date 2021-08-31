import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/ui/widgets/custom_button.dart';
import 'package:kamus_kamek/utils/size_config.dart';

class CustomConnectionError extends StatelessWidget {
  const CustomConnectionError({Key? key, this.message, this.onTap})
      : super(key: key);

  final String? message;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.white,
       width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/connection_error.png",
            height: 176,
            width: 176,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: Text(
              message ?? "",
              textAlign: TextAlign.center,
              style: blackFontStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          SizedBox(
            width: SizeConfig.screenWidth * 0.45,
            child: Text(
              "Mohon periksa koneksi internet anda",
              textAlign: TextAlign.center,
              style: greyFontStyle.copyWith(fontSize: 12),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            label: "Coba Lagi",
            width: 152,
            backgroundColor: blue,
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
          )
        ],
      ),
    );
  }
}
