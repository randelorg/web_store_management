import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';

import 'Interfaces/IEmployee.dart';
import '../Helpers/Hashing_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeOperation implements IEmployee {
  final hash = Hashing();

  @override
  Future<bool> createEmployeeAccount(
      String? role,
      String? firstname,
      String? lastname,
      String? mobileNumber,
      String? homeAddress,
      String? username,
      String? password,
      Uint8List? image) async {
    var id = 'emp-008';

    var addEmployee = json.encode(
      {
        'EmployeeID': id,
        'Role': role,
        'Username': username,
        'Password': password,
        'Firstname': firstname,
        'Lastname': lastname,
        'MobileNumber': mobileNumber,
        'HomeAddress': homeAddress,
        'UserImage': image
      },
    );

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/employee"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: addEmployee,
      );

      if (response.statusCode == 404) return false;
    } catch (e) {
      SnackNotification.notif(
        'Error',
        'Something went wrong',
        Colors.red.shade600,
      );
      e.toString();
    }

    //if status code is 202
    return true;
  }

  @override
  void deleteEmployeeAccount() {}

  @override
  void updateEmployeeAccount() {}
}
