// ignore_for_file: file_names

import '../database/database.dart';
import '../person/person.dart';

class LoginType {
  bool logged = false,
      userLogged = false,
      releaseManLogged = false,
      adminLogged = false;

  void setLogged(bool logged) {
    this.logged = logged;
  }

  void setUserLogged(bool userLogged) {
    this.userLogged = userLogged;
  }

  void setReLogged(bool retLogged) {
    releaseManLogged = retLogged;
  }

  void setAdminLogged(bool adminLogged) {
    this.adminLogged = adminLogged;
  }

  bool isLogged() {
    return logged;
  }

  bool isUserLogged() {
    return userLogged;
  }

  bool isReleaseManLogged() {
    return releaseManLogged;
  }

  bool isAdminLogged() {
    return adminLogged;
  }

  Future<Person> login(String username, int passWord, Person p) async {
    print("start login");
    try {
      p = await findInDB(username, passWord, p, "user");
      print("main place " + p.name);
      
      if (isLogged() == false) {
        p = await findInDB(username, passWord, p, "admin");
        print("main place " + p.name);
      }

      if (isLogged() == false) {
        p = await findInDB(username, passWord, p, "release_man");
        print("main place " + p.name);
      }

      if (isLogged() == false) {
        print("Wrong UserName or Password");
      }
    } catch (e) {
      print(e);
    }
    return p;
  }
  Future<Person> findInDB(
      String username, int passWord, Person person, String table) async {
    DataBase db = DataBase();
    print("start login");
    try 
    {
      late List<Map> result;
      result = await db.getPersonDataFromDB(
          table: table, username: username, pass: passWord);
      print("$table out then " + result.toString());
      if (result.isNotEmpty) {
        print("$table out if" + result.toString());
        person = Person.fromDB(result[0]);
        if (username == person.getUser_name() && passWord == person.getPassword()) {
          setLogged(true);
          switch (table) {
            case "user":
              setUserLogged(true);
              break;
            case "admin":
              setAdminLogged(true);
              break;
            case "release_man":
              setReLogged(true);
              break;
          }
          print("Welcome $table: " + person.getName());
        }
      }
    } catch (e) {
      print(e);
    }
    return person;
  }

}
