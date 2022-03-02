import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/Interfaces/ILoan.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_store_management/Notification/Snack_notification.dart';

import 'Utility/ApiUrl.dart';

class LoanOperation extends BorrowerOperation implements INewLoan {
  @override
  Future<bool> addBorrower(
    String firstname,
    String lastname,
    String mobile,
    String homeaddress,
    num balance,
    Uint8List? contract,
    String plan,
    String term,
    String duedate,
  ) async {
    var brwDetail1 = json.encode({
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
      'mobile': mobile.trim(),
      'address': homeaddress.trim(),
      'balance': balance,
      'contract': contract
    });

    var brwDetail2 = json.encode({
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
    });

    try {
      final response1 = await http.post(
        Uri.parse(Url.url + "api/addborrower"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: brwDetail1,
      );

      final response2 = await http.post(
        Uri.parse(Url.url + "api/addinvestigation"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: brwDetail2,
      );

      //add the loan
      addNewLoan(firstname, lastname, plan, term, duedate);

      if (response1.statusCode == 404 || response2.statusCode == 404) {
        return false;
      }
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
        final response = await http.post(
          Uri.parse(Url.url + "api/addloan"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: json.encode({
            "firstname": firstname,
            "lastname": lastname,
            "productCode": item.getProductCode,
            'plan': plan,
            'duedate': duedate,
            'term': term,
            'qty': item.getProductQty,
            'status': 'UNPAID',
          }),
        );

        if (response.statusCode == 202) {
          return true;
        }
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
          Url.url +
              "api/approved/" +
              investigationId.toString() +
              "/" +
              borrowerId.toString() +
              "/" +
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
