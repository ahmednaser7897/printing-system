// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:print_system/model/Other/document.dart';

import '../model_helper.dart';



class Printer extends ModelHelper{
  late int id;
  late int num_of_docs;
  late int rel_id;
  late List<Document> docs;

  Printer(this.id, this.num_of_docs, this.rel_id, this.docs);
  @override
  Printer.fromDB(Map printer) {
    id = printer['id'];
    num_of_docs = printer['num_of_doc'];
    rel_id = printer['rel_id'];
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'num_of_doc': num_of_docs,
      "rel_id": rel_id,
    };
  }
}
