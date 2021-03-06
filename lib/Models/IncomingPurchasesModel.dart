import 'package:intl/intl.dart';
import 'package:web_store_management/Models/ProductModel.dart';

class IncomingPurchasesModel extends ProductModel {
  int? supplierId;
  String? purchaseOrderSlip;
  String? supplierName;
  int? numberReceived;
  String? datePurchase;
  String? productItemCode;
  String? remarks;
  String? status;
  int? qty;

  get getStatus => this.status;

  set setStatus(status) => this.status = status;

  get getProductItemCode => this.productItemCode;

  set setProductItemCode(productItemCode) =>
      this.productItemCode = productItemCode;

  get getRemarks => this.remarks;

  set setRemarks(remarks) => this.remarks = remarks;

  get getPurchaseOrderSlip => this.purchaseOrderSlip;

  set setPurchaseOrderSlip(purchaseOrderSlip) =>
      this.purchaseOrderSlip = purchaseOrderSlip;

  get getQty => this.qty;

  set setQty(qty) => this.qty = qty;

  get getDatePurchase => convertDateTimeDisplay(this.datePurchase.toString());

  set setDatePurchase(datePurchase) => this.datePurchase = datePurchase;

  get getSupplierId => this.supplierId;

  set setSupplierId(supplierId) => this.supplierId = supplierId;

  get getSupplierName => this.supplierName;

  set setSupplierName(supplierName) => this.supplierName = supplierName;

  get getNumberReceived => this.numberReceived;

  set setNumberReceived(numberReceived) => this.numberReceived = numberReceived;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  IncomingPurchasesModel.empty() : super.empty();

  IncomingPurchasesModel.receive(String itemCode, String remarks, prodCode)
      : super.productCodeOnly(prodCode) {
    this.productItemCode = itemCode;
    this.remarks = remarks;
  }

  IncomingPurchasesModel.productItems(String itemCode, String remarks)
      : super.empty() {
    this.productItemCode = itemCode;
    this.remarks = remarks;
  }

  IncomingPurchasesModel.items({
    this.productItemCode,
    productCode,
    this.remarks,
    this.status,
    price,
  }) : super.productPrice(productCode, price);

  factory IncomingPurchasesModel.jsonItems(Map<String, dynamic> json) {
    return IncomingPurchasesModel.items(
      productCode: json['ProductCode'] as String,
      productItemCode: json['ProductItemID'] as String,
      remarks: json['Remarks'] as String,
      status: json['Status'] as String,
      price: json['ProdPrice'] as double,
    );
  }

  IncomingPurchasesModel.purchase(
    String productCode,
    String productName,
    int qty,
    String prodType,
    String datePurchase,
  ) : super.incomingPurchases(productCode, productName, prodType) {
    this.datePurchase = datePurchase;
    this.qty = qty;
  }

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

  IncomingPurchasesModel.order({
    productCode,
    productName,
    prodType,
    this.supplierName,
    this.numberReceived,
    this.datePurchase,
  }) : super.incomingPurchases(productCode, productName, prodType);

  factory IncomingPurchasesModel.jsonOrder(Map<String, dynamic> json) {
    return IncomingPurchasesModel.order(
      productCode: json['ProductCode'] as String,
      productName: json['ProdName'] as String,
      prodType: json['ProdType'] as String,
      supplierName: json['SupplierName'] as String,
      numberReceived: json['NumberReceived'] as int,
      datePurchase: json['PurchaseDate'] as String,
    );
  }

  IncomingPurchasesModel.orderSlip(
      {this.purchaseOrderSlip,
      this.supplierName,
      this.datePurchase,
      this.status})
      : super.empty();

  factory IncomingPurchasesModel.jsonOrderSlip(Map<String, dynamic> json) {
    return IncomingPurchasesModel.orderSlip(
      purchaseOrderSlip: json['PurchaseOrderSlipID'] as String,
      supplierName: json['SupplierName'] as String,
      datePurchase: json['PurchaseDate'] as String,
      status: json['Status'] as String,
    );
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
