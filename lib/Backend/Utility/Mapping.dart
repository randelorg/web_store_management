import 'package:intl/intl.dart';
import 'package:web_store_management/Models/AdminModel.dart';
import 'package:web_store_management/Models/BorrowerModel.dart';
import 'package:web_store_management/Models/BranchModel.dart';
import 'package:web_store_management/Models/EmployeeModel.dart';
import 'package:web_store_management/Models/ForgetPasswordModel.dart';
import 'package:web_store_management/Models/IncomingPurchasesModel.dart';
import 'package:web_store_management/Models/InvoiceModel.dart';
import 'package:web_store_management/Models/LoanedProductHistoryModel.dart';
import 'package:web_store_management/Models/PaymentHistoryModel.dart';
import 'package:web_store_management/Models/ProductModel.dart';
import 'package:web_store_management/Models/SupplierModel.dart';

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

  static String dateTodayTime() {
    var _formatter = new DateFormat('dd-MM-yyy hh:mm:ss a');
    var _now = new DateTime.now();
    String formattedDate = _formatter.format(_now);
    return formattedDate;
  }

  static String dateToday() {
    var _formatter = new DateFormat('dd-MM-yyyy');
    var _now = new DateTime.now();
    String formattedDate = _formatter.format(_now);
    return formattedDate;
  }

  //formating currency and date
  static formatPrice(double price) => '\PHP ${price.toStringAsFixed(2)}';
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
  static List<IncomingPurchasesModel> groupedPurchase = [];
  static List<IncomingPurchasesModel> purchases = [];
  static List<IncomingPurchasesModel> ordersList = [];
  static List<SupplierModel> suppliersList = [];
  static List<IncomingPurchasesModel> receiverOrders = [];
  static List<IncomingPurchasesModel> productItems = [];

  //invoice
  static List<InvoiceProductItem> invoice = [];

  //forget password
  static List<ForgetPasswordModel> forgetPassword = [];
}
