import 'Hashing.dart';
import 'Interfaces/ILogin.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GlobalController implements ILogin {
  var hash = Hashing();
  // List? login;
  List loginDetails = [
    {"name": "randel"}
  ];
  // void login(final String word) {
  //   // hash.encrypt(word);
  //   // print(hash.getEncrypt());

  //   // hash.decrypt('DKbRBOdWkBE=');
  //   // print(hash.getDecrypt());
  // }

  void logout() {}
  static void addAdmin() {}

  @override
  Future<String> getData(String username, String password) async {
    final String url = "http://localhost:8090/api/login";
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
    );

    loginDetails = json.decode(response.body);
    print(loginDetails);
    print(loginDetails[1]["username"]);
    print(loginDetails[2]["password"]);

    if (loginDetails[1]["username"].toString() == username &&
        hash.decrypt(loginDetails[2]["password"]) == password)
      return "success";
    else
      return "failed";
  }
}
