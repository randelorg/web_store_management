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
  bool removeBorrower() {
    throw UnimplementedError();
  }

  @override
  Future<bool> getBorrowerName(String requested_product, String id) async {
    var requested = json.encode({
      'requested': requested_product,
      'borrowerId': id,
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/borrower"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: requested,
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
    //if status code is 202
    return true;
  }
}
