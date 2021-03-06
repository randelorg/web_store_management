import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Backend/Utility/Mapping.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/BranchModel.dart';
import 'package:web_store_management/Models/EmployeeModel.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Models/SupplierModel.dart';
import 'package:web_store_management/environment/Environment.dart';

class GlobalController {
  //fetch this week collection
  Future<List<String>> getThisWeekCollection() async {
    List<String> collection = [];
    DateTime today = DateTime.now();
    DateTime _firstDayOfTheweek =
        today.subtract(new Duration(days: today.weekday - 1));

    return collection;
  }

  Future<List<EmployeeModel>> fetchAllEmployees() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/api/employees"),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.employeeList = parsed
        .map<EmployeeModel>((json) => EmployeeModel.fromJson(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.employeeList;
  }

  //fetch all the products from the database
  Future<List<ProductModel>> fetchProducts() async {
    String branch = '';
    final String main = "Main";
    var response;
    await Session.getBranch().then((branchName) {
      branch = branchName;
    });

    response = await http.get(
      Uri.parse(
        "${Environment.apiUrl}/api/products/${Mapping.findBranchCode(branch)}",
      ),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.productList = parsed
        .map<ProductModel>((json) => ProductModel.fromJson(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.productList;
  }

  Future<List<IncomingPurchasesModel>> fetchIncomingPurchases() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/api/incomingpurchases"),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.groupedPurchase = parsed
        .map<IncomingPurchasesModel>(
            (json) => IncomingPurchasesModel.jsonOrderSlip(json))
        .toList();
    return Mapping.groupedPurchase;
  }

  Future<List<BorrowerModel>> fetchBorrowers() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/api/borrowers"),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.borrowerList = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonPartial(json))
        .toList();
    return Mapping.borrowerList;
  }

  Future<List<SupplierModel>> fetchSuppliers() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/api/suppliers"),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.suppliersList = parsed
        .map<SupplierModel>((json) => SupplierModel.fromJson(json))
        .toList();
    return Mapping.suppliersList;
  }

  //fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchCreditApprovals() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/api/credit"),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.creditApprovals = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonApproval(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.creditApprovals;
  }

//fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchReleaseApprovals() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/api/toberelease"),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.releaseApproval = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonApproval(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.releaseApproval;
  }

  //fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchRepairs() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/api/repairs"),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.repairs = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonRepair(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.repairs;
  }

  //fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchRequestedProducts() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/api/requestedproducts"),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.requested = parsed
        .map<BorrowerModel>(
            (json) => BorrowerModel.fromJsonRequestedProduct(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.requested;
  }

  //fetch all the branches from the database
  Future<List<BranchModel>> fetchBranches() async {
    final response = await http.get(
      Uri.parse("${Environment.apiUrl}/api/branches"),
      headers: {HttpHeaders.authorizationHeader: "${Environment.apiToken}"},
    );

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.branchList = parsed
        .map<BranchModel>((json) => BranchModel.fromJsonPartial(json))
        .toList();
    // Use the compute function to run parseBranches in a separate isolate.
    return Mapping.branchList;
  }
}
