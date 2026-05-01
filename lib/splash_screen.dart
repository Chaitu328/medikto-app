import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medikto/features/onboarding/views/onboarding_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  static const Color darkBg = Color(0xFF121212);
  static const Color accentCyan = Color(0xFF81DEEA);
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the next screen after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreens()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: darkBg,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: darkBg),
          child: Center(
            child: Image.asset(
              "assets/images/main-logo.png",
              width: MediaQuery.sizeOf(context).width * 0.4,
              color: accentCyan,
            ),
          ),
        ),
      ),
    );
  }
}
