

import '../../main.dart';
import '../../model/Other/document.dart';
import '../../model/Other/printer.dart';
import '../../model/database/database.dart';
import '../../model/person/user.dart';


class CubitHelper{
  DataBase db = DataBase();
  
  List<Document> mapOfDocsToObjectsOfDocs(List printerDocs) {
    List<Document> docs = [];
    if (printerDocs.isNotEmpty) {
      for (var element in printerDocs) {
        docs.add(Document.fromDB(element));
      }
    }
    return docs;
  }

  Future<User> getUser(int id) async {
   return User.fromDB(await db.getPersonDataFromDbByID(id: id, table: "user"));
  }

  bool checkIfUserHasEnoughCharge({required User user,required int pages, required int copies}) {
    int costOfRequest = pages * copies * 2;
    if (user.charge >= costOfRequest) {
      return true;
    } else {
      return false;
    }
  }
   
}

mixin  AdminHelper on CubitHelper{

  List<User> mapOfUsersToObjectsOfUsers(List usersMap) {
    List<User> users = [];
    if (usersMap.isNotEmpty) {
      for (var element in usersMap) {
        users.add(User.fromDB(element));
      }
    }
    return users;
  }

  Future<List<Printer>> mapOfPrintersToObjectsOfPrinters( List mapOfPrinters) async {
    List<Printer> printers = [];
    if (mapOfPrinters.isNotEmpty) {
      for (var element in mapOfPrinters) {
        Printer p =await getPrinterFromMap(element['id'], element['rel_id']);
        printers.add(p);
      }
    }
    return printers; 
  }

  Future<Printer> getPrinterFromMap(int id,int relId) async {
    List printerDocs = await db.getAccDocWithPrinter(id);
    List<Document> docs = mapOfDocsToObjectsOfDocs(printerDocs);
    int numberOFDocs = await db.getNumberOfAccPrinter(id);
    return Printer(id, numberOFDocs, relId, docs);
  }

  int getPrinterIdWithLessDocuments(List<Printer> printers ) {
    int id = 0;
    int docs = 100;
    for (var element in printers) {
      if (element.num_of_docs < docs) {
        id = element.id;
        docs = element.num_of_docs;
      }
    }
    if (id == 0) {
      return 1;
    } else {
      return id;
    }
  }
  
  Future<List<Document>> getUsersRequest(String type) async {
    List requests = await db.getAllUsersRequest(type);
    print(requests.toString());
    List<Document> docs = mapOfDocsToObjectsOfDocs(requests);
    return docs;
  }

  Future<bool> isUserExist(int id, String username) async {
    return await db.isUserExist(id, username);
  }
  
  void updateUserWallet(Document doc) async {
    User user = await getUser(doc.userID);
    await user.updateUserWallet(doc);
  }
}

mixin UserHelper on CubitHelper{

  Future<List<Document>> getUserDocs(String type) async {
    List requests = await db.getUserRequests(type, personId!);
    List<Document> docs = mapOfDocsToObjectsOfDocs(requests);
    return docs;
  }
  Future<bool> isDocIdUsed(int id) async {
    return await db.isDocIdUsed(id);
  }

}