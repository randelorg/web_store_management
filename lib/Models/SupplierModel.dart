class SupplierModel {
  String? supplierName;
  String? supplierMobile;
  String? supplierWebsite;

  get getSupplierName => this.supplierName;

  set setSupplierName(supplierName) => this.supplierName = supplierName;

  get getSupplierMobile => this.supplierMobile;

  set setSupplierMobile(supplierMobile) => this.supplierMobile = supplierMobile;

  get getSupplierWebsite => this.supplierWebsite;

  set setSupplierWebsite(supplierWebsite) =>
      this.supplierWebsite = supplierWebsite;

  SupplierModel.empty();

  SupplierModel.full(String name, String mobile, String website) {
    this.supplierName = name;
    this.supplierMobile = mobile;
    this.supplierWebsite = website;
  }

  SupplierModel.fullJson({
    this.supplierName,
    this.supplierMobile,
    this.supplierWebsite,
  }) {
    this.supplierName = supplierName;
    this.supplierMobile = supplierMobile;
    this.supplierWebsite = supplierWebsite;
  }

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel.fullJson(
      supplierName: json["SupplierName"] as String,
      supplierMobile: json["SupplierMobile"] as String?,
      supplierWebsite: json["SupplierWebsite"] as String?,
    );
  }
}
