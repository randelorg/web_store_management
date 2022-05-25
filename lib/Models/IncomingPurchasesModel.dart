import 'package:web_store_management/Models/ProductModel.dart';

class IncomingPurchasesModel extends ProductModel {
  int? supplierId;
  String? supplierName;
  int? numberReceived;
  String? datePurchase;

  get getDatePurchase => this.datePurchase;

  set setDatePurchase(datePurchase) => this.datePurchase = datePurchase;

  get getSupplierId => this.supplierId;

  set setSupplierId(supplierId) => this.supplierId = supplierId;

  get getSupplierName => this.supplierName;

  set setSupplierName(supplierName) => this.supplierName = supplierName;

  get getNumberReceived => this.numberReceived;

  set setNumberReceived(numberReceived) => this.numberReceived = numberReceived;

  IncomingPurchasesModel.empty() : super.empty();

  IncomingPurchasesModel.incomingPurchases(
      int supplierId,
      String supplierName,
      String productCode,
      String productName,
      String purchaseDate,
      String prodType)
      : super.incomingPurchases(productCode, productName, prodType) {
    this.supplierId = supplierId;
    this.supplierName = supplierName;
    this.datePurchase = purchaseDate;
  }

  IncomingPurchasesModel.fullJson({
    this.supplierId,
    this.supplierName,
    this.numberReceived,
    this.datePurchase,
    productCode,
    productName,
    prodType,
  }) : super.incomingPurchases(productCode, productName, prodType) {
    this.supplierId = supplierId;
    this.supplierName = supplierName;
    this.numberReceived = numberReceived;
    this.datePurchase = datePurchase;
  }

  factory IncomingPurchasesModel.fromJson(Map<String, dynamic> json) {
    return IncomingPurchasesModel.fullJson(
      productCode: json['ProductCode'] as String,
      productName: json['ProdName'] as String,
      supplierId: json['SupplierID'] as int,
      supplierName: json['SupplierName'] as String,
      numberReceived: json['NumberReceived'] as int,
      datePurchase: json['PurchaseDate'] as String,
      prodType: json['ProdType'] as String,
    );
  }
}
