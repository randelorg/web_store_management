import 'package:intl/intl.dart';

class PaymentHistoryModel {
  int? collectionID;
  String? givenDate;
  double? collectionAmount;

  get getCollectionID => this.collectionID;

  set setCollectionID(int collectionID) => this.collectionID = collectionID;

  get getCollectionAmount => this.collectionAmount;

  set setCollectionAmount(double collectionAmount) =>
      this.collectionAmount = collectionAmount;

  get getGivenDate => convertDateTimeDisplay(this.givenDate.toString());

  set setGivenDate(String givenDate) => this.givenDate = givenDate;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  PaymentHistoryModel.empty();

  PaymentHistoryModel.full({
    this.collectionID,
    this.collectionAmount,
    this.givenDate,
  }) {
    this.collectionID = collectionID;
    this.collectionAmount = collectionAmount;
    this.givenDate = givenDate;
  }

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryModel.full(
      collectionID: json['CollectionID'] as int,
      collectionAmount: json['CollectionAmount'] as double,
      givenDate: json['GivenDate'] as String,
    );
  }
}
