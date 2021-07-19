import 'package:flutter/material.dart';
import 'package:kamus_kamek/ui/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Raleway",
        backgroundColor: Colors.white
      ),
      home: SplashScreen(),
    );
  }
}