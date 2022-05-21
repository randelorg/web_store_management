import 'package:intl/intl.dart';
import 'package:web_store_management/Models/BranchModel.dart';
import 'package:web_store_management/Models/ForgetPasswordModel.dart';
import 'package:web_store_management/Models/InvoiceModel.dart';
import 'package:web_store_management/Models/LoanedProductHistoryModel.dart';
import '../../Models/PaymentHistoryModel.dart';
import '../../Models/AdminModel.dart';
import '../../Models/EmployeeModel.dart';
import '../../Models/ProductModel.dart';
import '../../Models/BorrowerModel.dart';

class Mapping {
  static String findBranchCode(String branchName) {
    String code = '';
    Mapping.branchList
        .where((element) =>
            element.branchName?.toLowerCase() == branchName.toLowerCase())
        .forEach((element) {
      code = element.branchCode;
    });
    return code;
  }

  static String dateToday() {
    var _formatter = new DateFormat('yyyy-MM-dd hh:mm:ss a');
    var _now = new DateTime.now();
    String formattedDate = _formatter.format(_now);
    return formattedDate;
  }

  //formating currency and date
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);

  //for login purposes
  //for identifying user role
  static String userRole = '';

  //for reports purpose
  //payment and loan history
  static String borrowerId = '';

  static List<AdminModel> adminLogin = [];
  static List<EmployeeModel> employeeLogin = [];

  ///for the tables and other stuff
  static List<EmployeeModel> employeeList = [];
  static List<ProductModel> productList = [];
  static List<ProductModel> selectedProducts = [];
  static List<BorrowerModel> borrowerList = [];
  static List<BorrowerModel> creditApprovals = [];
  static List<BorrowerModel> releaseApproval = [];
  static List<PaymentHistoryModel> paymentList = [];
  static List<LoanedProductHistory> productHistoryList = [];
  static List<BorrowerModel> repairs = [];
  static List<BorrowerModel> requested = [];
  static List<BranchModel> branchList = [];

  //invoice
  static List<InvoiceItem> invoice = [];

  //forget password
  static List<ForgetPasswordModel> forgetPassword = [];
}
