import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/Backend/interfaces/IProduct.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:web_store_management/environment/Environment.dart';

class ProductOperation implements IProduct {
  @override
  Future<bool> updateProductDetails(
      String barcode, String name, int qty, String unit, double price) async {
    var product = json.encode(
      {
        "barcode": barcode,
        "name": name,
        "quantity": qty,
        "unit": unit,
        "price": price,
      },
    );
    var response;

    try {
      await Environment.methodPost("${Environment.apiUrl}/api/product", product)
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
        "Product " + name + " failed to  update",
        Colors.red.shade600,
      );
    }

    return true;
  }

  @override
  Future<bool> addProduct(String barcode, String productName, double price,
      String unit, String prodType, String prodLabel) async {
    var response, newBarcode;
    newBarcode = json.encode(
      {
        "barcode": barcode,
        "name": productName,
        "price": price,
        "unit": unit,
        "prodType": prodType,
        "prodLabel": prodLabel,
      },
    );

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/addbarcode", newBarcode)
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
        "Product " + productName + " failed to  add",
        Colors.red.shade600,
      );
    }

    return true;
  }

  @override
  Future<bool> addSupplier(String supplierName, String supplierContact,
      String supplierWebsite) async {
    var response, newSupplier;
    newSupplier = json.encode(
      {
        "name": supplierName,
        "contact": supplierContact,
        "suppWebsite": supplierWebsite
      },
    );

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/addsupplier", newSupplier)
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
        "Failed to add $supplierName",
        Colors.red.shade600,
      );
    }

    return true;
  }

  @override
  void deleteProduct() {
    // TODO: implement deleteProduct
  }

  @override
  void transferProduct() {
    // TODO: implement transferProduct
  }
}
