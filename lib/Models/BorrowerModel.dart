import 'PersonModel.dart';

class BorrowerModel extends PersonModel {
  int? borrowerId;
  int? repairId;
  int? requestId;
  int? investigationID;
  String? repairProductName;
  String? requestedProductName;
  double? balance;
  String? status;
  List<dynamic>? contractImage;

  get getBorrowerId => this.borrowerId;

  set setBorrowerId(borrowerId) => this.borrowerId = borrowerId;

  get getRepairId => this.repairId;

  set setRepairId(repairId) => this.repairId = repairId;

  get getRequestId => this.requestId;

  set setRequestId(int requestId) => this.requestId = requestId;

  get getinvestigationID => this.investigationID;

  set setinvestigationID(int investigationID) =>
      this.investigationID = investigationID;

  get getRepairProductName => this.repairProductName;

  set setRepairProductName(String repairProductName) =>
      this.repairProductName = repairProductName;

  get getRequestedProductName => this.requestedProductName;

  set setRequestedProductName(String requestedProductName) =>
      this.requestedProductName = requestedProductName;

  get getBalance => this.balance;

  set setBalance(balance) => this.balance = balance;

  get getStatus => this.status;

  set setStatus(String status) => this.status = status;

  get getContractImage => this.contractImage;

  set setContractImage(contractImage) => this.contractImage = contractImage;

  BorrowerModel.empty() : super.empty();

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

  BorrowerModel.repairs(
      {this.repairId,
      this.borrowerId,
      this.repairProductName,
      firstname,
      lastname,
      mobileNumber,
      homeAddress})
      : super.withOutId(firstname, lastname, mobileNumber, homeAddress);

  BorrowerModel.requestProduct(
      {this.requestId,
      this.borrowerId,
      this.requestedProductName,
      firstname,
      lastname,
      mobileNumber,
      homeAddress})
      : super.withOutId(firstname, lastname, mobileNumber, homeAddress);

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

  factory BorrowerModel.fromJsonRepair(Map<String, dynamic> json) {
    return BorrowerModel.repairs(
      repairId: json['RepairID'] as int,
      borrowerId: json['BorrowerID'] as int,
      repairProductName: json['Product'] as String,
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
      mobileNumber: json['MobileNumber'] as String,
      homeAddress: json['HomeAddress'] as String,
    );
  }

  factory BorrowerModel.fromJsonRequestedProduct(Map<String, dynamic> json) {
    return BorrowerModel.requestProduct(
      requestId: json['RequestID'] as int,
      borrowerId: json['BorrowerID'] as int,
      requestedProductName: json['Product'] as String,
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
      mobileNumber: json['MobileNumber'] as String,
      homeAddress: json['HomeAddress'] as String,
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
