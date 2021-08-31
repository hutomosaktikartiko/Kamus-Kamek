import 'package:flutter/material.dart';
import 'package:kamus_kamek/config/custom_color.dart';
import 'package:kamus_kamek/cubit/country/country_cubit.dart';
import 'package:kamus_kamek/ui/screens/home_screen.dart';
import 'package:kamus_kamek/ui/screens/onboarding_screen.dart';
import 'package:kamus_kamek/ui/widgets/custom_connection_error.dart';
import 'package:kamus_kamek/utils/navigator.dart';
import 'package:kamus_kamek/utils/preferences.dart';
import 'package:kamus_kamek/utils/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamus_kamek/cubit/api_key/api_key_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isError = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    getData().then((value) {
      if (value) {
        Preferences.instance().then((value) => value.isNewUser == null
            ? replaceScreen(context, OnBoardingScreen())
            : replaceScreen(context, HomeScreen()));
      } else {
        setState(() {
          isError = true;
        });
      }
    });
  }

  Future<bool> getData() async {
    await Future.wait([
      context.read<CountryCubit>().getCountries(),
      context.read<APIKeyCubit>().getAPIKeys()
    ]);
    if (context.read<APIKeyCubit>().state is APIKeyLoaded &&
        context.read<CountryCubit>().state is CountryLoaded) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: (isError)
          ? RefreshIndicator(
              onRefresh: () async {
                initData();
              },
              child: ListView(
                children: [
                  CustomConnectionError(
                    height: SizeConfig.screenHeight * 0.9,
                    onTap: () {
                      initData();
                    },
                  ),
                ],
              ),
            )
          : Container(
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
