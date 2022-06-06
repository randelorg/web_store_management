import 'PersonModel.dart';

class BorrowerModel extends PersonModel {
  int? borrowerId;
  int? returnId;
  String? productCode;
  int? investigationID;
  String? returnProductName;
  double? balance;
  String? status;
  List<dynamic>? contractImage;

  //new retuns attribs
  String? productItemId;
  String? turnOverDate;
  String? returnStatus;

  get getProductItemId => this.productItemId;

  set setProductItemId(productItemId) => this.productItemId = productItemId;

  get getTurnOverDate => this.turnOverDate;

  set setTurnOverDate(turnOverDate) => this.turnOverDate = turnOverDate;

  get getReturnStatus => this.returnStatus;

  set setReturnStatus(returnStatus) => this.returnStatus = returnStatus;

  get getBorrowerId => this.borrowerId;

  set setBorrowerId(borrowerId) => this.borrowerId = borrowerId;

  get getReturnId => this.returnId;

  set setReturnId(repairId) => this.returnId = repairId;

  get getProductCode => this.productCode;

  set setProductCode(productCode) => this.productCode = productCode;

  get getinvestigationID => this.investigationID;

  set setinvestigationID(int investigationID) =>
      this.investigationID = investigationID;

  get getReturnProductName => this.returnProductName;

  set setReturnProductName(String returnProductName) =>
      this.returnProductName = returnProductName;

  get getBalance => this.balance;

  set setBalance(balance) => this.balance = balance;

  get getStatus => this.status;

  set setStatus(String status) => this.status = status;

  get getContractImage => this.contractImage;

  set setContractImage(contractImage) => this.contractImage = contractImage;

  BorrowerModel.empty() : super.empty();

  BorrowerModel.invoice(String name, String homeAddress)
      : super.invoice(name, homeAddress);

  BorrowerModel.newLoan(String firstname, String lastname, String mobile,
      String homeAddress, List<dynamic> contract)
      : super.withOutId(firstname, lastname, mobile, homeAddress) {
    this.contractImage = contract;
  }

  BorrowerModel.full(
      int borrowerId,
      String firstname,
      String lastname,
      String mobileNumber,
      String homeAddress,
      double balance,
      String status,
      List<dynamic>? contractImage)
      : super.withOutId(firstname, lastname, mobileNumber, homeAddress) {
    this.borrowerId = borrowerId;
    this.balance = balance;
    this.status = status;
    this.contractImage = contractImage;
  }

  BorrowerModel.contractOnly(List<dynamic> contractImage) : super.empty() {
    this.contractImage = contractImage;
  }

  BorrowerModel.jsonContractOnly({this.contractImage}) : super.empty() {
    this.contractImage = contractImage;
  }

  BorrowerModel.fullJson({
    this.borrowerId,
    firstname,
    lastname,
    mobileNumber,
    homeAddress,
    this.balance,
    this.contractImage,
  }) : super.withOutId(firstname, lastname, mobileNumber, homeAddress);

  BorrowerModel.creditApproval(
      {this.investigationID,
      this.borrowerId,
      firstname,
      lastname,
      mobileNumber,
      homeAddress,
      this.status})
      : super.withOutId(firstname, lastname, mobileNumber, homeAddress);

  BorrowerModel.toBeRelease(
      {this.investigationID,
      this.borrowerId,
      firstname,
      lastname,
      mobileNumber,
      homeAddress,
      this.status,
      this.productCode})
      : super.withOutId(firstname, lastname, mobileNumber, homeAddress);

  BorrowerModel.returns({
    this.returnStatus,
    this.returnId,
    this.productItemId,
    this.turnOverDate,
    this.returnProductName,
    name,
    mobile,
    address,
  }) : super.returns(name, mobile, address);

  BorrowerModel.fullJsonPartial({
    this.borrowerId,
    firstname,
    lastname,
    mobileNumber,
    homeAddress,
    this.balance,
  }) : super.withOutId(firstname, lastname, mobileNumber, homeAddress);

  factory BorrowerModel.fromJsonContract(Map<String, dynamic> json) {
    return BorrowerModel.jsonContractOnly(
      contractImage: json['ContractImage']["data"] as List<dynamic>,
    );
  }

  factory BorrowerModel.fromJsonApproval(Map<String, dynamic> json) {
    return BorrowerModel.creditApproval(
      investigationID: json['InvestigationID'] as int,
      borrowerId: json['BorrowerID'] as int,
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
      mobileNumber: json['MobileNumber'] as String,
      homeAddress: json['HomeAddress'] as String,
      status: json['ResultStatus'] as String,
    );
  }

  factory BorrowerModel.fromJsonRelaease(Map<String, dynamic> json) {
    return BorrowerModel.toBeRelease(
      investigationID: json['InvestigationID'] as int,
      borrowerId: json['BorrowerID'] as int,
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
      mobileNumber: json['MobileNumber'] as String,
      homeAddress: json['HomeAddress'] as String,
      status: json['ResultStatus'] as String,
      productCode: json['ProductCode'] as String,
    );
  }

  factory BorrowerModel.fromJsonReturns(Map<String, dynamic> json) {
    return BorrowerModel.returns(
      returnStatus: json['Status'] as String,
      returnId: json['ReturnID'] as int,
      productItemId: json['ProductItemID'] as String,
      turnOverDate: json['TurnoverDate'] as String,
      returnProductName: json['ProdName'] as String,
      name: json['Fullname'] as String,
      mobile: json['MobileNumber'] as String,
      address: json['Address'] as String,
    );
  }

  factory BorrowerModel.fromJson(Map<String, dynamic> json) {
    return BorrowerModel.fullJson(
      borrowerId: json['BorrowerID'] as int,
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
      mobileNumber: json['MobileNumber'] as String,
      homeAddress: json['HomeAddress'] as String,
      balance: json['Balance'] as double,
      contractImage: json['ContractImage']["data"] as List<dynamic>,
    );
  }

  factory BorrowerModel.fromJsonPartial(Map<String, dynamic> json) {
    return BorrowerModel.fullJsonPartial(
      borrowerId: json['BorrowerID'] as int,
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
      mobileNumber: json['MobileNumber'] as String,
      homeAddress: json['HomeAddress'] as String,
      balance: json['Balance'] as double,
    );
  }
}
