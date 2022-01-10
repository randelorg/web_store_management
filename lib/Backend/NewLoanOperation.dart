import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/Interfaces/INewLoan.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:web_store_management/Notification/Snack_notification.dart';

class NewLoanOperation extends BorrowerOperation implements INewLoan {
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
}
