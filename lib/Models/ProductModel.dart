class ProductModel {
  String? productCode;
  String? productItemCode;
  String? productName;
  String? productLabel;
  double? productPrice;
  String? productUnit;
  String? prodType;
  int? startingInventory;
  int? inventoryReceived;
  int? inventoryOnHand;
  int? inventorySold;

  get getProductCode => this.productCode;

  set setProductCode(String? productCode) => this.productCode = productCode;

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

  get getStartingInventory => this.startingInventory;

  set setStartingInventory(startingInventory) =>
      this.startingInventory = startingInventory;

  get getInventoryReceived => this.inventoryReceived;

  set setInventoryReceived(inventoryReceived) =>
      this.inventoryReceived = inventoryReceived;

  get getInventoryOnHand => this.inventoryOnHand;

  set setInventoryOnHand(inventoryOnHand) =>
      this.inventoryOnHand = inventoryOnHand;

  get getInventorySold => this.inventorySold;

  set setInventorySold(inventorySold) => this.inventorySold = inventorySold;

  ProductModel.empty();

  ProductModel.incomingPurchases(
      String prodCode, String prodName, String prodType) {
    this.productCode = prodCode;
    this.productName = prodName;
    this.prodType = prodType;
  }

  ProductModel.cashPayment(String barcode, String name, double price, int qty) {
    this.productCode = barcode;
    this.productName = name;
    this.productPrice = price;
  }

  ProductModel.selectedProduct(String barcode, String name, double price) {
    this.productCode = barcode;
    this.productName = name;
    this.productPrice = price;
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
      int startingInventory,
      int inventoryReceived,
      int inventoryOnHand,
      int inventorySold) {
    this.productCode = productCode;
    this.productName = productName;
    this.productPrice = productPrice;
    this.productUnit = productUnit;
    this.prodType = prodType;
    this.productLabel = prodLabel;
    this.productItemCode = productItemCode;
    this.startingInventory = startingInventory;
    this.inventoryReceived = inventoryReceived;
    this.inventoryOnHand = inventoryOnHand;
    this.inventorySold = inventorySold;
  }

  ProductModel.fullJson(
      {this.productCode,
      this.productName,
      this.productPrice,
      this.productUnit,
      this.prodType,
      this.productLabel,
      this.startingInventory,
      this.inventoryReceived,
      this.inventoryOnHand,
      this.inventorySold}) {
    this.productCode = productCode;
    this.productName = productName;
    this.productPrice = productPrice;
    this.productUnit = productUnit;
    this.prodType = prodType;
    this.productLabel = productLabel;
    this.startingInventory = startingInventory;
    this.inventoryReceived = inventoryReceived;
    this.inventoryOnHand = inventoryOnHand;
    this.inventorySold = inventorySold;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel.fullJson(
      productCode: json['ProductCode'] as String,
      productName: json['ProdName'] as String,
      productPrice: json['ProdPrice'] as double,
      productUnit: json['ProdUnit'] as String,
      prodType: json['ProdType'] as String,
      productLabel: json['ProdLabel'] as String?,
      startingInventory: json['StartingInventory'] as int,
      inventoryReceived: json['InventoryReceived'] as int,
      inventoryOnHand: json['InventoryOnHand'] as int,
      inventorySold: json['InventorySold'] as int,
    );
  }
}
