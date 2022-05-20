// ignore_for_file: file_names

import '../Other/document.dart';
import '../database/database.dart';

class UserDoc {
  String state;
  Document doc;
  UserDoc(this.state, this.doc);
  DataBase db = DataBase();

  void deleteUserDocuments() {
    db.deletItemFromDB(doc.id, "document");
  }
}
