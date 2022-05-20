// ignore_for_file: unused_local_variable

import 'package:print_system/model/Other/document.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:print_system/model/Other/printer.dart';

import 'package:print_system/model/person/user.dart';
import '../../../model/Other/document.dart';
import '../../../view/admin/NewRequest.dart';
import '../../../view/admin/printer_state.dart';
import '../../../view/admin/settings.dart';
import '../../../view/admin/user_manipulation.dart';
import '../cubit_helper.dart';
import 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> with CubitHelper,AdminHelper{
  AdminCubit() : super(Initial());
  static AdminCubit get(context) => BlocProvider.of(context);

  List<Widget> adminScreens = [
    const NewRequest(),
    const PrinterState(),
    const UserMaintain(),
    const Settings()
  ];

  List<String> adminHeaders = ["New Requests", "Printers", "Users", "Other"];
  
  int adminBottomBarCurrentIndex = 0;

  void createDataBase() async {
    emit(LoadingCreateDB());
    await db.createDB();
    emit(CreateDB());
  }

  changeAdminBottomBarIndex(value) {
    adminBottomBarCurrentIndex = value;
    if (adminBottomBarCurrentIndex == 0) {
      getUsersNewRequests();
    }
    if (adminBottomBarCurrentIndex == 2) {
      getUsers();
    }
    if (adminBottomBarCurrentIndex == 1) {
      getPrinters();
    }
    emit(ChangBottomBarIndex());
  }
  
  //requests screans Functions
  List<Document> newRequests = [];
  getUsersNewRequests() async {
    emit(LoadingGetNewRequests());
    newRequests = await getUsersRequest("new");
    emit(GetNewRequests());
  }

  List<Document> acceptedRequests = [];
  getUsersAcceptedRequests() async {
    acceptedRequests = await getUsersRequest("accepted");
    emit(GetAcceptedRequests());
  }

  List<Document> doneRequests = [];
  getUsersDoneRequests() async {
    doneRequests = await getUsersRequest("done");
    emit(GetDoneRequests());
  }

  acceptUserRequest(Document doc) async {
    updateUserWallet(doc);
    int id = getPrinterIdWithLessDocuments(printers);
    print("p is " + id.toString());
    doc.updateDoc(id);
    newRequests.remove(doc);
    emit(AcceptUserRequest());
  }

  void rejectUserRequest(Document doc) {
    db.deleteFromeDocumentStatus(doc.id, doc.userID);
    newRequests.remove(doc);
    emit(RejectUserRequest());
  }

//requests printers Functions
  List<Printer> printers = [];
  void getPrinters() {
    emit(LoadingGetAllPrinters());
    printers = [];
    db.getTableDataFromDB(table: "printer").then((value) async {
      printers = await mapOfPrintersToObjectsOfPrinters(value);
      emit(GetAllPrinters());
    }).catchError((onError) {
      print("error in getAllPrinters ${onError.toString()}");
    });
    emit(GetAllPrinters());
  }

//users & printers Functions
  List<User> users = [];
  void getUsers() {
    emit(LoadingGetAllUsers());
    users = [];
    db.getTableDataFromDB(table: "user").then((value) {
      users = mapOfUsersToObjectsOfUsers(value);
      emit(GetAllUsers());
    }).catchError((onError) {
      print("error in getAllUsers ${onError.toString()}");
    });
    emit(GetAllUsers());
  }

  void deleteUserFromDB(User user) {
    user.deleteMeFromDB();
    users.remove(user);
    emit(DeleteUserFromDB());
  }

  addUserToDB(User user) {
    user.addUserToDB();
    emit(AddUserToDB());
  }
  //other
  void onAdminLogout() {
    users = [];
    printers = [];
    acceptedRequests = [];
    newRequests = [];
    doneRequests = [];
    emit(OnAdminLogout());
  }
}
