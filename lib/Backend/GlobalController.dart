import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Helpers/Hashing.dart';
import 'Interfaces/ILogin.dart';
import '../Models/Admin.dart';
import '../Utility/Mapping.dart';
import 'Session.dart';

class GlobalController implements ILogin {
  var hash = Hashing();
  var admin = Admin.empty();
  var session = Session();

  static void addAdmin() {}

  //for login
  Future<List<Admin>> fetchAdmin() async {
    final response =
        await http.get(Uri.parse('http://localhost:8090/api/loginAdmin'));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseAdmin, response.body);
  }

// A function that converts a response body into a List<Admin>.
  List<Admin> parseAdmin(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print(parsed);
    Mapping.adminList =
        parsed.map<Admin>((json) => Admin.fromJsonAdmin(json)).toList();
    return Mapping.adminList;
  }

  @override
  String login(final String username, final String password) {
    for (var admin in Mapping.adminList) {
      if (username == admin.getUsername &&
          password == hash.decrypt(admin.getPassword)) {
        //set the session
        //after successful login
        session.setValues(admin.getAdminId, true);
        return "success";
      }
    }

    return "failed";
  }

  //for logout
  @override
  void logout() {
    session.removeValues(); //remove the values from the session
  }
}
