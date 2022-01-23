import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Backend/Interfaces/IBorrower.dart';
import 'package:web_store_management/Backend/Interfaces/IPay.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'LoginOperation.dart';
import 'Utility/ApiUrl.dart';

class BorrowerOperation extends Login implements IBorrower, IPay {
  @override
  Future<bool> updateBorrower(int id, String firstname, String lastname,
      String mobile, String address) async {
    var borrowerUpdateLoad = json.encode({
      'id': id,
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
      'mobile': mobile.trim(),
      'address': address.trim()
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/updatebrw"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: borrowerUpdateLoad,
      );

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      SnackNotification.notif(
        'Error',
        'Something went wrong while updating the borrower',
        Colors.redAccent.shade200,
      );
      return false;
    }

    //if status code is 202
    return true;
  }

  @override
  Future<bool> makePayment(int id, double payment, String date) async {
    var paymentLoad = json.encode(
        {'BorrowerID': id, 'CollectionAmount': payment, 'GivenDate': date});

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/payment"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: paymentLoad,
      );

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      SnackNotification.notif(
        'Error',
        'Something went wrong while fetching borrowers',
        Colors.redAccent.shade200,
      );
      return false;
    }

    //if status code is 202
    return true;
  }

  @override
  Future<bool> addRepair(int borrowerid, String product, String date) async {
    final String status = 'PENDING';
    var repairLoad = json.encode({
      'id': borrowerid,
      'status': status,
      'productname': product.trim(),
      'turnover': date.trim(),
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/addrepair"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: repairLoad,
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        SnackNotification.notif(
          'Success',
          'New repair added successfully',
          Colors.green.shade900,
        );
        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }

  @override
  bool removeBorrower() {
    throw UnimplementedError();
  }
}
