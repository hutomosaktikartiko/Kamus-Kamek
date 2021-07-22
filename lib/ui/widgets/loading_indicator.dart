import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/config/text_style.dart';

Widget loadingIndicator({double? size}) =>
    SpinKitCircle(color: mainColor, size: size ?? 50);

Widget customLoadingIndicator = Dialog(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [loadingIndicator()],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: Text(
          "Loading...",
          style: blackFontStyle.copyWith(fontSize: 25),
        ),
      ),
    ],
  ),
);
