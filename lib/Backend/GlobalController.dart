import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Hashing.dart';
import 'Interfaces/ILogin.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Admin.dart';
import '../Utility/Mapping.dart';

class GlobalController implements ILogin {
  var hash = Hashing();
  var admin = Admin.empty();

  void logout() {}
  static void addAdmin() {}

  @override
  String login(final String username, final String password) {
    for (var admin in Mapping.adminList) {
      if (username == admin.getUsername &&
          password == hash.decrypt(admin.getPassword)) {
        return "success";
      }
    }

    return "failed";
  }

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
}
