import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Backend/Interfaces/IBorrower.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'Login_operation.dart';

class BorrowerOperation extends Login implements IBorrower {
  @override
  Future<bool> addBorrower() async {
    throw UnimplementedError();
  }

  @override
  Future<bool> makePayment(int id, double payment, String date) async {
    var paymentLoad = json.encode({
      'BorrowerID': id,
      'CollectionAmount': payment,
      'GivenDate': date,
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/payment"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: paymentLoad,
      );
      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      //SnackNotification.notif('Error', 'Something went wrong', Colors.redAccent.shade200);
      return false;
    }

    //refresh list
    await fetchBorrowers();
    //if status code is 202
    return true;
  }

  @override
  bool removeBorrower() {
    throw UnimplementedError();
  }

  @override
  bool updateBorrower() {
    throw UnimplementedError();
  }
}
