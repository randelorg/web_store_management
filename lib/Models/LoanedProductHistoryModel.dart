import 'package:intl/intl.dart';

class LoanedProductHistory {
  int? loanId;

  String? productName;
  double? price;
  int? qty;
  String? paymentPlan;
  String? dueDate;
  String? term;
  String? dateAdded;

  get getLoanId => this.loanId;

  set setLoanId(loanId) => this.loanId = loanId;

  get getProductName => this.productName;

  set setProductName(productName) => this.productName = productName;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getQty => this.qty;

  set setQty(qty) => this.qty = qty;

  get getPaymentPlan => this.paymentPlan;

  set setPaymentPlan(paymentPlan) => this.paymentPlan = paymentPlan;

  get getDueDate => convertDateTimeDisplay(this.dueDate.toString());

  set setDueDate(dueDate) => this.dueDate = dueDate;

  get getTerm => this.term;

  set setTerm(term) => this.term = term;

  get getDateAdded => convertDateTimeDisplay(this.dateAdded.toString());

  set setDateAdded(dateAdded) => this.dateAdded = dateAdded;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  LoanedProductHistory.empty();

  LoanedProductHistory.full(
      {this.loanId,
      this.productName,
      this.price,
      this.qty,
      this.paymentPlan,
      this.dueDate,
      this.term,
      this.dateAdded}) {
    this.loanId = loanId;
    this.productName = productName;
    this.price = price;
    this.qty = qty;
    this.paymentPlan = paymentPlan;
    this.dueDate = dueDate;
    this.term = term;
    this.dateAdded = dateAdded;
  }

  factory LoanedProductHistory.fromJson(Map<String, dynamic> json) {
    return LoanedProductHistory.full(
      loanId: json['LoanID'] as int,
      productName: json['ProdName'] as String,
      price: json['ProdPrice'] as double,
      qty: json['Qty'] as int,
      paymentPlan: json['PaymentPlan'] as String,
      dueDate: json['DueDate'] as String,
      term: json['Term'] as String,
      dateAdded: json['DateAdded'] as String,
    );
  }
}
