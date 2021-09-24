import 'package:flutter/material.dart';
import 'package:kamus_kamek/utils/size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomDialog {
  static void showBottomSheet(
      {required BuildContext context,
      Function? onTap,
      required List<Widget> listCountries}) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        isScrollControlled: true,
        builder: (context) {
          return Container(
              constraints: BoxConstraints(
                maxHeight: SizeConfig.screenHeight * 0.9,
                minHeight: SizeConfig.screenHeight * 0.5,
              ),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: listCountries),
              ));
        });
  }

  static Future<bool?> showToast(String message) => Fluttertoast.showToast(
      msg: "$message", backgroundColor: Colors.black, textColor: Colors.white);
}
