class LoansModel {
  int? loanId;
  String? productCode;
  num? productPrice;
  int? qty;

  get getLoanId => this.loanId;

  set setLoanId(loanId) => this.loanId = loanId;

  get getProductCode => this.productCode;

  set setProductCode(productCode) => this.productCode = productCode;

  get getProductPrice => this.productPrice;

  set setProductPrice(productPrice) => this.productPrice = productPrice;

  get getQty => this.qty;

  set setQty(qty) => this.qty = qty;

  LoansModel.empty();

  LoansModel.full(int loanId, String productCode, num productPrice, int qty) {
    this.loanId = loanId;
    this.productCode = productCode;
    this.productPrice = productPrice;
    this.qty = qty;
  }

  LoansModel.fromJsonFull({
    this.loanId,
    this.productCode,
    this.productPrice,
    this.qty,
  });

  factory LoansModel.fromJson(Map<String, dynamic> json) {
    return LoansModel.fromJsonFull(
      loanId: json['loanId'] as int,
      productCode: json['productCode'] as String,
      productPrice: json['productPrice'] as num,
      qty: json['qty'] as int,
    );
  }
}
