import 'package:intl/intl.dart';
import 'package:web_store_management/Models/ProductModel.dart';

class ProductTransferHistoryModel extends ProductModel {
  String? dateTransferred;
  int? qty;

  get getQty => this.qty;

  set setQty(qty) => this.qty = qty;

  get getDateTransferred =>
      convertDateTimeDisplay(this.dateTransferred.toString());

  set setDateTransferred(dateTransferred) =>
      this.dateTransferred = dateTransferred;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  ProductTransferHistoryModel.empty() : super.empty();

  ProductTransferHistoryModel.full(
      {this.dateTransferred, this.qty, prodCode, prodName})
      : super.codeAndName(prodCode, prodName);

  factory ProductTransferHistoryModel.fromJson(Map<String, dynamic> json) {
    return ProductTransferHistoryModel.full(
      dateTransferred: json['TransferredDate'] as String,
      prodCode: json['ProductCode'] as String,
      prodName: json['ProdName'] as String,
      qty: json['QTY'] as int,
    );
  }
}
