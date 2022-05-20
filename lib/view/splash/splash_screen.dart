import 'dart:async';
import 'package:flutter/material.dart';
import 'package:print_system/view/components/app_colors.dart';
import 'package:print_system/view/splash/intro_screen.dart';
import '../components/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => navigatorAndEnd(
        context,
        const IntroScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/printer.png",
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  " YAES",
                  style: TextStyle(
                      color: AppColors.appColor3,
                      fontFamily: "Cairo",
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text("printing system",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: "Cairo",
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
