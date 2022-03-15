import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'Interfaces/IAdmin.dart';
import 'Utility/ApiUrl.dart';
import 'Utility/Mapping.dart';
import '../Helpers/HashingHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminOperation implements IAdmin {
  final hash = Hashing();

  Future<bool> changePassword(final String id, final String password) async {
    var payload = json.encode({
      "id": id,
      "password": hash.encrypt(password),
    });

    try {
      final response = await http.post(
        Uri.parse("${Url.url}api/checkpoinchangepass"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: payload,
      );

      if (response.statusCode == 404) {
        SnackNotification.notif(
          'Error',
          'Unexpected error occured',
          Colors.red.shade600,
        );
      }
    } catch (e) {
      e.toString();
      //return false;
      SnackNotification.notif(
        'Error',
        'Unexpected error occured',
      Colors.red.shade600,
      );
    }
    return true;
  }

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
    var addAdmin = json.encode({
      'Username': username,
      'Password': hash.encrypt(password.toString()),
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
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: addAdmin,
      );

      if (response.statusCode == 404) {
        SnackNotification.notif(
          'Error',
          'Unexpected error occured',
          Colors.red.shade600,
        );
      }
    } catch (e) {
      e.toString();
      //return false;
      SnackNotification.notif(
        'Error',
        'Unexpected error occured',
        Colors.red.shade600,
      );
    }

    //if status code is 202
    SnackNotification.notif(
      'Success',
      'Successfully added $firstname' + ' $lastname',
      Colors.green.shade600,
    );
    //return true;
  }

  @override
  void deleteAdminAccount() {}

  @override
  bool verifyAdmin(String password) {
    print(Mapping.adminLogin[0].getPassword.toString());
    if (Mapping.adminLogin[0].getPassword.toString() == hash.encrypt(password))
      return true;

    return false;
  }

  @override
  Future<bool> updateAdminAccount(
      final String id, String username, final String password) async {
    var adminUpdateLoad = json.encode({
      'id': id,
      'Username': username.trim(),
      'Password': hash.encrypt(password),
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/updateadmin"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: adminUpdateLoad,
      );

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      SnackNotification.notif(
        'Error',
        'Something went wrong while updating the admin',
        Colors.red.shade600,
      );
      return false;
    }

    //if status code is 202
    return true;
  }
}
