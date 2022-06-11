import 'package:web_store_management/Models/SupplierModel.dart';

class ProductModel extends SupplierModel {
  String? productCode;
  String? productItemCode;
  String? productName;
  String? productLabel;
  double? productPrice;
  String? productUnit;
  String? prodType;
  int? inventoryReceived;

  get getProductCode => this.productCode;

  set setProductCode(productCode) => this.productCode = productCode;

  get getProductItemCode => this.productItemCode;

  set setProductItemCode(productItemCode) =>
      this.productItemCode = productItemCode;

  get getProductName => this.productName;

  set setProductName(productName) => this.productName = productName;

  get getProductLabel => this.productLabel;

  set setProductLabel(productLabel) => this.productLabel = productLabel;

  get getProductPrice => this.productPrice;

  set setProductPrice(productPrice) => this.productPrice = productPrice;

  get getProductUnit => this.productUnit;

  set setProductUnit(productUnit) => this.productUnit = productUnit;

  get getProdType => this.prodType;

  set setProdType(prodType) => this.prodType = prodType;

  get getInventoryReceived => this.inventoryReceived;

  set setInventoryReceived(inventoryReceived) =>
      this.inventoryReceived = inventoryReceived;

  ProductModel.empty() : super.empty();

  ProductModel.productCodeOnly(String prodCode) : super.empty() {
    this.productCode = prodCode;
  }

  ProductModel.productPrice(String prodCode, double price) : super.empty() {
    this.productCode = prodCode;
    this.productPrice = price;
  }

  ProductModel.incomingPurchases(
      String prodCode, String prodName, String prodType)
      : super.empty() {
    this.productCode = prodCode;
    this.productName = prodName;
    this.prodType = prodType;
  }

  ProductModel.cashPayment(String barcode, String name, double price, int qty)
      : super.empty() {
    this.productCode = barcode;
    this.productName = name;
    this.productPrice = price;
  }

  ProductModel.selectedProduct(String barcode, String name, double price)
      : super.empty() {
    this.productCode = barcode;
    this.productName = name;
    this.productPrice = price;
  }

  ProductModel.branchProducts(
      {this.productCode,
      this.productName,
      this.productPrice,
      this.productUnit,
      this.prodType,
      this.productLabel})
      : super.empty();

  factory ProductModel.branchProductFromJson(Map<String, dynamic> json) {
    return ProductModel.branchProducts(
      productCode: json['ProductCode'] as String,
      productName: json['ProdName'] as String,
      productPrice: json['ProdPrice'] as double,
      productUnit: json['ProdUnit'] as String,
      prodType: json['ProdType'] as String,
      productLabel: json['ProdLabel'] as String,
    );
  }

  ProductModel.full(
    String productCode,
    String productItemCode,
    String productName,
    String productLabel,
    double productPrice,
    String productUnit,
    String prodType,
    String prodLabel,
    int inventoryReceived,
  ) : super.empty() {
    this.productCode = productCode;
    this.productName = productName;
    this.productPrice = productPrice;
    this.productUnit = productUnit;
    this.prodType = prodType;
    this.productLabel = prodLabel;
    this.productItemCode = productItemCode;
    this.inventoryReceived = inventoryReceived;
  }

  ProductModel.fullJson(
      {this.productCode,
      this.productName,
      this.productPrice,
      this.productUnit,
      this.prodType,
      this.productLabel,
      this.inventoryReceived,
      name,
      mobile,
      website})
      : super.full(name, mobile, website) {
    this.productCode = productCode;
    this.productName = productName;
    this.productPrice = productPrice;
    this.productUnit = productUnit;
    this.prodType = prodType;
    this.productLabel = productLabel;
    this.inventoryReceived = inventoryReceived;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel.fullJson(
      productCode: json['ProductCode'] as String,
      productName: json['ProdName'] as String,
      productPrice: json['ProdPrice'] as double,
      productUnit: json['ProdUnit'] as String,
      prodType: json['ProdType'] as String,
      productLabel: json['ProdLabel'] as String?,
      inventoryReceived: json['InventoryReceived'] as int,
      name: json['SupplierName'] as String,
      mobile: json['SupplierMobile'] as String,
      website: json['SupplierWebsite'] as String,
    );
  }
}
