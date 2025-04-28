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
          "H O M E ",
          style: TextStyle(color: ColorConstants.backgroundColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 30,
            crossAxisCount: 2,
            childAspectRatio: 1.4,
          ),
          children: [
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstants.primaryColor,
                ),
                child: Center(
                  child: Text(
                    "O R D E R S ",
                    style: TextStyle(
                      color: ColorConstants.backgroundColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "myOrders");
              },
            ),
            // SizedBox(width: 30,),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstants.primaryColor,
                ),
                child: Center(
                  child: Text(
                    " A D D   O R D E R S ",
                    style: TextStyle(
                      color: ColorConstants.backgroundColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, "addOrder");
              },
            ),
          ],
        ),
      ),
    );
  }
}
