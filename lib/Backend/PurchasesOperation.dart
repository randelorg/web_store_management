import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/utility/Mapping.dart';
import 'package:web_store_management/Environment/Environment.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';

class PurchasesOperation {
  Future<bool> sendToIncomingProducts(
      String orderSlipId, String supplierName) async {
    final status = "NOT RECEIVED";
    var response;
    for (var item in Mapping.purchases) {
      try {
        var payload = json.encode({
          "purchaseOrdeSlip": orderSlipId,
          "supplierName": supplierName,
          "productCode": item.productCode,
          "qty": item.qty,
          "purchasedDate": item.datePurchase,
          "status": status,
        });
        await Environment.methodPost(
                "http://localhost:8090/api/addpurchase", payload)
            .then((value) {
          response = value;
        });
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

  Future<List<IncomingPurchasesModel>> addToPurchaseTable(
      String barcode, int qty, String datePurchase) async {
    Mapping.productList
        .where((element) =>
            element.getProductCode?.toLowerCase() == barcode.toLowerCase())
        .forEach((element) {
      Mapping.purchases.add(IncomingPurchasesModel.purchase(
        element.getProductCode,
        element.getProductName,
        qty,
        element.getProdType,
        datePurchase,
      ));
    });
    return Mapping.purchases;
  }

  Future<String> getProductInfo(String barcode) async {
    String productName = "";
    Mapping.productList
        .where((element) =>
            element.getProductCode?.toLowerCase() == barcode.toLowerCase())
        .forEach((element) {
      productName = element.getProductName;
    });
    return productName;
  }
}
