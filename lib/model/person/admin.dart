// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:print_system/model/person/person.dart';

import '../../view/admin/admin_main_screen.dart';

class Admin extends Person {
  Admin(String name, int id, int password, String user_name)
      : super(name, id, password, user_name) {
    print("hi i am admin");
  }
  @override
  Widget getMainScrean(){
    return const AdminMainScreen();
  }
}
