// ignore_for_file: non_constant_identifier_names, camel_case_types


import '../model_helper.dart';

class DocumentState extends ModelHelper{
  late int admin_id;
  late int doc_id;
  late String printer_id;
  late int user_id;
  late String status;

  DocumentState(
      {required this.admin_id,
      required this.doc_id,
      required this.printer_id,
      required this.user_id,
      required this.status});
  @override
  DocumentState.fromDB(Map document) : super.fromDB() {
    admin_id = document['admin_id'];
    doc_id = document['doc_id'];
    printer_id = document['printer_id'];
    user_id = document['user_id'];
    status = document['status'];
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'admin_id': admin_id,
      'printer_id': printer_id,
      "doc_id": doc_id,
      'user_id': user_id,
      "status": status,
    };
  }
}
