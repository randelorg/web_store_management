import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_store_management/Backend/Session.dart';
import 'package:web_store_management/Models/BranchModel.dart';
import 'package:web_store_management/environment/Environment.dart';
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

    return collection;
  }

  Future<List<EmployeeModel>> fetchAllEmployees() async {
    final response =
        await http.get(Uri.parse("${Environment.apiUrl}/api/employees"));
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

    if (branch == 'Main') {
      response = await http.get(Uri.parse(
        "${Environment.apiUrl}/api/products/$main",
      ));
    } else {
      response = await http.get(Uri.parse(
        "${Environment.apiUrl}/api/products/${Mapping.findBranchCode(branch)}",
      ));
    }

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.productList = parsed
        .map<ProductModel>((json) => ProductModel.fromJson(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.productList;
  }

  Future<List<BorrowerModel>> fetchBorrowers() async {
    final response =
        await http.get(Uri.parse("${Environment.apiUrl}/api/borrowers"));
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.borrowerList = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonPartial(json))
        .toList();
    return Mapping.borrowerList;
  }

  //fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchCreditApprovals() async {
    final response =
        await http.get(Uri.parse("${Environment.apiUrl}/api/credit"));

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.creditApprovals = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonApproval(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.creditApprovals;
  }

//fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchReleaseApprovals() async {
    final response =
        await http.get(Uri.parse("${Environment.apiUrl}/api/toberelease"));

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.releaseApproval = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonApproval(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.releaseApproval;
  }

  //fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchRepairs() async {
    final response =
        await http.get(Uri.parse("${Environment.apiUrl}/api/repairs"));

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.repairs = parsed
        .map<BorrowerModel>((json) => BorrowerModel.fromJsonRepair(json))
        .toList();
    // Use the compute function to run parseAdmin in a separate isolate.
    return Mapping.repairs;
  }

  //fetch all the credit approvals from the database
  Future<List<BorrowerModel>> fetchRequestedProducts() async {
    final response = await http
        .get(Uri.parse("${Environment.apiUrl}/api/requestedproducts"));
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
    final response =
        await http.get(Uri.parse("${Environment.apiUrl}/api/branches"));

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
    Mapping.branchList = parsed
        .map<BranchModel>((json) => BranchModel.fromJsonPartial(json))
        .toList();
    // Use the compute function to run parseBranches in a separate isolate.
    return Mapping.branchList;
  }
}
