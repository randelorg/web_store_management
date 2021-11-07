import 'Hashing.dart';
import 'Interfaces/ILogin.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Admin.dart';

class GlobalController implements ILogin {
  var hash = Hashing();
  var admin = Admin.empty();

  void logout() {}
  static void addAdmin() {}

  @override
  String login(final String username, final String password) {
    getLoginData(); //used to get the

    if (admin.getUsername == username &&
        hash.decrypt(admin.getPassword) == password)
      return "success";
    else
      return "failed";
  }

  Future<void> getLoginData() async {
    final String url = "http://localhost:8090/api/loginAdmin";
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
    );

    for (var i in jsonDecode(response.body)) {
      admin.setAdminId = i["AdminID"];
      admin.setUsername = i["username"];
      admin.setPassword = i['password'];
    }
  }
}
