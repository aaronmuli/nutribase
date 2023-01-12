import 'package:flutter/material.dart';
import 'package:nutribase/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main(List<String> args) {
  runApp(const Nutribase());
}

class Nutribase extends StatefulWidget {
  const Nutribase({Key? key}) : super(key: key);

  @override
  State<Nutribase> createState() => _NutribaseState();
}

class _NutribaseState extends State<Nutribase> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // remove the debug banner
        title: "Nutribase",
        home: AnimatedSplashScreen(
            duration: 3000,
            splashIconSize: 90,
            backgroundColor: Colors.green,
            splashTransition: SplashTransition.fadeTransition,
            splash: Image.asset(
              "lib/assets/wellness.png",
              fit: BoxFit.cover,
              color: Colors.white,
            ),
            nextScreen: const Home()));
  }
}
