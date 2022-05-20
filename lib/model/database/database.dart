// ignore_for_file: avoid_function_literals_in_foreach_calls, slash_for_doc_comments

import 'package:print_system/main.dart';
import 'package:print_system/model/Other/document.dart';

import 'package:print_system/model/database/dataBaseTabels.dart';
import 'package:print_system/model/person/person.dart';
import 'package:sqflite/sqflite.dart';

late Database database;
List<Map> tasks = [];

class DataBase {
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  createDB() async {
    await openDatabase(
      "a1.db",
      version: 1,
      onConfigure: _onConfigure,
      onCreate: (db, version) async {
        print("database is created");
        try {
          tables.forEach((element) async {
            await db.execute(element);
          });
          await insertInTables(db);
        } catch (e) {
          print("erorr is " + e.toString());
        }
      },
      onOpen: (db) {},
    ).then((value) {
      database = value;
    });
  }

  /***************  genral Functions *********************/
  Future<List<Map>> getTableDataFromDB({required String table}) async {
    print("table is $table");
    String sql = "select * from $table";
    // return list of map of persons
    return await database.rawQuery(sql);
  }

  void deletItemFromDB(int id, String table) async {
    await database.transaction((txn) async {
      database.rawDelete('DELETE FROM $table WHERE id = $id').then((value) {
        print("peson $id in table $table deleted successfully");
      }).catchError((error) {
        print("deleting peson $id in table $table error: $error");
      });
    });
  }

 /***************  person Functions *********************/
  Future<List<Map>> getPersonDataFromDB(
      {required String table, required username, required pass}) async {
    print("table is $table");
    String sql = "select * from $table where email ='" +
        username +
        "' and pass =" +
        pass.toString();
    // return list of map of persons
    return await database.rawQuery(sql);
  }

  getPersonDataFromDbByID({required String table, required int id}) async {
    print("table is $table");
    String sql = "select * from $table where id =" + id.toString();
    // return list of map of persons
    return (await database.rawQuery(sql))[0];
  }

  Future<int> insertPersonDataToDB(Person p, String table) async {
    return await database.insert(table, p.toMap());
  }

   /***************  user Functions *********************/
  Future<bool> isUserExist(int id, String username) async {
    String sql = "select * from user where id =" + id.toString();
    String sql2 = "select * from user where email = '$username' ";
    List user = await database.rawQuery(sql);
    List user2 = await database.rawQuery(sql2);
    if (user.isEmpty && user2.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<Map>> getAllUsersRequest(String type) async {
    String sql =
        'select doc_id , pages , copies ,  url ,document.name ,user.id as userID ,user.name as username  from document_status join  user on user_id =user.id join document on doc_id=document.id where status=\'$type\' ';
    return await database.rawQuery(sql);
  }

  Future<List<Map>> getUserRequests(String type, int userId) async {
    String sql =
        'select doc_id , pages , copies ,  url ,document.name ,user.id as userID ,user.name as username  from document_status join  user on user_id =user.id join document on doc_id=document.id where status=\'$type\' and user.id=$userId ';
    return await database.rawQuery(sql);
  }

  Future<void> updateUserTable(String tableField, value, int userId) async {
    await database
        .rawUpdate("UPDATE user set $tableField= $value WHERE  id =$userId");
  }

 /***************  genral printer *********************/

  Future<int> getNumberOfAccPrinter(int printerId) async {
    String sql =
        'select count(printer_id) as Total from document_status where printer_id = ${printerId.toString()} and status= \'accepted\' ';
    List result = await database.rawQuery(sql);
    return result[0]['Total']!;
  }

  Future<List<Map>> getAccDocWithPrinter(printerId) async {
    String sql =
        'select doc_id , pages , copies ,  url ,document.name ,user.id as userID  , user.name as username  from document_status join  user on user_id =user.id join document on doc_id=document.id where status=\'accepted\' and printer_id=${printerId.toString()}';
    return await database.rawQuery(sql);
  }

  Future<void> updatePrinterIdInStatusTable(
      String table, int value, int docId, int userId) async {
    await database.rawUpdate(
        "UPDATE $table set printer_id= $value WHERE doc_id= $docId and user_id =$userId");
  }

 /***************  document Functions *********************/
  Future<bool> isDocIdUsed(int id) async {
    String sql = "select * from document where id =" + id.toString();
    List doc = await database.rawQuery(sql);
    if (doc.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> insertDocumentDataToDB(Document doc) async {
    return await database.insert("document", {
      "id": doc.id,
      "name": "'${doc.name}'",
      "url": "'${doc.url}'",
      "pages": doc.pages,
      "copies": doc.copies
    });
  }

  Future<int> insertDocumentStateDataToDB(int id) async {
    return await database.rawInsert(
        'INSERT INTO document_status(user_id,doc_id,status) VALUES( $personId, $id,"new")');
  }

  Future<void> deleteFromeDocumentStatus(docId, userId) async {
    String sql =
        "delete from document_status where (doc_id, user_id) in (($docId, $userId))";
    await database.transaction((txn) async {
      database.rawDelete(sql).then((value) {}).catchError((error) {
        print("deleting deleteFromeDocumentStatus error: $error");
      });
    });
  }

  Future<void> updateStatusinStatusTable(
      String table, int docId, int userId) async {
    await database.rawUpdate(
        "UPDATE $table set status= 'accepted' WHERE doc_id= $docId and user_id =$userId");
  }
  
}
