import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_store_management/Notification/BannerNotif.dart';
import 'package:http/http.dart' as http;
import 'package:web_store_management/environment/Environment.dart';
import 'Interfaces/IProduct.dart';
import 'dart:io';

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

  Future<bool> addProduct(String barcode, String productName, String quantity,
      String unit, double price) async {
    var response, newProduct;
    newProduct = json.encode(
      {
        "barcode": barcode,
        "name": productName,
        "quantity": quantity,
        "unit": unit,
        "price": price
      },
    );

    try {
      await Environment.methodPost(
              "${Environment.apiUrl}/api/addproduct", newProduct)
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
  void deleteProduct() {
    // TODO: implement deleteProduct
  }

  @override
  void transferProduct() {
    // TODO: implement transferProduct
  }
}
