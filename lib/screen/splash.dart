import 'package:cats_dog_detector_app/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/cat.png',
      backgroundColor: Colors.yellow,
      duration: 3000,
      splashIconSize: 300,
      nextScreen: HomeScreen(),
      splashTransition: SplashTransition.rotationTransition,
      //pageTransitionType: PageTransitionType.scale,
    );
  }
}
