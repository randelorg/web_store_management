import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Backend/Interfaces/IBranch.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'Utility/ApiUrl.dart';

class BranchOperation implements IBranch {
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
  Future<bool> updateBranch() {
    // TODO: implement updateBranch
    throw UnimplementedError();
  }
}
