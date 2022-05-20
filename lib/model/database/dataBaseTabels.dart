// ignore_for_file: file_names

import 'package:sqflite/sqflite.dart';

String t1 =
    " create table document(id int primary key ,name varchar(255),url varchar(255),pages int , copies int );";
String t2 =
    "create table user(id int primary key ,name varchar(50),email varchar(100),pass int ,visa int ,charge int);";
String t3 =
    "create table admin(id int primary key ,name varchar(50),email varchar(100),pass int );";
String t4 =
    "create table release_man(id int primary key ,name varchar(50),email varchar(100),pass int );";
String t5 =
    "create table printer(id int primary key ,num_of_doc int ,rel_id int ,FOREIGN KEY (rel_id)  REFERENCES release_man(id) on delete cascade on update cascade );";
String t6 = """
  create table  document_status(
    admin_id int,doc_id int ,  printer_id int ,  user_id int, status varchar(10),
    foreign key (admin_id)  references admin (id) on delete cascade on update cascade,
    foreign key (doc_id)   references document (id) on delete cascade on update cascade,
    foreign key (user_id)   references user (id) on delete cascade on update cascade,
    foreign key (printer_id)  references printer (id) on delete cascade on update cascade,
    constraint p_d primary key(doc_id,user_id)
  );""";

List<String> tables = [t1, t2, t3, t4, t5, t6];

Future<void> insertInTables(Database db) async {
  await db.insert(
      "admin", {"id": 1, "name": "ahmed", "email": "ahmed", "pass": 123});
  await db
      .insert("admin", {"id": 2, "name": "saif", "email": "saif", "pass": 123});

  await db.insert("release_man",
      {"id": 200, "name": "islam", "email": "islam", "pass": 123});
  await db.insert("release_man",
      {"id": 201, "name": "mohamed", "email": "mohamed", "pass": 123});

  await db.insert("user", {
    "id": 100,
    "name": "me",
    "email": "me1",
    "pass": 123,
    "visa": 12345,
    "charge": 321
  });
  await db.insert("user", {
    "id": 101,
    "name": "no",
    "email": "bo2",
    "pass": 123,
    "visa": 12345,
    "charge": 321
  });
  await db.insert("user", {
    "id": 102,
    "name": "ma",
    "email": "me3",
    "pass": 123,
    "visa": 12345,
    "charge": 321
  });
  await db.insert("user", {
    "id": 103,
    "name": "ns",
    "email": "bo4",
    "pass": 123,
    "visa": 12345,
    "charge": 321
  });
  await db.insert("user", {
    "id": 104,
    "name": "md",
    "email": "me4",
    "pass": 123,
    "visa": 12345,
    "charge": 321
  });
  await db.insert("user", {
    "id": 105,
    "name": "nf",
    "email": "bo5",
    "pass": 123,
    "visa": 12345,
    "charge": 321
  });
  await db.insert("user", {
    "id": 106,
    "name": "mg",
    "email": "me6",
    "pass": 123,
    "visa": 12345,
    "charge": 321
  });
  await db.insert("user", {
    "id": 107,
    "name": "nh",
    "email": "bo7",
    "pass": 123,
    "visa": 12345,
    "charge": 321
  });

  await db.insert("printer", {"id": 1, "num_of_doc": 0, "rel_id": 201});
  await db.insert("printer", {"id": 2, "num_of_doc": 0, "rel_id": 201});
  await db.insert("printer", {"id": 3, "num_of_doc": 0, "rel_id": 200});

  await db.insert("document",
      {"id": 1, "name": "my story", "url": "dddd", "pages": 5, "copies": 10});
  await db.insert("document",
      {"id": 2, "name": "his story", "url": "dddd", "pages": 5, "copies": 10});
  await db.insert("document",
      {"id": 3, "name": "her story", "url": "dddd", "pages": 5, "copies": 10});
  await db.insert("document",
      {"id": 4, "name": "them story", "url": "dddd", "pages": 5, "copies": 10});
  await db.insert("document",
      {"id": 5, "name": "do story", "url": "dddd", "pages": 5, "copies": 10});
  await db.insert("document",
      {"id": 6, "name": "her story", "url": "dddd", "pages": 5, "copies": 10});
  await db.insert("document",
      {"id": 7, "name": "them story", "url": "dddd", "pages": 5, "copies": 10});
  await db.insert("document",
      {"id": 8, "name": "do story", "url": "dddd", "pages": 5, "copies": 10});

  await db.rawInsert(
      'INSERT INTO document_status(user_id,doc_id,status,printer_id,admin_id) VALUES( 100, 6,"done", 1,1)');
  await db.rawInsert(
      'INSERT INTO document_status(user_id,doc_id,status,printer_id,admin_id) VALUES( 100, 7,"done",2,2)');

  await db.rawInsert(
      'INSERT INTO document_status(user_id,doc_id,status) VALUES( 100, 1,"new")');
  await db.rawInsert(
      'INSERT INTO document_status(user_id,doc_id,status) VALUES( 101, 2,"new")');
  await db.rawInsert(
      'INSERT INTO document_status(user_id,doc_id,status) VALUES( 103, 3,"new")');

  await db.rawInsert(
      'INSERT INTO document_status(user_id,doc_id,status,admin_id,printer_id) VALUES( 100, 4,"accepted", 1,2)');
  await db.rawInsert(
      'INSERT INTO document_status(user_id,doc_id,status,admin_id,printer_id) VALUES( 100, 5,"accepted",2,2)');
}
