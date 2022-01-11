import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/Interfaces/ILoan.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_store_management/Notification/Snack_notification.dart';

class LoanOperation extends BorrowerOperation implements INewLoan {
  @override
  Future<bool> addBorrower(String firstname, String lastname, String mobile,
      String homeaddress, num balance) async {
    String id = '8';
    var borrower = json.encode({
      'id': id,
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
      'mobile': mobile.trim(),
      'address': homeaddress.trim(),
      'balance': balance,
    });

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/addborrower"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: borrower,
      );

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      SnackNotification.notif(
        'Error',
        'Something went wrong while adding the borrower',
        Colors.redAccent.shade200,
      );
      return false;
    }

    //if status code is 202
    return true;
  }

  @override
  Future<bool> addNewLoan(String firstname, String lastname, String plan,
      String term, String duedate) async {
    for (var item in Mapping.selectedProducts) {
      try {
        await http.post(
          Uri.parse("http://localhost:8090/api/addloan"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: json.encode({
            'firstname': firstname,
            'lastname': lastname,
            'productCode': item.getProductCode,
            'plan': plan,
            'duedate': duedate,
            'term': term,
            'qty': item.getProductQty,
            'status': 'UNPAID',
          }),
        );
      } catch (e) {
        e.toString();
        SnackNotification.notif(
          'Error',
          'Something went wrong while adding the loan',
          Colors.redAccent.shade200,
        );
        return false;
      }
    }

    return true;
  }

  @override
  Future<bool> approvedCredit(
      int investigationId, int borrowerId, String status) async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://localhost:8090/api/approved/' +
              investigationId.toString() +
              '/' +
              borrowerId.toString() +
              '/' +
              status,
        ),
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        SnackNotification.notif(
          'Success',
          'Loan is now approved - Go now to borrowers',
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
}
