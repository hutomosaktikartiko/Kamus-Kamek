import 'package:flutter/material.dart';
import 'package:kamus_kamek/cubit/language_cubit.dart';
import 'package:kamus_kamek/ui/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Raleway", backgroundColor: Colors.white),
        home: SplashScreen(),
      ),
    );
  }
}
