// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppLogo extends StatelessWidget {
  String? titel;
  AppLogo({Key? key, this.titel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/images/printer.png",
          fit: BoxFit.cover,
          height: 30,
          width: 30,
        ),
        const Text(
          " YAES",
          style: TextStyle(
              color: AppColors.appColor3,
              fontFamily: "Cairo",
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        const Text("printing system",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontFamily: "Cairo",
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        if (titel != null)
          Expanded(
            child: Text(" : ${titel!}",
                style: const TextStyle(
                    color: Color(0xff1E5880),
                    fontFamily: "Cairo",
                    fontSize: 15,
                    textBaseline: TextBaseline.ideographic,
                    fontWeight: FontWeight.bold)),
          )
      ],
    );
  }
}
