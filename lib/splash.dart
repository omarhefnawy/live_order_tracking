import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_traking/core/network/local/cachHelper.dart';
import 'package:order_traking/features/home/presentation/screens/home.dart';
import 'package:order_traking/features/onboarding/onboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    User? user = FirebaseAuth.instance.currentUser; // Check if the user is logged in
    if (user != null) {
      if (user.emailVerified) {
        // If user is verified, go to Home
        Navigator.pushReplacementNamed(context, "home");
      } else {
        // If user is not verified, show login page
        Navigator.pushReplacementNamed(context, "login");
      }
    } else {
      // If no user is logged in, show onboarding or login
      bool seenOnboarding = CacheHelper.getData(key: 'seenOnboarding') ?? false;
      Navigator.pushNamedAndRemoveUntil(
        context,
        seenOnboarding ? "login" : "onboarding",
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Image.asset(
          'assets/logo.jpeg', // Replace with your logo
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
