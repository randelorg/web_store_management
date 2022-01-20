import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'Interfaces/IAdmin.dart';
import 'Utility/ApiUrl.dart';
import 'Utility/Mapping.dart';
import '../Helpers/Hashing_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminOperation implements IAdmin {
  final hash = Hashing();

  @override
  Future<void> createAdminAccount(
      String? firstname,
      String? lastname,
      String? mobileNumber,
      String? homeAddress,
      String? username,
      String? password,
      Uint8List? image) async {
    //json body
    var id = 'admin-015';
    var addAdmin = json.encode({
      'AdminID': id,
      'Username': username,
      'Password': password,
      'Firstname': firstname,
      'Lastname': lastname,
      'MobileNumber': mobileNumber,
      'HomeAddress': homeAddress,
      'UserImage': image
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/admin"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: addAdmin,
      );

      if (response.statusCode == 404)
        SnackNotification.notif(
          'Error',
          'Unexpected error occured',
          Colors.red,
        );
    } catch (e) {
      e.toString();
      //return false;
      SnackNotification.notif(
        'Error',
        'Unexpected error occured',
        Colors.red,
      );
    }

    //if status code is 202
    SnackNotification.notif(
      'Success',
      'Successfully added $firstname',
      Colors.green,
    );
    //return true;
  }

  @override
  void deleteAdminAccount() {}

  @override
  void updateAdminAccount() {}

  @override
  bool verifyAdmin(String password) {
    print(Mapping.adminLogin[0].getPassword.toString());
    if (Mapping.adminLogin[0].getPassword.toString() == hash.encrypt(password))
      return true;

    return false;
  }
}
