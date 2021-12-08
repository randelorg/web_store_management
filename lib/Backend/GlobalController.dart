import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Admin_model.dart';
import 'Utility/Mapping.dart';
import '../Models/Product_model.dart';
import '../Models/Borrower_model.dart';
import '../Models/Employee_model.dart';

class GlobalController {
  // A function that converts a response body into a List<Admin>.
  Future<List<AdminModel>> parseAdmin(String responseBody) async {
    final parsed = await jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<AdminModel>((json) => AdminModel.fromJson(json)).toList();
  }

  // A function that converts a response body into a List<Employee>.
  Future<List<EmployeeModel>> parseEmployee(String responseBody) async {
    final parsed = await jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<EmployeeModel>((json) => EmployeeModel.fromJson(json))
        .toList();
  }

  //fetch all the employees from the database
  Future<List<EmployeeModel>> fetchAllEmployees() async {
    final response =
        await http.get(Uri.parse('http://localhost:8090/api/employees'));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseAllEmployees, response.body);
  }

  List<EmployeeModel> parseAllEmployees(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.employeeList = parsed
        .map<EmployeeModel>((json) => EmployeeModel.fromJson(json))
        .toList();
    return Mapping.employeeList;
  }

  //fetch all the products from the database
  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://localhost:8090/api/products'));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseProducts, response.body);
  }

  List<ProductModel> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.productList = parsed
        .map<ProductModel>((json) => ProductModel.fromJson(json))
        .toList();
    return Mapping.productList;
  }

  //fetch all the borrowers from the database
  Future<List<BorrowerModel>> fetchBorrowers() async {
    final response =
        await http.get(Uri.parse('http://localhost:8090/api/borrowers'));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseBorrowers, response.body);
  }

  List<BorrowerModel> parseBorrowers(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.borrowerList = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonPartial(json))
        .toList();
    return Mapping.borrowerList;
  }
}
