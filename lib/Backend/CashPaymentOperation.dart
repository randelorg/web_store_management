import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/environment/Environment.dart';
import 'package:web_store_management/notification/BannerNotif.dart';

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
}
