import 'package:flutter/material.dart';
import 'package:order_traking/core/contsants/colorConstant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        centerTitle: true,
        title: Text(
          "H O M E",
          style: TextStyle(
            color: ColorConstants.backgroundColor,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 30,
            crossAxisCount: 2,
            childAspectRatio: 1.2,
          ),
          children: [
            HomeButton(
              title: "O R D E R S",
              routeName: "myOrders",
            ),
            HomeButton(
              title: "A D D   O R D E R S",
              routeName: "addOrder",
            ),
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String title;
  final String routeName;

  const HomeButton({
    super.key,
    required this.title,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorConstants.primaryColor,
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorConstants.backgroundColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
