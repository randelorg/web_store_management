import 'Person_model.dart';

class BorrowerModel extends PersonModel {
  int? borrowerId;
  double? balance;
  String? contractImage;

  get getBorrowerId => this.borrowerId;

  set setBorrowerId(borrowerId) => this.borrowerId = borrowerId;

  get getBalance => this.balance;

  set setBalance(balance) => this.balance = balance;

  get getContractImage => this.contractImage;

  set setContractImage(contractImage) => this.contractImage = contractImage;

  BorrowerModel.empty() : super.empty();

  BorrowerModel.full(
      int borrowerId,
      String firstname,
      String lastname,
      String mobileNumber,
      String homeAddress,
      double balance,
      String contractImage)
      : super.withOutId(firstname, lastname, mobileNumber, homeAddress) {
    this.borrowerId = borrowerId;
    this.balance = balance;
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

  BorrowerModel.fullJsonPartial({
    this.borrowerId,
    firstname,
    lastname,
    mobileNumber,
    homeAddress,
    this.balance,
  }) : super.withOutId(firstname, lastname, mobileNumber, homeAddress);

  factory BorrowerModel.fromJson(Map<String, dynamic> json) {
    return BorrowerModel.fullJson(
      borrowerId: json['BorrowerID'] as int,
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
      mobileNumber: json['MobileNumber'] as String,
      homeAddress: json['HomeAddress'] as String,
      balance: json['Balance'] as double,
      contractImage: json['ContractImage'] as String,
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
