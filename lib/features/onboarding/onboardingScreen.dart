import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:order_traking/core/contsants/colorConstant.dart';
import 'package:order_traking/core/network/local/cachHelper.dart';
import 'package:order_traking/features/home/presentation/screens/home.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: OverBoard(
        buttonColor: ColorConstants.bodyColor,
        allowScroll: true,
        pages: pages,
        showBullets: true,
        inactiveBulletColor: ColorConstants.bodyColor,
        skipCallback: () {
          // Show a Snackbar when "Skip" is clicked
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Skip clicked",
                style: TextStyle(color: ColorConstants.titleColor),
              ),
            ),
          );
        },
        finishCallback: () {
          CacheHelper.setData(key: "seenOnboarding", value: true);
          // Navigate to a new screen when onboarding is finished
          Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
        },
      ),
    );
  }

  // List of onboarding Screen
  final pages = [
    PageModel(
      bodyColor: ColorConstants.bodyColor,
      titleColor: ColorConstants.titleColor,
      color: ColorConstants.backgroundColor,
      imageAssetPath: 'assets/on1.jpg',
      title: 'Track Your Orders',
      body: 'Easily monitor the status of your orders in real-time.',
      doAnimateImage: true,
    ),
    PageModel(
      bodyColor: ColorConstants.bodyColor,
      titleColor: ColorConstants.titleColor,
      color: ColorConstants.backgroundColor,
      imageAssetPath: 'assets/on2.jpg',
      title: 'Get Updates',
      body: 'Receive instant notifications about your order progress',
      doAnimateImage: true,
    ),
    PageModel(
      bodyColor: ColorConstants.bodyColor,
      titleColor: ColorConstants.titleColor,
      color: ColorConstants.backgroundColor,
      imageAssetPath: 'assets/on3.jpg',
      title: 'Stay in Control',
      body: 'Manage your deliveries and never miss an update.',
      doAnimateImage: true,
    ),
  ];
}
