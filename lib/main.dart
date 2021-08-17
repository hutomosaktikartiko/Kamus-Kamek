import 'package:flutter/material.dart';
import 'package:kamus_kamek/cubit/country_cubit.dart';
import 'package:kamus_kamek/ui/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountryCubit(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Raleway", backgroundColor: Colors.white),
        home: SplashScreen(),
      ),
    );
  }
}
