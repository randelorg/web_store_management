class SelectedProductsModel {
  String? barcode;
  double? price;
  String? name;
  int? qty;
  double? totalPrice;

  get getBarcode => this.barcode;

  set setBarcode(String barcode) => this.barcode = barcode;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getName => this.name;

  set setName(String name) => this.name = name;

  get getQty => this.qty;

  set setQty(qty) => this.qty = qty;

  get getTotalPrice => this.totalPrice;

  set setTotalPrice(totalPrice) => this.totalPrice = totalPrice;

  SelectedProductsModel.empty();

  SelectedProductsModel.full(String barcode, String name, double price) {
    this.barcode = barcode;
    this.name = name;
    this.price = price;
  }
}
