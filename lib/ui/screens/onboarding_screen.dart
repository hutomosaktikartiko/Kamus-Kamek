import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/config/text_style.dart';
import 'package:kamus_kamek/ui/screens/home_screen.dart';
import 'package:kamus_kamek/ui/widgets/custom_button.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/preferences.dart';
import 'package:kamus_kamek/utils/size_config.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/onboarding.png",
              height: 274,
              width: 300,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Translate Text\nIn Image",
              style: blackFontStyle.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Just take a Picture and get the\nTranslation",
              style: blackFontStyle.copyWith(
                  fontSize: 15, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeConfig.defaultMargin),
              child: CustomButton(
                linearGradient: linearGradient(),
                borderRadius: 100,
                label: "Start",
                onTap: () async {
                  Preferences.instance().then((pref) => pref.isNewUser = false);
                  replaceScreen(context, HomeScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
