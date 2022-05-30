import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/Interfaces/IBorrower.dart';
import 'package:web_store_management/Backend/Interfaces/IPay.dart';
import 'package:web_store_management/Backend/Interfaces/IServices.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/environment/Environment.dart';
import 'LoginOperation.dart';

class BorrowerOperation extends Login implements IBorrower, IPay, IServices {
  @override
  Future<bool> updateBorrower(int id, String firstname, String lastname,
      String mobile, String address) async {
    var response;
    var borrowerUpdateLoad = json.encode({
      'id': id,
      'firstname': firstname.trim(),
      'lastname': lastname.trim(),
      'mobile': mobile.trim(),
      'address': address.trim()
    });

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/updatebrw", borrowerUpdateLoad)
          .then((value) {
        response = value;
      });

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      BannerNotif.notif(
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
    var response;
    var paymentLoad = json.encode(
        {'BorrowerID': id, 'CollectionAmount': payment, 'GivenDate': date});

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/payment", paymentLoad)
          .then((value) {
        response = value;
      });

      if (response.statusCode == 404) return false;
    } catch (e) {
      e.toString();
      BannerNotif.notif(
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
    var response;
    var requestLoad = json.encode({
      'id': borrowerid,
      'status': status,
      'productname': product.trim(),
      'reqDate': date.trim(),
    });

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/addrequest", requestLoad)
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
          'New request added successfully',
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
  Future<bool> addRepair(int borrowerid, String product, String date) async {
    final String status = 'PENDING';
    var response;
    var repairLoad = json.encode({
      'id': borrowerid,
      'status': status,
      'productname': product.trim(),
      'turnover': date.trim(),
    });

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/addrepair", repairLoad)
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
          'New repair added successfully',
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
  bool removeBorrower() {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateRepair(int id, final String status) async {
    var response;
    var updateRepairLoad = json.encode({
      'id': id,
      'status': status,
    });

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/updaterepair", updateRepairLoad)
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
          'Product Repair is updated',
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
  Future<bool> updateRequest(int id, final String status) async {
    var response;
    var updateRequestLoad = json.encode({
      'id': id,
      'status': status,
    });

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/updaterequest", updateRequestLoad)
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
          'Product Request is updated',
          Colors.green.shade600,
        );
        return true;
      }
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<List<int>> getContract(int id) async {
    List<BorrowerModel> contractImage = [];
    List<int> picture = [];
    var response;

    try {
      await Environment.methodGet(
              "${Environment.apiUrl}/api/contract/${id.toString()}")
          .then((value) {
        response = value;
      });

      Map<String, dynamic> brwMap =
          jsonDecode(response.body)[0] as Map<String, dynamic>;

      var contract = BorrowerModel.fromJsonContract(brwMap);

      contractImage.add(BorrowerModel.contractOnly(contract.getContractImage));

      picture = contractImage[0].getContractImage.cast<int>();

      if (response.statusCode == 404) {
        BannerNotif.notif(
          'Error',
          'Cant fetch contract',
          Colors.red.shade600,
        );
      }
    } catch (e) {
      BannerNotif.notif(
        'Error',
        'Cant fetch contract',
        Colors.red.shade600,
      );
    }
    return picture;
  }
}
