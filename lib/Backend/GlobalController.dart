import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Helpers/Hashing_helper.dart';
import 'Interfaces/ILogin.dart';
import 'Interfaces/IAdmin.dart';
import '../Models/Admin_model.dart';
import 'Utility/Mapping.dart';
import 'Session.dart';

class GlobalController implements ILogin, IAdmin {
  var hash = Hashing();
  var admin = Admin.empty();
  var session = Session();

  //****for admin login
  Future<List<Admin>> fetchAdmin() async {
    final response =
        await http.get(Uri.parse('http://localhost:8090/api/loginAdmin'));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseAdmin, response.body);
  }

  //****for admin login
  Future<List<Admin>> fetchAdminInfo() async {
    final response =
        await http.get(Uri.parse('http://localhost:8090/api/loginAdmin'));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseAdmin, response.body);
  }

  // A function that converts a response body into a List<Admin>.
  List<Admin> parseAdminInfo(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.adminList =
        parsed.map<Admin>((json) => Admin.fromJsonAdmin(json)).toList();
    return Mapping.adminList;
  }

  // A function that converts a response body into a List<Admin>.
  List<Admin> parseAdmin(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.adminList =
        parsed.map<Admin>((json) => Admin.fromJsonAdmin(json)).toList();
    return Mapping.adminList;
  }

  //for both employee and admin login
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

  @override
  bool verifyUser(String pass) {
    return false;
  }

  @override
  void createAdminAccount() {
    // TODO: implement createAdminAccount
  }

  @override
  void deleteAdminAccount() {
    // TODO: implement deleteAdminAccount
  }

  @override
  void updateAdminAccount() {
    // TODO: implement updateAdminAccount
  }

  //for logout
  @override
  void logout() {
    session.removeValues(); //remove the values from the session
  }
}
