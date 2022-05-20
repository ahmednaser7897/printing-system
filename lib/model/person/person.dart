// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/cupertino.dart';


import '../../view/login/login_screen.dart';

import '../model_helper.dart';

class Person extends ModelHelper{
  late String name;
  late int id;
  late int password;
  late String user_name;
  Person(this.name, this.id, this.password, this.user_name);
  
  Person.fromDB(Map person) {
    name = person['name'];
    id = person['id'];
    user_name = person["email"];
    password = person['pass'];
  }
  @override
  Map<String, dynamic> toMap() {
    return {'name': name, 'id': id, "email": user_name, 'pass': password};
  }
  Widget getMainScrean(){
    return LoginScreen();
  }

  String getName() {
    return name;
  }

  int getId() {
    return id;
  }

  int getPassword() {
    return password;
  }

  String getUser_name() {
    return user_name;
  }

  void setName(String name) {
    this.name = name;
  }

  void setId(int id) {
    this.id = id;
  }

  void setPassword(int password) {
    this.password = password;
  }

  void setUser_name(String user_name) {
    this.user_name = user_name;
  }

  @override
  String toString() {
    return "person{" "name='" +
        name +
        '\'' +
        ", id=" +
        id.toString() +
        ", password=" +
        password.toString() +
        ", user_name='" +
        user_name +
        '\'' +
        '}';
  }
}
