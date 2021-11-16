class Product {
  String? productCode;
  String? productName;
  double? productPrice;
  int? productQty;
  String? productUnit;

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

  Product.empty();

  Product.full(String productCode, String productName, double productPrice,
      int productQty, String productUnit) {
    this.productCode = productCode;
    this.productName = productName;
    this.productPrice = productPrice;
    this.productQty = productQty;
    this.productUnit = productUnit;
  }

  Product.fullJson(
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product.fullJson(
      productCode: json['ProductCode'] as String,
      productName: json['ProdName'] as String,
      productPrice: json['ProdPrice'] as double,
      productUnit: json['ProdUnit'] as String,
      productQty: json['ProdQty'] as int,
    );
  }
}
