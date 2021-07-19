import 'package:flutter/material.dart';

const String baseUrlAPiCountry = "";

startScreen(BuildContext context, Widget screen) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

replaceScreen(BuildContext context, Widget screen) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => screen));

removeScreen(BuildContext context, Widget screen) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => screen), (route) => false);

closeScreen<T>(BuildContext context, [T? value]) => Navigator.pop<T>(context);
