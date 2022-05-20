// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

import '../../view/login/login_screen.dart';
import '../../view/splash/splash_screen.dart';
abstract class MainScrean{
  Widget getMainScrean(){
    return  LoginScreen();
  }
}
class SplashModel extends MainScrean{
  SplashModel();

  @override
  Widget getMainScrean(){
    return const SplashScreen();
  }

}

