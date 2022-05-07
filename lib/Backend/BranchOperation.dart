import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Interfaces/IBranch.dart';
import 'package:web_store_management/Backend/Interfaces/IInventory.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/environment/Environment.dart';

class BranchOperation implements IBranch, IInventory {
  @override
  Future<bool> addBranch(final String branchName, final String branchAddress,
      final String empId) async {
    var response;
    var branchLoad = json.encode({
      'branchName': branchName,
      'branchAddress': branchAddress.trim(),
      'empAssigned': empId,
    });

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/addbranch", branchLoad)
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
          'New branch added successfully',
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

  @override
  Future<bool> deleteBranch() {
    // TODO: implement deleteBranch
    throw UnimplementedError();
  }

  @override
  Future<bool> updateBranch(
      String branchCode, String branchName, String branchAddress) async {
    var response;
    var updateBranch = json.encode(
      {
        "branchCode": branchCode,
        "branchName": branchName,
        "branchAddress": branchAddress,
      },
    );

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/updateBranch", updateBranch)
          .then((value) {
        response = value;
      });

      if (response.statusCode == 202) {
        return true;
      }
    } catch (e) {
      e.toString();
      //if there is an error in the method
      BannerNotif.notif(
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
    var response;
    var stockLoad = json.encode({
      'prodCode': code,
      'qty': qty,
      'branchCode': branchCode,
    });

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/transfer", stockLoad)
          .then((value) {
        response = value;
      });

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
      BannerNotif.notif(
        'Error',
        "Product failed to be transferred",
        Colors.red.shade600,
      );
      return false;
    }

    return true;
  }
}
