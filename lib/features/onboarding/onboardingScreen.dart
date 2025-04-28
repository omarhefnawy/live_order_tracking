import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:order_traking/core/contsants/colorConstant.dart';
import 'package:order_traking/core/network/local/cachHelper.dart';
import 'package:order_traking/features/home/presentation/screens/home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Skip clicked",
                style: TextStyle(
                  color: ColorConstants.titleColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
        finishCallback: () {
          CacheHelper.setData(key: "seenOnboarding", value: true);
          Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
        },
      ),
    );
  }

  // List of onboarding screens
  final pages = [
    PageModel(
      color: ColorConstants.backgroundColor,
      imageAssetPath: 'assets/on1.jpg',
      title: 'Track Your Orders',
      body: 'Easily monitor the status of your orders in real-time.',
      titleColor: ColorConstants.titleColor,
      bodyColor: ColorConstants.bodyColor,
      doAnimateImage: true,
    ),
    PageModel(
      color: ColorConstants.backgroundColor,
      imageAssetPath: 'assets/on2.jpg',
      title: 'Get Updates',
      body: 'Receive instant notifications about your order progress.',
      titleColor: ColorConstants.titleColor,
      bodyColor: ColorConstants.bodyColor,
      doAnimateImage: true,
    ),
    PageModel(
      color: ColorConstants.backgroundColor,
      imageAssetPath: 'assets/on3.jpg',
      title: 'Stay in Control',
      body: 'Manage your deliveries and never miss an update.',
      titleColor: ColorConstants.titleColor,
      bodyColor: ColorConstants.bodyColor,
      doAnimateImage: true,
    ),
  ];

}
