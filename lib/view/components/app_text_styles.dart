import 'package:flutter/material.dart';
import 'package:print_system/view/components/app_colors.dart';

class AppTextStyles {
  static TextStyle title() => const TextStyle(
        color: AppColors.appColor4,
        fontFamily: "Cairo",
        fontSize: 20,
        fontWeight: FontWeight.w800,
      );

  static TextStyle subtitle() => const TextStyle(
        color: Colors.grey,
        fontFamily: "Cairo",
        fontSize: 15,
      );
  static TextStyle bodyText() => const TextStyle(
        color: Colors.black,
        fontFamily: "Cairo",
        fontSize: 17,
      );
  static TextStyle buttonText() => const TextStyle(
        color: Colors.white,
        fontFamily: "Cairo",
        fontSize: 17,
      );
  static TextStyle title2() => const TextStyle(
        color: Colors.white,
        fontFamily: "calibri",
        fontSize: 23,
        fontWeight: FontWeight.w400,
      );

  static TextStyle subtitle2() => const TextStyle(
        color: Colors.grey,
        fontFamily: "calibri",
        fontSize: 17,
      );
  static TextStyle bodyText2() => const TextStyle(
        color: Colors.black,
        fontFamily: "calibri",
        fontSize: 17,
      );
}
