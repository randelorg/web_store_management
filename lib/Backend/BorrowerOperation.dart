import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Backend/Interfaces/IBorrower.dart';
import 'package:web_store_management/Backend/Interfaces/IPay.dart';
import 'package:web_store_management/Backend/Interfaces/IServices.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'LoginOperation.dart';
import 'Utility/ApiUrl.dart';

class BorrowerOperation extends Login implements IBorrower, IPay, IServices {
  @override
  Future<bool> updateBorrower(int id, String firstname, String lastname,
      String mobile, String address) async {
    var borrowerUpdateLoad = json.encode({
      'id': id,
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
      'mobile': mobile.trim(),
      'address': address.trim()
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/updatebrw"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: borrowerUpdateLoad,
      );

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      SnackNotification.notif(
        'Error',
        'Something went wrong while updating the borrower',
        Colors.red.shade600,
      );
      return false;
    }

    //if status code is 202
    return true;
  }

  @override
  Future<bool> makePayment(int id, double payment, String date) async {
    var paymentLoad = json.encode(
        {'BorrowerID': id, 'CollectionAmount': payment, 'GivenDate': date});

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/payment"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: paymentLoad,
      );

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      SnackNotification.notif(
        'Error',
        'Something went wrong while fetching borrowers',
        Colors.red.shade600,
      );
      return false;
    }

    //if status code is 202
    return true;
  }

  @override
  Future<bool> addRequest(int borrowerid, String product, String date) async {
    final String status = 'PENDING';
    var requestLoad = json.encode({
      'id': borrowerid,
      'status': status,
      'productname': product.trim(),
      'reqDate': date.trim(),
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/addrequest"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: requestLoad,
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        SnackNotification.notif(
          'Success',
          'New request added successfully',
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
  Future<bool> addRepair(int borrowerid, String product, String date) async {
    final String status = 'PENDING';
    var repairLoad = json.encode({
      'id': borrowerid,
      'status': status,
      'productname': product.trim(),
      'turnover': date.trim(),
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/addrepair"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: repairLoad,
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        SnackNotification.notif(
          'Success',
          'New repair added successfully',
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
  bool removeBorrower() {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateRepair(int id, final String status) async {
    var updateRepairLoad = json.encode({
      'id': id,
      'status': status,
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/updaterepair"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: updateRepairLoad,
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        SnackNotification.notif(
          'Success',
          'Product Repair is updated',
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
  Future<bool> updateRequest(int id, final String status) async {
    var updateRequestLoad = json.encode({
      'id': id,
      'status': status,
    });

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/updaterequest"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: updateRequestLoad,
      );

      //if response is empty return false
      if (response.statusCode == 404) {
        return false;
      }

      if (response.statusCode == 202) {
        SnackNotification.notif(
          'Success',
          'Product Request is updated',
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

  Future<List<int>> getContract(int id) async {
    List<BorrowerModel> contractImage = [];
    List<int> picture = [];

    try {
      final response = await http.get(
        Uri.parse(
          "http://localhost:8090/api/contract/" + id.toString(),
        ),
      );

      Map<String, dynamic> brwMap =
          jsonDecode(response.body)[0] as Map<String, dynamic>;

      var contract = BorrowerModel.fromJsonContract(brwMap);

      contractImage.add(BorrowerModel.contractOnly(contract.getContractImage));

      picture = contractImage[0].getContractImage.cast<int>();

      if (response.statusCode == 404) {
        SnackNotification.notif(
          'Error',
          'Cant fetch contract',
          Colors.red.shade600,
        );
      }
    } catch (e) {
      print(e.toString());
      SnackNotification.notif(
        'Error',
        'Cant fetch contract',
        Colors.red.shade600,
      );
    }
    return picture;
  }
}
