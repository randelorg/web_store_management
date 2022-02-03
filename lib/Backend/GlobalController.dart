import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Models/BranchModel.dart';
import 'Utility/ApiUrl.dart';
import 'Utility/Mapping.dart';
import '../Models/ProductModel.dart';
import '../Models/BorrowerModel.dart';
import '../Models/EmployeeModel.dart';

class GlobalController {
  //fetch this week collection
  Future<List<String>> getThisWeekCollection() async {
    List<String> collection = [];
    DateTime today = DateTime.now();
    DateTime _firstDayOfTheweek =
        today.subtract(new Duration(days: today.weekday - 1));
    print(_firstDayOfTheweek.day);

    return collection;
  }

  //fetch all the employees from the database
  Future<List<EmployeeModel>> fetchAllEmployees() async {
    final response = await http.get(Uri.parse(Url.url + "api/employees"));

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
    final response = await http.get(Uri.parse(Url.url + "api/products"));

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
    final response = await http.get(Uri.parse(Url.url + "api/borrowers"));

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

  //fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchCreditApprovals() async {
    final response = await http.get(Uri.parse(Url.url + "api/credit"));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseCreditApprovals, response.body);
  }

  List<BorrowerModel> parseCreditApprovals(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.creditApprovals = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonApproval(json))
        .toList();
    return Mapping.creditApprovals;
  }

  //fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchRepairs() async {
    final response = await http.get(Uri.parse(Url.url + "api/repairs"));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseRepairs, response.body);
  }

  List<BorrowerModel> parseRepairs(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.repairs = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonRepair(json))
        .toList();
    return Mapping.repairs;
  }

  //fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchRequestedProducts() async {
    final response =
        await http.get(Uri.parse(Url.url + "api/requestedproducts"));

    // Use the compute function to run parseAdmin in a separate isolate.
    return compute(parseRequestedProducts, response.body);
  }

  List<BorrowerModel> parseRequestedProducts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.requested = parsed
        .map<BorrowerModel>(
            (json) => BorrowerModel.fromJsonRequestedProduct(json))
        .toList();
    return Mapping.requested;
  }

  //fetch all the branches from the database
  Future<List<BranchModel>> fetchBranches() async {
    final response =
        await http.get(Uri.parse("http://localhost:8090/api/branches"));

    // Use the compute function to run parseBranches in a separate isolate.
    return compute(parseBranches, response.body);
  }

  List<BranchModel> parseBranches(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    Mapping.branchList = parsed
        .map<BranchModel>((json) => BranchModel.fromJsonPartial(json))
        .toList();
    return Mapping.branchList;
  }
}
