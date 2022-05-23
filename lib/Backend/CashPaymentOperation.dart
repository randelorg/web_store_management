import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/environment/Environment.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class CashPaymentOperation {
  Future<String> getInvoiceNumber() async {
    var response;
    Map<String, dynamic> invoiceNumber;
    try {
      await Environment.methodGet("http://localhost:8090/api/genInvoice")
          .then((value) {
        response = value;
      });
      //add investigation
      if (response.statusCode == 404) {
        return "Error";
      }

      invoiceNumber = jsonDecode(response.body);

      if (response.statusCode == 202) {
        return invoiceNumber["invoiceNumber"];
      }

      return "Empty";
    } catch (e) {
      e.toString();
      BannerNotif.notif(
        'Error',
        'Something went wrong while genrating invoice number',
        Colors.redAccent.shade200,
      );
      return "Error";
    }
  }

  Future<bool> sendSales(
      String invoiceNumber, String date, double amount) async {
    var response;
    var sale = json.encode({
      'invoiceNumber': invoiceNumber,
      'date': date,
      'totalAmount': amount,
    });

    try {
      await Environment.methodPost("http://localhost:8090/api/addsales", sale)
          .then((value) {
        response = value;
      });

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        BannerNotif.notif(
          'Success',
          'Sale added successfully',
          Colors.green.shade600,
        );
        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }
}
