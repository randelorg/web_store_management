import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/DashboardOperation.dart';
import 'package:web_store_management/Backend/Utility/ApiUrl.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'Interfaces/IEmployee.dart';
import '../Helpers/HashingHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeOperation implements IEmployee {
  final _hash = Hashing();
  var dashboard = DashboardOperation();

  @override
  Future<bool> createEmployeeAccount(
      String? role,
      String? firstname,
      String? lastname,
      String? mobileNumber,
      String? homeAddress,
      double? basicWage,
      String? username,
      String? password,
      Uint8List? image) async {
    var addEmployee = json.encode(
      {
        'Role': role,
        'Username': username,
        'Password': _hash.encrypt(password.toString()),
        'Firstname': firstname,
        'Lastname': lastname,
        'MobileNumber': mobileNumber,
        'HomeAddress': homeAddress,
        'Wage': basicWage,
        'UserImage': image
      },
    );

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/employee"),
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
  Future<bool> updateEmployeeAccount(
      int pid, String eid, String role, String mobile, String address) async {
    var adminUpdateLoad = json.encode({
      'pid': pid,
      'eid': eid,
      'Role': role.trim(),
      'mobile': mobile,
      'address': address,
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/updateemp"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: adminUpdateLoad,
      );

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      SnackNotification.notif(
        'Error',
        'Something went wrong while updating the employee',
        Colors.red.shade600,
      );
      return false;
    }

    //if status code is 202
    return true;
  }

  //for DTR
  @override
  Future<bool> timeIn(String id, final String date) async {
    var updateRequestLoad = json.encode({
      'id': id,
      'timeIn': date,
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/clockin"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: updateRequestLoad,
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }

  @override
  Future<bool> timeOut(String id, final String date) async {
    var adminUpdateLoad = json.encode({
      'id': id,
      'dateToday': dashboard.getTodayDate().toString(),
      'timeOut': date,
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/clockout"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: adminUpdateLoad,
      );
      
      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }
}
