import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Helpers/Hashing_helper.dart';
import 'GlobalController.dart';
import 'Interfaces/ILogin.dart';
import '../Models/Admin_model.dart';
import 'Utility/Mapping.dart';
import 'Session.dart';

class Login implements ILogin {
  var hash = Hashing();
  var admin = Admin.empty();
  var session = Session();
  var controller = GlobalController();

  @override
  Future<bool> mainLogin(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8090/api/login'),
      body: {
        "Username": username,
        "Password": hash.encrypt(password),
      },
    );
    print('code ' + response.statusCode.toString());
    if (response.statusCode == 404) {
      return false;
    }

    await controller
        .parseAdmin(response.body)
        .then((value) => Mapping.adminList = value);
    print(Mapping.adminList.length);

    return true;
  }

  void setSession(String id) {
    session.setValues(id, true);
  }

  @override
  void logout() {
    session.removeValues(); //remove the values from the session
  }

  void loadAllList() {
    controller.fetchProducts();
    controller.fetchBorrowers();
  }
}
