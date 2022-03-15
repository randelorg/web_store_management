import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Backend/Interfaces/IBranch.dart';
import 'package:web_store_management/Backend/Interfaces/IInventory.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'Utility/ApiUrl.dart';

class BranchOperation implements IBranch, IIventory {
  @override
  Future<bool> addBranch(final String branchName, final String branchAddress,
      final String empId) async {
    var branchLoad = json.encode({
      'branchName': branchName,
      'branchAddress': branchAddress.trim(),
      'empAssigned': empId,
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/addbranch"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: branchLoad,
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        SnackNotification.notif(
          'Success',
          'New branch added successfully',
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
  Future<bool> deleteBranch() {
    // TODO: implement deleteBranch
    throw UnimplementedError();
  }

  @override
  Future<bool> updateBranch(
      String branchCode, String branchName, String branchAddress) async {
    var updateBranch = json.encode(
      {
        "branchCode": branchCode,
        "branchName": branchName,
        "branchAddress": branchAddress,
      },
    );

    try {
      final response = await http.post(
        Uri.parse("${Url.url}api/updateBranch"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: updateBranch,
      );

      if (response.statusCode == 202) {
        return true;
      }
    } catch (e) {
      e.toString();
      //if there is an error in the method
      SnackNotification.notif(
        'Error',
        "Branch failed to  update",
        Colors.red.shade600,
      );
    }

    return true;
  }

  //inventory
  @override
  Future<bool> transferStock(
      String productCode, int qty, String branchCode) async {
    //concatonate product code and branch code as the product code copy for this branch
    final String code = branchCode.trim() + '-' + productCode.trim();

    var stockLoad = json.encode({
      'prodCode': code,
      'qty': qty,
      'branchCode': branchCode,
    });

    try {
      final response = await http.post(
        Uri.parse("${Url.url}api/transfer"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: stockLoad,
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        return true;
      }
    } catch (e) {
      e.toString();
      //if there is an error in the method
      SnackNotification.notif(
        'Error',
        "Product failed to be transferred",
        Colors.red.shade600,
      );
      return false;
    }

    return true;
  }
}
