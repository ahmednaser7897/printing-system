// ignore_for_file: camel_case_types



import '../database/database.dart';
import '../model_helper.dart';

class Document extends ModelHelper {
  late int id;
  late String name;
  late String username;
  late String url;
  late int pages;
  late int copies;
  late int userID;

  DataBase db = DataBase();
  void setID(int id) {
    this.id = id;
  }

  void setPages(int pages) {
    this.pages = pages;
  }

  void setCopies(int copies) {
    this.copies = copies;
  }

  void setUsername(String username) {
    this.username = username;
  }

  Document(
      this.id, this.name, this.url, this.pages, this.copies, this.username);
  @override
  Document.fromDB(Map document) : super.fromDB() {
    id = document['doc_id'];
    userID = document['userID'];
    name = document['name'];
    username = document['username'];
    url = document['url'];
    pages = document['pages'];
    copies = document['copies'];
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'doc_id': id,
      'url': url,
      "name": name,
      'pages': pages,
      "copies": copies,
    };
  }

  void updateDoc(printerId) async {
    await db.updatePrinterIdInStatusTable(
        "document_status", printerId, id, userID);
    await db.updateStatusinStatusTable("document_status", id, userID);
  }
}
