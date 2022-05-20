// ignore_for_file: file_names, unused_local_variable

import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../../model/Other/document.dart';
import '../../../model/database/database.dart';

class UserDocumentHelper{
  DataBase db = DataBase();
  

  Document? phoneDoc;
  void getDocFromPhone() async {
    phoneDoc = await uploadFile();
  }

  FilePickerResult? filePickerResult;
  Future<Document> uploadFile() async {
    Document doc = Document(0, "", "", 0, 0, "");
    filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'pdf', 'docx'],
    );
    if (filePickerResult == null) {
      print("No file selected");
      return doc;
    } else {
      File uploadedFile = File(filePickerResult!.files.single.path!);
      doc = Document(0,
          filePickerResult!.files.single.name.split(".").first,
          filePickerResult!.files.single.path!.split("/").last.split(".").first,
          0, 0,""
      );
      return doc;
    }
  }

  void upLoadDocument(
      {required int id, required int copies, required int pages}) async {
    if (phoneDoc != null) {
      phoneDoc!.setID(id);
      phoneDoc!.setCopies(copies);
      phoneDoc!.setPages(pages);
      await insertDocumentDataToDB(phoneDoc!).then((value) async {
        await insertDocumentStateDataToDB(id);
      });
    } else {
      print("no file here!");
    }
  }

  insertDocumentDataToDB(Document doc) async {
    await db.insertDocumentDataToDB(doc);
  }

  insertDocumentStateDataToDB(int docId) async {
    await db.insertDocumentStateDataToDB(docId);
  }

  void endUploadFile() {
    filePickerResult = null;
    phoneDoc = null;
  }
}