class ProductModel {
  String? productCode;
  String? productName;
  double? productPrice;
  int? productQty = 1;
  String? productUnit;
  double? price;

  get getProductUnit => this.productUnit;

  set setProductUnit(String productUnit) => this.productUnit = productUnit;

  get getProductCode => this.productCode;

  set setProductCode(String productCode) => this.productCode = productCode;

  get getProductName => this.productName;

  set setProductName(productName) => this.productName = productName;

  get getProductPrice => this.productPrice;

  set setProductPrice(productPrice) => this.productPrice = productPrice;

  get getProductQty => this.productQty;

  set setProductQty(productQty) => this.productQty = productQty;

  get getPrice => this.price;

  set setPrice(double price) => this.price = price;

  ProductModel.empty();

  ProductModel.selectedProduct(String barcode, String name, double price) {
    this.productCode = barcode;
    this.productName = name;
    this.price = price;
  }

  ProductModel.withQty(String barcode, String name, int qty, double price) {
    this.productCode = barcode;
    this.productName = name;
    this.productQty = qty;
    this.price = price;
  }

  ProductModel.full(String productCode, String productName, double productPrice,
      int productQty, String productUnit) {
    this.productCode = productCode;
    this.productName = productName;
    this.productPrice = productPrice;
    this.productQty = productQty;
    this.productUnit = productUnit;
  }

  ProductModel.fullJson(
      {this.productCode,
      this.productName,
      this.productPrice,
      this.productUnit,
      this.productQty}) {
    this.productCode = productCode;
    this.productName = productName;
    this.productPrice = productPrice;
    this.productUnit = productUnit;
    this.productQty = productQty;
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel.fullJson(
      productCode: json['ProductCode'] as String,
      productName: json['ProdName'] as String,
      productPrice: json['ProdPrice'] as double,
      productUnit: json['ProdUnit'] as String,
      productQty: json['ProdQty'] as int,
    );
  }
}
