import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/ui/screens/home_screen.dart';
import 'package:kamus_kamek/ui/screens/onboarding_screen.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/preferences.dart';
import 'package:kamus_kamek/utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) => Preferences.instance()
        .then((value) => value.isNewUser == null
            ? replaceScreen(context, OnBoardingScreen())
            : replaceScreen(context, HomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: linearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
