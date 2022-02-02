class BranchModel {
  String? _employeeAssigned;
  String? _branchCode;
  String? _branchName;
  String? _branchAddress;
  String? _productCodeCopy;
  int? _prodQty;

  String? get employeeAssigned => this._employeeAssigned;

  set employeeAssigned(String? value) => this._employeeAssigned = value;

  get branchCode => this._branchCode;

  set branchCode(value) => this._branchCode = value;

  get branchName => this._branchName;

  set branchName(value) => this._branchName = value;

  get branchAddress => this._branchAddress;

  set branchAddress(value) => this._branchAddress = value;

  get productCodeCopy => this._productCodeCopy;

  set productCodeCopy(value) => this._productCodeCopy = value;

  get prodQty => this._prodQty;

  set prodQty(value) => this._prodQty = value;

  BranchModel.empty();

  //for fetching the data from the database JSON format
  BranchModel.noEmployee(
      {String? branchCode,
      String? branchName,
      String? branchAddress,
      String? productCodeCopy,
      int? prodQty}) {
    this._branchCode = branchCode;
    this._branchName = branchName;
    this._branchAddress = branchAddress;
    this._productCodeCopy = productCodeCopy;
    this._prodQty = prodQty;
  }

  BranchModel.fullJson(
      {String? employeeAssigned,
      String? branchCode,
      String? branchName,
      String? branchAddress,
      String? productCodeCopy,
      int? prodQty}) {
    this._employeeAssigned = employeeAssigned;
    this._branchCode = branchCode;
    this._branchName = branchName;
    this._branchAddress = branchAddress;
    this._productCodeCopy = productCodeCopy;
    this._prodQty = prodQty;
  }

  factory BranchModel.fromJsonNoEmp(Map<String, dynamic> json) {
    return BranchModel.noEmployee(
      branchCode: json['BranchCode'] as String,
      branchName: json['BranchName'] as String,
      branchAddress: json['BranchAddress'] as String,
      productCodeCopy: json['ProductCode_Copy'] as String,
      prodQty: json['ProdQty'] as int,
    );
  }

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel.fullJson(
      employeeAssigned: json['EmployeeID'] as String,
      branchCode: json['BranchCode'] as String,
      branchName: json['BranchName'] as String,
      branchAddress: json['BranchAddress'] as String,
      productCodeCopy: json['ProductCode_Copy'] as String,
      prodQty: json['ProdQty'] as int,
    );
  }
}
