import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/interfaces/IHistory.dart';
import 'package:web_store_management/Models/LoanedProductHistoryModel.dart';
import 'package:web_store_management/Models/PaymentHistoryModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/environment/Environment.dart';
import '../Backend/Utility/Mapping.dart';

class HistoryOperation implements IHistory {
  @override
  Future<List<LoanedProductHistory>> viewLoanHistory(String borrowerId) async {
    if (borrowerId == "") return [];
    var response;
    try {
      await Environment.methodGet(
              "http://localhost:8090/api/loanedproducts/$borrowerId")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      Mapping.productHistoryList = parsed
          .map<LoanedProductHistory>(
              (json) => LoanedProductHistory.fromJson(json))
          .toList();

      if (response.statusCode == 404) {
        BannerNotif.notif(
          'Error',
          'Cant fetch loaned product history',
          Colors.red.shade600,
        );
        return [];
      }
    } catch (e) {
      print(e.toString());
      BannerNotif.notif(
        'Error',
        'Cant fetch loaned product history',
        Colors.red.shade600,
      );
      return [];
    }
    return Mapping.productHistoryList;
  }

  @override
  Future<List<PaymentHistoryModel>> viewPaymentHistory(
      String borrowerId) async {
    if (borrowerId == "") return [];
    var response;
    try {
      await Environment.methodGet(
              "${Environment.apiUrl}/api/payment/$borrowerId")
          .then((value) {
        response = value;
      });

      final parsed =
          await jsonDecode(response.body).cast<Map<String, dynamic>>();
      Mapping.paymentList = parsed
          .map<PaymentHistoryModel>(
              (json) => PaymentHistoryModel.fromJson(json))
          .toList();

      if (response.statusCode == 404) {
        BannerNotif.notif(
          'Error',
          'There is history of this borrower',
          Colors.red.shade600,
        );
        return [];
      }
    } catch (e) {
      print(e.toString());
      BannerNotif.notif(
        'Error',
        'Cant fetch payment history',
        Colors.red.shade600,
      );
      return [];
    }
    return Mapping.paymentList;
  }
}
