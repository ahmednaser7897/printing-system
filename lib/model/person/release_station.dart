// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:print_system/model/person/person.dart';

import '../../view/release_man/releaseMan_main_screan.dart';

class ReleaseMan extends Person {
  ReleaseMan(String name, int id, int password, String user_name)
      : super(name, id, password, user_name) {
    print("hi i am ReleaseMan");
  }
  @override
  Widget getMainScrean(){
    return const ReleaseManScreen();
  }
}
