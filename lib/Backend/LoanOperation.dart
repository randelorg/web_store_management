import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/BorrowerOperation.dart';
import 'package:web_store_management/Backend/Interfaces/ILoan.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_store_management/Notification/BannerNotif.dart';
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
    var brwDetail = json.encode({
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
      'mobile': mobile.trim(),
      'address': homeaddress.trim(),
      'balance': balance,
      'contract': contract
    });

    try {
      final response = await http.post(
        Uri.parse("${Url.url}api/addborrower"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: brwDetail,
      );

      //add investigation
      await addInvestigation(firstname, lastname);

      //add the loan
      await addNewLoan(firstname, lastname, plan, term, duedate);

      if (response.statusCode == 404) {
        return false;
      }
    } catch (e) {
      e.toString();
      BannerNotif.notif(
        'Error',
        'Something went wrong while adding the borrower',
        Colors.redAccent.shade200,
      );
      return false;
    }

    //if status code is 202
    return true;
  }

  Future<bool> addInvestigation(String firstname, String lastname) async {
    var brwDetail2 = json.encode({
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
    });

    try {
      final response = await http.post(
        Uri.parse("${Url.url}api/addinvestigation"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: brwDetail2,
      );

      if (response.statusCode == 404) {
        return false;
      }
    } catch (e) {
      e.toString();
      BannerNotif.notif(
        'Error',
        'Something went wrong while adding the borrower',
        Colors.red.shade600,
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
          Uri.parse("${Url.url}api/addloan"),
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

      } catch (e) {
        e.toString();
        BannerNotif.notif(
          'Error',
          'Something went wrong while adding the loan',
          Colors.red.shade600,
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
          "${Url.url}api/approved/${investigationId.toString()}/${borrowerId.toString()}/$status",
        ),
      );

      //initate deduction of stock here
      if (status == 'RELEASED') {
        await http.get(
          Uri.parse(
            "${Url.url}api/loans/${borrowerId.toString()}",
          ),
        );
      }

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        BannerNotif.notif(
          'Success',
          'Loan is now $status - Go now to Borrowers',
          Colors.green.shade600,
        );
        return true;
      }
    } catch (e) {
      return false;
    }

    return true;
  }

  @override
  Future<bool> updateBalanceAndContract(num balance, int id, String firstname,
      String lastname, plan, term, dueDate, Uint8List? contract) async {
    try {
      final response = await http.post(
        Uri.parse("${Url.url}api/updatebal"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          "id": id,
          "balance": balance,
          "contract": contract,
        }),
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      } else {
        await addInvestigation(firstname, lastname);

        //add to new loan {renewal}
        await addNewLoan(firstname, lastname, plan, term, dueDate);
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
