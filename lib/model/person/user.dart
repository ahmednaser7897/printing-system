// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:print_system/model/person/person.dart';

import '../../view/user/user_main_screen.dart';
import '../Other/document.dart';
import '../database/database.dart';

class User extends Person {
  int visa = 0;
  int charge = 0;
  DataBase db = DataBase();

  User(String name, int id, int password, String user_name, this.visa,
      this.charge)
      : super(name, id, password, user_name);

  @override
  User.fromDB(Map user)
      : super(user['name'], user['id'], user['pass'], user['email']) {
    visa = user['visa'];
    charge = user['charge'];
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      "email": user_name,
      'pass': password,
      "visa": visa,
      'charge': charge
    };
  }

  @override
  String toString() {
    return super.toString() +
        "visa is " +
        visa.toString() +
        "charge is " +
        charge.toString();
  }
  @override
  Widget getMainScrean(){
    return const UserMainScreen();
  }
  void deleteMeFromDB() {
    db.deletItemFromDB(id, "user");
  }

  void addUserToDB() {
    db.insertPersonDataToDB(this, "user").then((value) {
      print("user value $value added");
      print("user id $id added");
      return value;
    }).catchError((onError) {
      print("erorr in addUserToDB 2 $id ${onError.toString()}");
    });
  }

  Future<void> updateUserWallet(Document doc) async {
    await db.updateUserTable(
        "charge", charge - (doc.copies * doc.pages * 2), id);
  }
}
