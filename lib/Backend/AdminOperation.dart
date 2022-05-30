import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/interfaces/IAdmin.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/environment/Environment.dart';
import 'Utility/Mapping.dart';
import '../Helpers/HashingHelper.dart';
import 'dart:convert';

class AdminOperation implements IAdmin {
  final hash = Hashing();

  Future<bool> changePassword(final String id, final String password) async {
    var response;
    var payload = json.encode({
      "id": id,
      "password": hash.encrypt(password),
    });

    try {
      await Environment.methodPost(
              "http://localhost:8090/api/checkpoinchangepass", payload)
          .then((value) {
        response = value;
      });

      if (response.statusCode == 404) {
        BannerNotif.notif(
          'Error',
          'Unexpected error occured',
          Colors.red.shade600,
        );
      }
    } catch (e) {
      e.toString();
      //return false;
      BannerNotif.notif(
        'Error',
        'Unexpected error occured',
        Colors.red.shade600,
      );
    }
    return true;
  }

  @override
  Future<void> createAdminAccount(
      String firstname,
      String lastname,
      String mobileNumber,
      String homeAddress,
      String username,
      String password,
      Uint8List? image) async {
    //json body
    print("creation ${hash.encrypt(password.trim().toString())}");
    var addAdmin = json.encode({
      'Username': username,
      'Password': hash.encrypt(password.trim()),
      'Firstname': firstname,
      'Lastname': lastname,
      'MobileNumber': mobileNumber,
      'HomeAddress': homeAddress,
      'UserImage': image
    });
    var response;

    try {
      await Environment.methodPost("http://localhost:8090/api/admin", addAdmin)
          .then((value) {
        response = value;
      });

      if (response.statusCode == 404) {
        BannerNotif.notif(
          'Error',
          'Unexpected error occured',
          Colors.red.shade600,
        );
      }
    } catch (e) {
      e.toString();
      //return false;
      BannerNotif.notif(
        'Error',
        'Unexpected error occured',
        Colors.red.shade600,
      );
    }

    //if status code is 202
    BannerNotif.notif(
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
    var response;
    var adminUpdateLoad = json.encode({
      'id': id,
      'Username': username.trim(),
      'Password': hash.encrypt(password),
    });

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/updateadmin", adminUpdateLoad)
          .then((value) {
        response = value;
      });

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      BannerNotif.notif(
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
