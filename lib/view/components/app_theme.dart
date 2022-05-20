// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:print_system/view/components/app_colors.dart';

var LightTheme = ThemeData(
    primarySwatch: AppColors.primarySwatchColor,
    fontFamily: "Cairo",
    scaffoldBackgroundColor: AppColors.lightBackGroundColor,
    canvasColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.grey, size: 20),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.lightBackGroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColors.lightBackGroundColor,
      elevation: 0,
      titleSpacing: 20,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontFamily: "Cairo",
          fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 30,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(
          overflow: TextOverflow.fade,
        )),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor),
    iconTheme: const IconThemeData(color: Colors.grey),
    primaryIconTheme: const IconThemeData(color: Colors.grey),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.grey,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
    ));

var darkTheme = ThemeData(
    primarySwatch: AppColors.primarySwatchColor,
    fontFamily: "Cairo",
    iconTheme: const IconThemeData(color: Colors.white),
    scaffoldBackgroundColor: AppColors.darkBackGroundColor,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.darkBackGroundColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppColors.darkBackGroundColor,
        elevation: 0,
        titleSpacing: 20,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white, size: 20)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      backgroundColor: AppColors.darkBackGroundColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      elevation: 30,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.primaryColor,
    ));

Widget slider(context) {
  return Padding(
    padding: const EdgeInsetsDirectional.only(end: 20),
    child: Column(children: [
      const SizedBox(height: 5),
      Container(
        height: 0.5,
        color: AppColors.primaryColor,
      ),
      const SizedBox(height: 5)
    ]),
  );
}

void navigatorTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigatorAndEnd(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
void showToast(String message, States state) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: stateColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

// ignore: constant_identifier_names
enum States { SUCCESS, ERORR, WARNING }
Color stateColor(States state) {
  Color color;
  switch (state) {
    case States.SUCCESS:
      color = Colors.blue;
      break;
    case States.ERORR:
      color = Colors.red;
      break;
    case States.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

String token = '';
