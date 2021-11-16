import 'Person_model.dart';

class Borrower extends Person {
  String? borrowerId;
  double? balance;
  String? qrCode;
  String? contractImage;

  get getBorrowerId => this.borrowerId;

  set setBorrowerId(borrowerId) => this.borrowerId = borrowerId;

  get getBalance => this.balance;

  set setBalance(balance) => this.balance = balance;

  get getQrCode => this.qrCode;

  set setQrCode(qrCode) => this.qrCode = qrCode;

  get getContractImage => this.contractImage;

  set setContractImage(contractImage) => this.contractImage = contractImage;

  Borrower.empty() : super.empty();

  Borrower.full(
      String borrowerId,
      String firstname,
      String lastname,
      String mobileNumber,
      String homeAddress,
      double balance,
      String qrCode,
      String contractImage)
      : super.withOutId(firstname, lastname, mobileNumber, homeAddress) {
    this.borrowerId = borrowerId;
    this.balance = balance;
    this.qrCode = qrCode;
    this.contractImage = contractImage;
  }

  Borrower.fullJson({
    this.borrowerId,
    firstname,
    lastname,
    mobileNumber,
    homeAddress,
    this.balance,
    this.qrCode,
    this.contractImage,
  }) : super.withOutId(firstname, lastname, mobileNumber, homeAddress);

  Borrower.fullJsonPartial({
    this.borrowerId,
    firstname,
    lastname,
    mobileNumber,
    homeAddress,
    this.balance,
  }) : super.withOutId(firstname, lastname, mobileNumber, homeAddress);

  factory Borrower.fromJson(Map<String, dynamic> json) {
    return Borrower.fullJson(
      borrowerId: json['BorrowerID'] as String,
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
      mobileNumber: json['MobileNumber'] as String,
      homeAddress: json['HomeAddress'] as String,
      balance: json['Balance'] as double,
      qrCode: json['QRCode'] as String,
      contractImage: json['ContractImage'] as String,
    );
  }

  factory Borrower.fromJsonPartial(Map<String, dynamic> json) {
    return Borrower.fullJsonPartial(
      borrowerId: json['BorrowerID'] as String,
      firstname: json['Firstname'] as String,
      lastname: json['Lastname'] as String,
      mobileNumber: json['MobileNumber'] as String,
      homeAddress: json['HomeAddress'] as String,
      balance: json['Balance'] as double,
    );
  }
}
