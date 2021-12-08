import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_store_management/Notification/Snack_notification.dart';
import 'package:http/http.dart' as http;
import 'Interfaces/IProduct.dart';

class Product implements IProduct {
  @override
  void addProduct() {
    // TODO: implement addProduct
  }

  @override
  void deleteProduct() {
    // TODO: implement deleteProduct
  }

  @override
  void transferProduct() {
    // TODO: implement transferProduct
  }

  @override
  void updateProduct(
    String barcode,
    String name,
    int quantity,
    String unit,
    double price,
  ) {
    var status;
    try {
      updateProductDetails(barcode, name, quantity, unit, price)
          .then((value) => status);
      print('status: $status');
      if (status > 0) {
        SnackNotification.notif('Success', "Product" + '$name' + " is updated",
            Colors.green.shade600);
      } else {
        SnackNotification.notif('Error',
            "Product" + '$name' + " is not updated", Colors.red.shade600);
      }
    } catch (e) {
      SnackNotification.notif('Error', e.toString(), Colors.red.shade600);
    }
  }

  Future<int> updateProductDetails(
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

    print(product);

    try {
      final response = await http.post(
        Uri.parse("http://localhost:8090/api/products"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: product,
      );

      if (response.statusCode == 404)
        return -1;
      else if (response.statusCode == 202) return 1;
    } catch (e) {
      e.toString();
    }

    return -1;
  }
}
