import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Admin_model.dart';
import 'Utility/Mapping.dart';
import '../Models/Product_model.dart';

class GlobalController {
  //for admin login
  //gathers all accounts from database
  //after this use the function Login from Admin_operations
  Future<List<Admin>> fetchAdmin() async {
    final response =
        await http.get(Uri.parse('http://localhost:8090/api/loginAdmin'));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseAdmin, response.body);
  }

  // A function that converts a response body into a List<Admin>.
  List<Admin> parseAdmin(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.adminList =
        parsed.map<Admin>((json) => Admin.fromJsonAdmin(json)).toList();
    return Mapping.adminList;
  }

  //fetch all the products from the database
  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://localhost:8090/api/products'));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseProducts, response.body);
  }

  List<Product> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.productList =
        parsed.map<Product>((json) => Product.fromJson(json)).toList();
    return Mapping.productList;
  }
}
