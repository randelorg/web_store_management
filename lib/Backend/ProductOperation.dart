import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'package:http/http.dart' as http;
import 'Interfaces/IProduct.dart';
import 'Utility/ApiUrl.dart';

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
        "price": price
      },
    );

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/product"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: product,
      );

      if (response.statusCode == 202) {
        return true;
      }
    } catch (e) {
      e.toString();
      //if there is an error in the method
      SnackNotification.notif(
        'Error',
        "Product " + name + " failed to  update",
        Colors.red.shade600,
      );
    }

    return true;
  }

  Future<bool> addProduct(String barcode, String productName, String quantity,
      String unit, double price) async {
    var newProduct = json.encode(
      {
        "barcode": barcode,
        "name": productName,
        "quantity": quantity,
        "unit": unit,
        "price": price
      },
    );

    try {
      final response = await http.post(
        Uri.parse(Url.url + "api/addproduct"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: newProduct,
      );

      if (response.statusCode == 202) {
        return true;
      }
    } catch (e) {
      e.toString();
      //if there is an error in the method
      SnackNotification.notif(
        'Error',
        "Product " + productName + " failed to  add",
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
